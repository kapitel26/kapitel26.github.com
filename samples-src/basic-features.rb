# encoding: UTF-8

require "rubygems"
require "maruku"


@demo = GitDemos.new('tmp/demo')
@demo.section do
	init
	new_repo 'my-little-repo'
	cd 'my-little-repo'
	shell 'touch wurst'
	markdown '## Und hier so Sachen machen'
	shell 'ls -lah'
	shell 'echo MOIN'
end

@demo.to_markdown('tmp/basic-features.html')
