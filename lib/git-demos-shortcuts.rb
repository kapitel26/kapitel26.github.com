require "fileutils"
require "rubygems"
require "maruku"

module GitDemosShortcuts

	def new_repo repo_dir
		shell "git init #{repo_dir}", "Create new repository in '#{repo_dir}'."
	end

	def create_and_commit file
		action "Create and edit '#{file}'."
		_create file
		_shell "git add #{file}"
		_shell "git commit -m 'created new file #{file}'"
	end

end