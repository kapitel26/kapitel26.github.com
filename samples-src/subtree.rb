# encoding: UTF-8

FileUtils.rm_rf 'workspaces/subtree'

@demo = GitDemos.new('workspaces/subtree')
@demo.section do

	new_repo 'project'
	cd 'project'

	create_file 'wurst/salami'
	create_file 'kaese/gouda'
	create_file 'kaese/edamer'
	shell 'git add --all'

	shell 'git commit -m "initial project layout"'

	shell 'git log --oneline'

end

