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
		_shell "git commit -m 'create new file #{file}'"
	end

	def edit_and_commit *files
		description "Edit and commit #{files.join(', ')}."
		_edit *files
		_shell "git add #{files.join(' ')}"
		_shell "git commit -m 'edit file #{files.join(', ')}'"
	end

end