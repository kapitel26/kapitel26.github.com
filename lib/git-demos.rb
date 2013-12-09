class GitDemos

	attr_reader :log

	def initialize dir
		@basedir = dir
		@log = []
	end

	def init
		@log << { desc: "Initialize demo directory in '#{@basedir}'" }
		FileUtils.mkdir_p @basedir
	end

	def new_repo repo_dir
		@log << { desc: "Create new repository in '#{repo_dir}'." }		
		_shell "git init #{repo_dir}"
	end

	def shell shell_command
		@log << { desc: "Execute shell command '#{shell_command}'." }		
		_shell shell_command
	end

	def _shell shell_command
		cmd = "cd #{@basedir}"
		cmd << " && #{shell_command}"

		puts cmd

		@log.last[:shell] = [ " $ #{shell_command}" ]
		`#{cmd}`		
	end
end