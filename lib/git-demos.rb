class GitDemos

	attr_reader :log

	def initialize dir
		@basedir = dir
		@current_path = []
		@log = []
	end

	def init
		@log << { desc: "Initialize demo directory in '#{@basedir}'." }
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

	def cd directory
		@log << { desc: "Change directory to '#{directory}'." }		
		@current_path << directory
	end

	def to_markdown
		s = ""
		@log.each do |entry|
			s << entry[:desc] << "\n"
			if entry[:shell] && !entry[:shell].empty?
				s << "\n"
				entry[:shell].each { |cmd| s << "    " << cmd << "\n" } 
			end
			s << "\n"
		end
		s
	end

	def _shell shell_command
		base = @basedir
		pwd = ([base] << @current_path).join('/')

		cmd = "cd #{pwd}"
		cmd << " && #{shell_command}"

		relative = @current_path.join('/')
		relative << ' ' unless @current_path.empty?
		@log.last[:shell] = [ "#{relative}$ #{shell_command}" ]
		`#{cmd}`		
	end
end