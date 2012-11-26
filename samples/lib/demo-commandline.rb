require "fileutils"
require "bash-wrapper"

class AbstractRenderer
	

	def initialize(io)
		@io = io
		@show = [:comment, :command, :out, :err]
	end

	def flush
		@io.flush
	end

	def show elements_to_show
		@show = elements_to_show
	end

	def comment(s)
		render_comment(s) if @show.include? :comment
	end

	def commandline(command, out, err)
		render_commandline(command, out, err) 
	end

	def direct text
		render_direct(text) if @show.include? :comment
	end

	protected

	def render_comment(s)
	end

	def render_commandline(command, out, err)
		render_command(command) if @show.include? :command
		render_output(out) if @show.include? :out
		render_err(err) if @show.include? :err
	end

	def render_command(command)
	end

	def render_output(out)
	end

	def render_err(err)
	end

	def render_direct text
	end

end

class MarkdownRenderer < AbstractRenderer
	def render_comment(s)
		@io.puts "    # #{s}"
		@io.puts "    "
	end

	def render_commandline(command, out, err)
		super
		@io.puts "    " if @show.include? :command
	end

	def render_command(command)
		prompt = "> "
		command.split("\n").each do |line|
			@io.write "    #{prompt}#{line}\n"
			prompt = "  "
		end
	end

	def render_output(out)
		@io.puts indent(out) unless out.empty?
	end

	def render_err(err)
		@io.puts indent(err) unless err.empty?
	end

	def render_direct text
		@io.puts text
		@io.puts
	end

	private

	def indent(text)
		text.lines.map { |l| "    #{l}" }.join
	end
end

class PlainRenderer < AbstractRenderer
	def render_comment(s)
		@io.puts s
	end

	def render_command(command)
		@io.puts "> #{command}"
	end

	def render_output(out)
		@io.puts out unless out.empty?
	end

	def render_err(err)
		@io.puts err unless err.empty?
	end

	def render_direct text
		@io.puts text
	end
end

class DemoCommandline

	def initialize(renderer = PlainRenderer.new($stdout), &block)
		block ||= lambda {}
		@renderer = renderer
		@main_renderer = renderer
		@root="sample1"
		@edit_nr = 1
		FileUtils::rm_rf @root
		FileUtils::mkdir @root
		@ba = BashWrapper.new
		@ba.sh "cd #{@root}"

		self.instance_eval &block

		flush
	end

	def flush
		@renderer.flush
	end

	def sh command, options = {}
		out, err, exitcode = silent_sh command, options
		@renderer.commandline command, out, err
	end

	def silent_sh command, options = {}
		options = {:valid_exits => [0]}.merge options

		out, err, exitcode = @ba.sh "#{command}"

		unless options[:valid_exits].include? exitcode
			$stdout.puts out unless out.empty?
			$stderr.puts err unless err.empty?
			raise "command exited with #{exitcode} #{command}"
		end
		
		[out, err, exitcode]
	end

	def comment text
		@renderer.comment "# #{text}"
	end

	def direct text
		@renderer.direct text
	end

	def edit(filepath, options = {})
		opts = {:line_numbers => [], :commit => true}.merge(options)

		lines = exists?(filepath) ? File.new(fullpath(filepath)).lines.to_a : []
	
		prefix = exists?(filepath) ? "Edit" : "Create"
		line_nr_string = opts[:line_numbers].empty? ? "" : "line #{opts[:line_numbers].join ','} in "
		comment = "#{prefix} #{line_nr_string}file \"#{filepath}\""
		message = "#{comment} /#{@edit_nr}"

		if opts[:content].nil?
			opts[:content] = edit_lines(lines, opts[:line_numbers], message).join() 
		end
		
		File.open(fullpath(filepath), "w") { |f| f << opts[:content] }

		@renderer.comment comment

		if opts[:commit]
			silent_sh "hg commit -A -m \"#{comment}\"" 
		end
	end

	def show elements_to_show = [:comment, :command, :out, :err]
		@renderer.show elements_to_show
	end

	private

	def exists? filepath
		File.exists?(fullpath(filepath))
	end

	def fullpath(ext)
		"#{@root}/#{ext}"
	end

	def open_file(filepath, mode = "r", &block)
		File.open(filepath, mode, &block)
	end

	def edit_lines(lines, line_numbers, message)
		line_numbers = [lines.size] if line_numbers.empty?
		@edit_nr += 1

		line_numbers.each do |nr| 
			lines[nr] = "#{nr}: #{message}\n" 
		end
		lines.map { |line| line ||= "\n" }
	end
end
