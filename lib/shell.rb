module Shell

	def shell shell_command, desc = nil
		action desc || "Execute shell command '#{shell_command}'."
		_shell shell_command
	end

	def _shell shell_command
		cmd = "cd #{pwd} && #{shell_command}"
		output, err, process = Open3.capture3(cmd)
		# TODO record err and exitcode

		relative = @current_path.join('/')
		relative << ' ' unless @current_path.empty?

		append_to_log :shell,  "#{relative}$ #{shell_command}"
		output.lines.each { |l| append_to_log :out, l.rstrip }

		@log.last[:out]
	end

end