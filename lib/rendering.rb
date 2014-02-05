
def split_command line
	/(.*\$) (.*)/.match(line)
	[$1,$2]
end


module Rendering

	def create_renderers
		{
			text: lambda { |data| normal; @out << data << "\n"  },
			desc: lambda { |data| normal; @out << "    # " << data << "\n"  },
			shell: lambda { |data| code; data.each { |l| prompt, cmd = split_command(l); @out << "#{prompt} <b>#{cmd}</b>\n" } },
			out: lambda { |data| code; data.each { |outputline| @out << outputline << "\n" }  },
		}
	end

	def to_markdown to_html_file = nil
		@renderers ||= create_renderers
		@out = ""
		show_these_only = Set.new(@renderers.keys)

		@log.each do |entry| 
			show_these_only = entry[:show] if entry[:show]
			@renderers.each_pair do |type, renderer|
				renderer[entry[type]] if entry[type] && show_these_only.include?(type)
			end
		end

		normal
		
		File.write(to_html_file, Maruku.new(@out).to_html_document) if to_html_file
	
		@out
	end

	def show *types_to_show
		@log << { show: types_to_show }
	end

	def code
		unless @pre
			@out << "<pre>\n"
			@pre = true
		end	
	end

	def normal
		if @pre
			@out << "</pre>\n"
			@pre = nil
		end
	end

end