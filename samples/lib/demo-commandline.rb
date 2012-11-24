require "fileutils"
require "bash-wrapper"

class PlainRenderer
	def initialize(io)
		@io = io
	end

	def comment(s)
		@io.puts s
	end

	def commandline(command, out, err)
		@io.puts "> #{command}"
		@io.puts out unless out.empty?
		@io.puts err unless err.empty?
	end

	def flush
		@io.flush
	end
end

class DemoCommandline

	def initialize(renderer = PlainRenderer.new($stdout), &block)
		block ||= lambda {}
		@renderer = renderer
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

	def edit(filepath, options = {})
		opts = {:line_numbers => [], :commit => true}.merge(options)

		lines = exists?(filepath) ? File.new(fullpath(filepath)).lines.to_a : []
	
		prefix = exists?(filepath) ? "Edited" : "Created"
		message = "#{prefix} file #{filepath} lines #{opts[:line_numbers].inspect} (edit nr. #{@edit_nr})"

		if opts[:content].nil?
			opts[:content] = edit_lines(lines, opts[:line_numbers], message).join() 
		end
		
		File.open(fullpath(filepath), "w") { |f| f << opts[:content] }

		if opts[:commit]
			sh "hg commit -A -m \"#{message}\"" 
		end
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
