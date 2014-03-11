module Shell

	def shell shell_command
		@log << {}
		_shell shell_command
	end

	def _shell shell_command
		cmd = "cd #{working_dir} && #{shell_command}"
		output, err, process = Open3.capture3(cmd)

		exitcode = process.exitstatus
		if exitcode != 0
			raise "Error #{exitcode} while executing #{cmd}\n---stdout---\n#{output}---stderr---\n#{err}------------"
		end

		# TODO record err

		relative = @current_path.join('/')
		relative << ' ' unless @current_path.empty?

		append_to_log :shell,  "#{relative}$ #{shell_command}"
		output.lines.each { |l| append_to_log :out, l.rstrip }

		@log.last[:out]
	end

end