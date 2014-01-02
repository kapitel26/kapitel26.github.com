require "fileutils"
require "rubygems"
require "maruku"

class GitDemos

	attr_reader :log

	def initialize dir
		@basedir = dir
		@current_path = []
		@log = []

		@log << { desc: "Initialize demo directory in '#{@basedir}'." }
		FileUtils.mkdir_p @basedir
	end

	def new_repo repo_dir
		shell "git init #{repo_dir}", "Create new repository in '#{repo_dir}'."
	end

	def shell shell_command, desc = nil
		desc ||= "Execute shell command '#{shell_command}'."
		@log << { desc: desc }
		relative = @current_path.join('/')
		relative << ' ' unless @current_path.empty?
		@log.last[:shell] = [ "#{relative}$ #{shell_command}" ]
		cmd = "cd #{pwd} && #{shell_command}"
		output = `#{cmd}`
		@log.last[:out] = output.lines.map { |l| l.rstrip }
	end

	def cd directory
		@log << { desc: "Change directory to '#{directory}'." }
		if directory == ".." 
			@current_path.pop
		else
			@current_path << directory
		end
	end

	def create_file filename
		@log << { desc: "Create new file '#{filename}'." }		
		content = (1..12).collect { |i| "#{i} egal" }.join("\n")
		fullpath = pwd << "/" << filename
		FileUtils.mkdir_p(File.dirname(fullpath))
		File.write(fullpath, content)
	end

	def pwd
		([@basedir] << @current_path).join('/')
	end

	def section &block
		instance_eval &block
	end

	def markdown content
		@log << { desc: content }		
	end

	def to_markdown file = nil
		s = ""
		@log.each do |entry|
			s << entry[:desc] << "\n"
			if entry[:shell] && !entry[:shell].empty?
				s << "\n"
				entry[:shell].each { |cmd| s << "    " << cmd << "\n" }
				if entry[:out]
					entry[:out].each { |outputline| s << "    " << outputline << "\n" }
				end
			end
			s << "\n"
		end
		if file
			maruku = Maruku.new(s)
			html = maruku.to_html
			File.write(file, html)
		end
		s
	end

end