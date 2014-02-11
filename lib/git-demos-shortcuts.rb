require "fileutils"
require "rubygems"
require "maruku"

module GitDemosShortcuts

	def new_repo repo_dir
		shell "git init #{repo_dir}", "Create new repository in '#{repo_dir}'."
	end

	def create_and_commit file
		description "Create and edit '#{file}'."
		_create file
		_shell "git add #{file}"
		_shell "git commit -m 'create #{file}'"
	end

	def edit_and_commit *files
		description "Edit and commit #{files.join(', ')}."
		_edit *files
		_shell "git add #{files.join(' ')}"
		_shell "git commit -m 'edit #{files.join(', ')}'"
	end

	def gitlog param = ""
		shell <<-EOS
branch=`git rev-parse --abbrev-ref HEAD`; \
	echo \"-- Branch '$branch' in '#{pwd}' --\"; \
	git log --graph --pretty=\"%s %d\" #{param}
		EOS
	end

	def show_all
		show :text, :shell, :out, :desc
	end

	def hide_output
		show :text, :shell
	end

	def hide_shell
		show :text, :out
	end


end