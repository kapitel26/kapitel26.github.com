
class AbstractRenderer
	

	def initialize(io)
		@io = io
		@show = [:comment, :command, :out, :err]
	end

	def flush
		@io.flush
	end

	def show elements_to_show
		@show = elements_to_show
	end

	def comment(s)
		render_comment(s) if @show.include? :comment
	end

	def commandline(command, out, err)
		render_commandline(command, out, err) 
	end

	def direct text
		render_direct(text) if @show.include? :comment
	end

	protected

	def render_comment(s)
	end

	def render_commandline(command, out, err)
		render_command(command) if @show.include? :command
		render_output(out) if @show.include? :out
		render_err(err) if @show.include? :err
	end

	def render_command(command)
	end

	def render_output(out)
	end

	def render_err(err)
	end

	def render_direct text
	end

end

class MarkdownRenderer < AbstractRenderer
	def render_comment(s)
		@io.puts "    # #{s}"
		@io.puts "    "
	end

	def render_commandline(command, out, err)
		super
		@io.puts "    " if @show.include? :command
	end

	def render_command(command)
		prompt = "> "
		command.split("\n").each do |line|
			@io.write "    #{prompt}#{line}\n"
			prompt = "  "
		end
	end

	def render_output(out)
		@io.puts indent(out) unless out.empty?
	end

	def render_err(err)
		@io.puts indent(err) unless err.empty?
	end

	def render_direct text
		@io.puts text
		@io.puts
	end

	# private

	def indent(text)
		text.lines.map { |l| "    #{l}" }.join
	end
end

class PlainRenderer < AbstractRenderer
	def render_comment(s)
		@io.puts s
	end

	def render_command(command)
		@io.puts "> #{command}"
	end

	def render_output(out)
		@io.puts out unless out.empty?
	end

	def render_err(err)
		@io.puts err unless err.empty?
	end

	def render_direct text
		@io.puts text
	end
end
