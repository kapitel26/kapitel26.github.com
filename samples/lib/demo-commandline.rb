require "fileutils"
require "bash-wrapper"

class DemoCommandline

	def initialize(&block)
		@root="sample1"
		@edit_nr = 1
		FileUtils::rm_rf @root
		FileUtils::mkdir @root
		@ba = BashWrapper.new

		self.instance_eval &block

		$stdout.flush

	end

	def fullpath(ext = nil)
		if ext.nil?
			@root
		else
			"#{@root}/#{ext}"
		end
	end

	def sh command
		# puts "> #{command}"
		# puts
		out, err, exitcode = @ba.sh "cd #{fullpath}; #{command}"
		out.each_line do |line|
			puts "  #{line}"
		end
		# puts unless out.empty?
	end

	def comment text
		puts "# #{text}"
	end

	def edit(filepath, options = {})
		opts = {:line_numbers => [], :commit => true}.merge(options)

		if File.exists?(fullpath(filepath))
			lines = File.new(fullpath(filepath)).lines.to_a
			message = "Edited"
		else
			lines = []
			message = "Created"
		end

		message << " file #{filepath} lines #{opts[:line_numbers].inspect} (edit nr. #{@edit_nr})"

		if opts[:content].nil?
			opts[:content] = edit_lines(lines, opts[:line_numbers], message).join() 
		end
		
		open_file(fullpath(filepath), "w") { |f| f << opts[:content] }

		if opts[:commit]
			sh "hg commit -A -m \"#{message}\"" 
		end
	end

	private

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
