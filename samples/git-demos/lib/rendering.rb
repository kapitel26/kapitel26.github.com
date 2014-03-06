require "cgi"

def split_command line
	/(.*\$) (.*)/.match(line)
	[$1,$2]
end

module Rendering

	def create_renderers
		{
			text: lambda { |data| normal; @out << data << "\n"  },
			shell: lambda { |data| code; data.each { |l| prompt, cmd = split_command(l); @out << "#{prompt} <b>#{escape(cmd)}</b>\n" } },
			out: lambda { |data| code; data.each { |outputline| @out  << escape(outputline) << "\n" }  },
		}
	end

	def to_markdown to_html_file = nil
		@out = ""
		show_these_only = Set.new(renderers.keys)

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

	def renderers
		@renderers ||= create_renderers
	end

	def show *types_to_show
		last_types_shown = @log.collect { |l| l[:show] }.reject { |s| s.nil? }.last
		@log << { show: types_to_show }
		if block_given?
			yield
			@log << { show: ( last_types_shown || Set.new(renderers.keys)) } 
		end
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

	def escape(some_string)
		CGI::escapeHTML(some_string)
	end

end