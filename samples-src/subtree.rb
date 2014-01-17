# encoding: UTF-8

FileUtils.rm_rf 'workspaces/subtree'

@demo = GitDemos.new('workspaces/subtree')

@demo.section do

	text <<-EOS
Ein Teilprojekt aus einem großen Projekt herausziehen
-----------------------------------------------------


### Ein Projekt aus mehreren Modulen
	EOS

	hide :desc, :shell, :out

	new_repo 'project'
	cd 'project'
	create_and_commit 'wurst/salami'
	create_and_commit 'kaese/gouda'

	edit_and_commit 'wurst/salami'
	edit_and_commit 'kaese/gouda', 'wurst/salami'

	create_and_commit 'kaese/edamer'

	show :out, :shell
	shell 'git log --oneline'
	hide :out

	text '### leeres Repo "kaese.git" erzeugen'
	cd '..'
	show 
	shell 'git init --bare kaese.git'

	text '### Änderungen nach kaese splitten'
	cd 'project'
	shell 'git subtree push --prefix kaese ../kaese.git master'

	cd '..'
	cd 'kaese.git'

	shell 'git log --oneline'

	# shell 'git log --oneline'

end

