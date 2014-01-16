module Rendering


	RENDERERS = {
			text: lambda { |output, data| output << data << "\n"  },
			desc: lambda { |output, data| output << "    # " << data << "\n"  },
			shell: lambda { |output, data| data.each { |cmd| output << "    " << cmd << "\n" } },
			out: lambda { |output, data| data.each { |outputline| output << "    " << outputline << "\n" }  }
	}

	def to_markdown file = nil
		
		out = ""
		
		@log.each do |entry|
			RENDERERS.each_pair { |type, renderer| renderer[out, entry[type]] if entry[type] }
		end
	
		if file
			maruku = Maruku.new(out)
			html = maruku.to_html
			File.write(file, html)
		end

		out
	end

end