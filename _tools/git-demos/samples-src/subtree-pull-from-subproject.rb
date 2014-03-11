# encoding: UTF-8

samplename = 'subtree-pull-from-subproject'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do

	show []
	shell 'git init --bare kaese.git'

	createSubtreeSampleMainProject(self)
	createCreateAndCloneSubprojectKaese(self)


	show :text
	text <<-__
Änderungen aus einem Teilprojekt mit eigenem Repository abholen
----------------------------------------------------------------

### Ausgangsituaution

Ein Teilprojekt `kaese` wurde aus dem Gesamtprojekt `lecker`
herausgelöst.
	__

	cd 'lecker'
	show :out, :text
	gitlog 
	show :text
	cd '..'

	text <<-__
Im Projekt `kaese` sind inzwischen zwei neue Commits entstanden,
diese sollen im Projekt `lecker`, wo `kaese` ein Subtree ist,
übernommen werden.
	__

	shell 'git clone kaese.git kaese'
	cd 'kaese'
	create_and_commit 'brie'
	edit_and_commit 'gouda', 'brie'
	show :out, :text
	gitlog 
	
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
	gitlog

end