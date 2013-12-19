# encoding: UTF-8

@demo = GitDemos.new('tmp/demo')
@demo.section do

	markdown <<-EOS
## Markdown

You can add *Markown*.
	EOS

	shell 'echo Hello World!'

	new_repo 'repo'

	cd 'repo'

	create_file 'wurst'

	shell 'git add --all'
	shell 'git commit -m "first commit"'
	shell 'git log --oneline'


end

