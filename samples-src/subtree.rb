# encoding: UTF-8

FileUtils.rm_rf 'workspaces/subtree'

@demo = GitDemos.new('workspaces/subtree')
@demo.section do

	markdown '### Projekt mit Verzeichnissen "wurst" und "kaese erzeugen"'
	new_repo 'project'
	cd 'project'
	create_file 'wurst/salami'
	shell 'git add --all'
	shell 'git commit -m "create directory wurst with file salami"'
	create_file 'kaese/gouda'
	create_file 'kaese/edamer'
	shell 'git add --all'
	shell 'git commit -m "create directory kaese with files gouda and edamer"'
	cd '..'

	markdown '### leeres Repo "kaese.git" erzeugen'
	shell 'git init --bare kaese.git'

	markdown '### Änderungen nach kaese splitten'
	cd 'project'
	shell 'git subtree push --prefix kaese ../kaese.git master'
	shell 'git log --oneline'

	cd '..'
	cd 'kaese.git'
	shell 'git log --oneline'

	# shell 'git log --oneline'

end

