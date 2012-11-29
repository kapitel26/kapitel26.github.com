require "fileutils"
require "bash-wrapper"
require "renderer"
require "mercurial-extension"

class DemoCommandline

	include MercurialExtension

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
		[out, err, command, exitcode]
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
		opts = {:line_numbers => [], :commit => true, :on_branch => nil}.merge(options)
	
		branch = opts[:on_branch]
		hg_to_branch(branch) unless branch.nil?

		file = fullpath(filepath)
		comment = create_comment(file, opts[:line_numbers])
		message = "#{comment} /#{@edit_nr}"
		opts[:content] ||=  edited_content(file, opts[:line_numbers], message)
		File.open(file, "w") { |f| f << opts[:content] }

		@renderer.comment comment

		hg_commit comment if opts[:commit]
	end

	def edited_content(file, line_numbers, message)
		lines = File.exists?(file) ? File.new(file).lines.to_a : []
		message = "#{create_comment(file, line_numbers)} /#{@edit_nr}"
		edit_lines(lines, line_numbers, message).join() 
	end

	def create_comment(file, line_numbers)
		prefix = File.exists?(file) ? "Edit" : "Create"
		line_nr_string = line_numbers.empty? ? "" : "line #{line_numbers.join ','} in "
		"#{prefix} #{line_nr_string}file \"#{File.basename(file)}\""
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
