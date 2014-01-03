# encoding: UTF-8

FileUtils.rm_rf 'workspaces/subtree'

@demo = GitDemos.new('workspaces/subtree')
@demo.section do

	action '### Projekt mit Verzeichnissen "wurst" und "kaese erzeugen"'

	new_repo 'project'
	cd 'project'
	create 'wurst/salami'
	shell 'git add --all'
	shell 'git commit -m "create directory wurst with file salami"'

	create 'kaese/gouda'
	shell 'git add kaese/gouda'
	shell 'git commit -m "create file gouda"'

	edit 'wurst/salami'
	shell 'git commit -am "edit file salami"'

	edit 'kaese/gouda'
	edit 'wurst/salami'
	shell 'git commit -am "edit file gouda wurst and gouda"'

	create 'kaese/edamer'
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

