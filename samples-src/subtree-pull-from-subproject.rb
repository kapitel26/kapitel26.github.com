# encoding: UTF-8

samplename = 'subtree-pull-from-subproject'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do

	text <<-__
Änderungen aus einem Teilprojekt mit eigenem Repository abholen
----------------------------------------------------------------

	__


	#hide :out, :shell, :desc
	createSubtreeSampleMainProject(self)

	shell 'git init --bare ../kaese.git'
	shell 'git subtree push --prefix kaese ../kaese.git master'
	cd '..'

	shell 'git clone kaese.git kaese'
	cd 'kaese'
	
	# show :out, :shell, :desc
	# shell 'git checkout master'
	shell 'ls -lah'
	edit_and_commit 'gouda'
	edit_and_commit 'gouda', 'edamer'
	shell 'git log --oneline'

	text "### schluss"


end

