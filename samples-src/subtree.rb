# encoding: UTF-8

FileUtils.rm_rf 'workspaces/subtree'

@demo = GitDemos.new('workspaces/subtree')
@demo.section do

	action '### Projekt mit Verzeichnissen "wurst" und "kaese erzeugen"'

	new_repo 'project'
	cd 'project'
	create_file 'wurst/salami'
	shell 'git add --all'
	shell 'git commit -m "create directory wurst with file salami"'

	create_file 'kaese/gouda'
	shell 'git add kaese/gouda'
	shell 'git commit -m "create file gouda"'

	shell 'echo EDIT >> wurst/salami'
	shell 'git commit -am "edit file salami"'

	shell 'echo EDIT >> kaese/gouda'
	shell 'echo EDIT >> wurst/salami'
	shell 'git commit -am "edit file gouda wurst and gouda"'

	create_file 'kaese/edamer'
	shell 'git add kaese/edamer'
	shell 'git commit -am "create file edamer"'

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

