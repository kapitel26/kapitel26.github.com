module Rendering

	TYPES = [:text, :desc, :shell, :out]

	def to_markdown file = nil
		@renderers ||= {
			text: lambda { |s, data| s << data << "\n"  },
			desc: lambda { |s, data| s << "    # " << data << "\n"  },
			shell: lambda { |s, data| data.each { |cmd| s << "    " << cmd << "\n" } },
			out: lambda { |s, data| data.each { |outputline| s << "    " << outputline << "\n" }  }
		}

		s = ""
		@log.each do |entry|
			TYPES.reject { |type| entry[type].nil? }.
				map { |type| @renderers[type].call(s,entry[type]) }
		end
	
		if file
			maruku = Maruku.new(s)
			html = maruku.to_html
			File.write(file, html)
		end
		s
	end

end