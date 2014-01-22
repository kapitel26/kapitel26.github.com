# encoding: UTF-8

samplename = 'subtree-pull-from-subproject'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do

	text <<-__
Änderungen aus einem Teilprojekt mit eigenem Repository abholen
----------------------------------------------------------------

	__

	shell 'git init kaese.git'

	#hide :out, :shell, :desc
	createSubtreeSampleMainProject(self)
	shell 'git subtree push --prefix kaese ../kaese.git master'
	shell 'git log --oneline'
	cd '..'
	shell 'git clone kaese.git kaese'
	cd 'kaese'
	
	show :out, :shell, :desc
	shell 'git checkout master'
	shell 'git log --oneline'
	shell 'ls -lah'
	#edit 'gouda'
	#edit 'gouda', 'edamer'

	text "### schluss"


end

