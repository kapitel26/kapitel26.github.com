module Files

	def create filename
		action "Create new file '#{filename}'."
		_create filename
	end

	def _create filename
		content = (1..12).collect { |i| "#{i} egal" }.join("\n")
		fullpath = pwd << "/" << filename
		FileUtils.mkdir_p(File.dirname(fullpath))
		File.write(fullpath, content)
	end

	def edit *filenames
		action "Edit files #{filenames.join(', ')}."
		_edit *filenames
	end

	def _edit *filenames
		filenames.each do |filename|
			fullpath = pwd << "/" << filename
			content = File.read(fullpath)
			content << "#{content.lines.to_a.length + 1} edited\n"
			File.write(fullpath, content)
		end
	end

end