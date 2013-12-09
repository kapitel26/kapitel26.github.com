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
		
		shell_command = "git init #{repo_dir}"

		cmd = "cd #{@basedir}"
		cmd << " && #{shell_command}"

		@log.last[:shell] = [ " $ #{shell_command}" ]
		`#{cmd}`
	end
end