# encoding: UTF-8

samplename = 'subtree-pull-from-subproject'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do

	shell 'git init --bare kaese.git'

	hide :out, :shell, :desc
	createSubtreeSampleMainProject(self)
#	createCreateAndCloneSubprojectKaese(self)
	show :out, :shell, :desc
	shell <<-__ 
rev=$(git subtree split --prefix kaese --rejoin) 
git push ../kaese.git $rev:refs/heads/master 
	__
	shell 'git log --oneline --graph --all'

	cd '..'
	shell 'git clone kaese.git kaese'
	
	text <<-__
Änderungen aus einem Teilprojekt mit eigenem Repository abholen
----------------------------------------------------------------

Im Teilprojekt `kaese` wurden zwei Commits erstellt, 
diese Commits sollen im `lecker`-Projekt in den Ordner `kaese`
nachgeholt werden.
	__



	cd 'kaese'
	create_and_commit 'brie'
	edit_and_commit 'gouda', 'brie'
	shell 'pwd'
	shell 'git log --oneline --decorate=short'

	text <<-__
`subtree pull`
--------------
	__
	cd '..'; cd 'lecker'
	show :shell, :out
	shell 'git status'
	shell 'pwd'
	shell 'git log --oneline --decorate'
	shell 'git subtree pull --prefix kaese ../kaese master'

	shell 'git log --oneline --graph --all'

	shell 'git ls-tree master -r --name-only'

 	text "### schluss!"


end

