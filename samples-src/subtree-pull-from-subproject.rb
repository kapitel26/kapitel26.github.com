# encoding: UTF-8

samplename = 'subtree-pull-from-subproject'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do


	hide :out, :shell, :desc
	shell 'git init --bare kaese.git'

	createSubtreeSampleMainProject(self)

	show :out
	shell <<-__ 
rev=$(git subtree split --prefix kaese --rejoin) 
git push ../kaese.git $rev:refs/heads/master 
	__
	hide :out, :shell
	cd '..'
	shell 'git clone kaese.git kaese'

	text <<-__
Änderungen aus einem Teilprojekt mit eigenem Repository abholen
----------------------------------------------------------------

### Ausgangsituaution

Im Teilprojekt `kaese` sind zwei neue Commits entstanden,
die im Gesamtprojekt `lecker` noch nicht bekannt sind.
	__
	cd 'kaese'
	create_and_commit 'brie'
	edit_and_commit 'gouda', 'brie'
	show :out
	shell 'echo -- kaese -- ; git log --all --pretty="%s %d"'
	
	text <<-__
diese Commits sollen im `lecker`-Projekt in den Ordner `kaese`
nachgeholt werden.

### Der Befehl `git subtree pull`
	__
	cd '..'; cd 'lecker'
	show :shell, :out
	shell 'git subtree pull --prefix kaese ../kaese master'

	text "### Was ist pasiert"

	hide :shell; show :out 

	shell 'echo -- kaese -- ; git log --graph --all --pretty="%s %d"'


end

