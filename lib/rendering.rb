module Rendering

	def to_markdown file = nil
		s = ""
		@log.each do |entry|
			s << entry[:text] << "\n" if entry[:text]

			s << "    # " << entry[:desc] << "\n" if entry[:desc]

			if entry[:shell] && !entry[:shell].empty?
				s << "\n"
				entry[:shell].each { |cmd| s << "    " << cmd << "\n" }
				if entry[:out]
					entry[:out].each { |outputline| s << "    " << outputline << "\n" }
				end
			end
			s << "\n"
		end
		
		if file
			maruku = Maruku.new(s)
			html = maruku.to_html
			File.write(file, html)
		end
		s
	end

end