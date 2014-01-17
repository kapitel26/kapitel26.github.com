module Rendering

	RENDERERS = {
			text: lambda { |output, data| output << data << "\n"  },
			desc: lambda { |output, data| output << "    # " << data << "\n"  },
			shell: lambda { |output, data| data.each { |cmd| output << "    " << cmd << "\n" } },
			out: lambda { |output, data| data.each { |outputline| output << "    " << outputline << "\n" }  },
	}

	def to_markdown to_html_file = nil
		
		out = ""
		show = RENDERERS.keys

		@log.each do |entry|
			if entry[:hide]
				show = show - entry[:hide]
			end
			RENDERERS.each_pair { |type, renderer| renderer[out, entry[type]] if entry[type] && show.include?(type) }
		end
	
		if to_html_file
			File.write(to_html_file, Maruku.new(out).to_html)
		end

		out
	end

	def hide *types_to_hide
		@log << { hide: types_to_hide }
	end

end