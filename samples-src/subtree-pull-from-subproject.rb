# encoding: UTF-8

samplename = 'subtree-pull-from-subproject'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do


	show []
	shell 'git init --bare kaese.git'

	createSubtreeSampleMainProject(self)

	shell <<-__ 
rev=$(git subtree split --prefix kaese --rejoin) 
git push ../kaese.git $rev:refs/heads/master 
	__
	cd '..'
	shell 'git clone kaese.git kaese'

	show :text
	text <<-__
Änderungen aus einem Teilprojekt mit eigenem Repository abholen
----------------------------------------------------------------

### Ausgangsituaution

Im Projekt `kaese` sind zwei neue Commits entstanden,
diese sollen im Projekt `lecker`, wo `kaese` ein Subtree ist,
übernommen werden.
	__
	cd 'kaese'
	create_and_commit 'brie'
	edit_and_commit 'gouda', 'brie'
	show :out, :text
	shell 'echo -- kaese -- ; git log  --all --pretty="%s %d" -3'
	
	text <<-__
### Der Befehl `git subtree pull`
	__
	cd '..'; cd 'lecker'
	show :shell, :text
	shell 'git subtree pull --prefix kaese ../kaese master'

	text <<-__
### Was ist pasiert"
	__

	show :out 
	shell 'echo -- lecker -- ; git log --graph --all --pretty="%s %d"'


end

