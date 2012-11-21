require "fileutils"
require "io/wait"

require "rubygems"
require "open4"

class DemoCommandline

	@@edit_nr = 1

	def initialize(&block)
		@root="sample1"
		FileUtils::rm_rf @root
		FileUtils::mkdir @root

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
		out = `cd #{fullpath}; #{command}` 
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
			message = "Created"
		else
			lines = []
			message = "Edited"
		end

		message << " file #{filepath}  lines #{opts[:line_numbers].inspect}  (edit nr. #{@@edit_nr})"

		if opts[:content].nil?
			opts[:content] = edit_lines(lines, opts[:line_numbers], message).join() 
		end
		
		open_file(fullpath(filepath), "w") { |f| f << opts[:content] }

		sh "hg commit -A -m \"#{message}\"" if opts[:commit]
	end

	private

	def open_file(filepath, mode = "r", &block)
		File.open(filepath, mode, &block)
	end

	def edit_lines(lines, line_numbers, message)
		line_numbers = [lines.size] if line_numbers.empty?
		line_numbers.each do |nr| 
			@@edit_nr += 1
			lines[nr] = "#{nr}: #{message}\n" 
		end
		lines.map { |line| line ||= "\n" }
	end
end
