require "fileutils"
require "rubygems"
require "maruku"

module GitDemosShortcuts

	def new_repo repo_dir
		shell "git init #{repo_dir}", "Create new repository in '#{repo_dir}'."
	end

end