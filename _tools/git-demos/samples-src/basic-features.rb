# encoding: UTF-8

FileUtils.rm_rf "tmp/demo"
@demo = GitDemos.new('tmp/demo')
@demo.section do

	text <<-EOS
## Markdown

You can add *Markown*.
	EOS

	shell 'echo Hello World!'

	new_repo 'repo'

	cd 'repo'

	create 'wurst'

	shell 'ls'

	shell 'git add --all'

	shell 'git commit -m "first commit"'
	shell 'git log --oneline'

end
