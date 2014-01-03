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

	def shell shell_command, desc = nil
		action desc || "Execute shell command '#{shell_command}'."

		relative = @current_path.join('/')
		relative << ' ' unless @current_path.empty?
		@log.last[:shell] = [ "#{relative}$ #{shell_command}" ]
		cmd = "cd #{pwd} && #{shell_command}"
		output = `#{cmd}`
		@log.last[:out] = output.lines.map { |l| l.rstrip }
	end

	def action desc
		@log << { desc: desc }
	end

	def cd directory
		action "Change directory to '#{directory}'."

		if directory == ".." 
			@current_path.pop
		else
			@current_path << directory
		end
	end

	def create_file filename
		action "Create new file '#{filename}'."

		content = (1..12).collect { |i| "#{i} egal" }.join("\n")
		fullpath = pwd << "/" << filename
		FileUtils.mkdir_p(File.dirname(fullpath))
		File.write(fullpath, content)
	end

	def edit filename
		action "Edit file '#{filename}'."
		
		fullpath = pwd << "/" << filename
		content = File.read(fullpath)
		content << "#{content.lines.to_a.length + 1} edited\n"
		File.write(fullpath, content)
	end

	def pwd
		([@basedir] << @current_path).join('/')
	end

	def section &block
		instance_eval &block
	end

	### aliaes and shortcuts

	def new_repo repo_dir
		shell "git init #{repo_dir}", "Create new repository in '#{repo_dir}'."
	end

	### rendering

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