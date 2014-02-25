module Files

	def create filename, content = nil
		@log << {}
		_create filename, content
	end

	def _create filename, content = nil
		content ||= (1..12).collect { |i| "#{i} egal" }.join("\n")
		fullpath = working_dir << "/" << filename
		FileUtils.mkdir_p(File.dirname(fullpath))
		File.write(fullpath, content)
	end

	def edit *filenames
		@log << {}
		_edit *filenames
	end

	def _edit *filenames
		filenames.each do |filename|
			fullpath = working_dir << "/" << filename
			content = File.read(fullpath)
			content << "#{content.lines.to_a.length + 1} edited\n"
			File.write(fullpath, content)
		end
	end

end