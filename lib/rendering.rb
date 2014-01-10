module Rendering

	def to_markdown file = nil
		s = ""
		@log.each do |entry|
			render_text(s, entry) if entry[:text]
			render_desc(s, entry) if entry[:desc]
			render_shell(s, entry) if entry[:shell]
			render_out(s, entry) if entry[:out]
			s << "\n"
		end
	
		if file
			maruku = Maruku.new(s)
			html = maruku.to_html
			File.write(file, html)
		end
		s
	end

	def render_text(s, entry)
		s << entry[:text] << "\n" 
	end

	def render_desc(s, entry)
		s << "    # " << entry[:desc] << "\n" 
	end

	def render_shell(s, entry)
		entry[:shell].each { |cmd| s << "    " << cmd << "\n" }
	end

	def render_out(s, entry)
		entry[:out].each { |outputline| s << "    " << outputline << "\n" } 
	end


end