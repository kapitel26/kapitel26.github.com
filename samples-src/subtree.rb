# encoding: UTF-8

FileUtils.rm_rf 'workspaces/subtree'

@demo = GitDemos.new('workspaces/subtree')

@demo.section do

	action '### Projekt mit Verzeichnissen "wurst" und "kaese erzeugen"'

	new_repo 'project'
	cd 'project'
	create_and_commit 'wurst/salami'
	create_and_commit 'kaese/gouda'

	edit_and_commit 'wurst/salami'
	edit_and_commit 'kaese/gouda', 'wurst/salami'

	create_and_commit 'kaese/edamer'

	shell 'git log --oneline'

	action '### leeres Repo "kaese.git" erzeugen'
	cd '..'
	shell 'git init --bare kaese.git'

	action '### Änderungen nach kaese splitten'
	cd 'project'
	shell 'git subtree push --prefix kaese ../kaese.git master'

	cd '..'
	cd 'kaese.git'
	shell 'git log --oneline'

	# shell 'git log --oneline'

end

