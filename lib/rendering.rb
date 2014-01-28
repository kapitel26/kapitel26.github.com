
def split_command line
	/(.*\$) (.*)/.match(line)
	[$1,$2]
end


module Rendering

	RENDERERS = {
		text: lambda { |output, data| output << data << "\n"  },
		desc: lambda { |output, data| output << "    # " << data << "\n"  },
		shell: lambda { |output, data| data.each { |l| prompt, cmd = split_command(l); output << "```#{prompt}``` **```#{cmd}```**\n\n" } },
		out: lambda { |output, data| data.each { |outputline| output << "    " << outputline << "\n" }  },
	}

	def to_markdown to_html_file = nil
		
		out = ""
		show_these_only = Set.new(RENDERERS.keys)

		@log.each do |entry| 
			show_these_only = entry[:show] if entry[:show]
			RENDERERS.each_pair do |type, renderer|
				renderer[out, entry[type]] if entry[type] && show_these_only.include?(type)
			end
		end
	
		if to_html_file
			File.write(to_html_file, Maruku.new(out).to_html_document)
		end

		out
	end

	def show *types_to_show
		@log << { show: types_to_show }
	end

end