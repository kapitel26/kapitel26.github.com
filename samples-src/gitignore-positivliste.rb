# encoding: UTF-8

samplename = 'gitignore-positivliste'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do

	text <<-__
`.gitignore`
------------
	__

	new_repo "repo"
	cd "repo"

	create "anton/file"
	create "berta/file1"
	create "berta/file2"
	create "carla/file"
	create "dieter"

	shell 'ls -lh'

	shell 'git status'


end

