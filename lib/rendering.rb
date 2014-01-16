module Rendering

	TYPES = [:text, :desc, :shell, :out]

	RENDERERS = {
			text: lambda { |output, data| output << data << "\n"  },
			desc: lambda { |output, data| output << "    # " << data << "\n"  },
			shell: lambda { |output, data| data.each { |cmd| output << "    " << cmd << "\n" } },
			out: lambda { |output, data| data.each { |outputline| output << "    " << outputline << "\n" }  }
	}

	def to_markdown file = nil
		

		output = ""
		@log.each do |entry|
			TYPES.reject { |type| entry[type].nil? }.
				map { |type| RENDERERS[type].call(output, entry[type]) }
		end
	
		if file
			maruku = Maruku.new(output)
			html = maruku.to_html
			File.write(file, html)
		end

		output
	end

end