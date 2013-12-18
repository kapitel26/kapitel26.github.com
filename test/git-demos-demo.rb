# encoding: UTF-8

require "rubygems"
require "maruku"

demo_file = 'demo.html'
puts "see the demo in #{demo_file}"
FileUtils.rm_rf 'tmp/demo'

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

out = @demo.to_markdown
maruku = Maruku.new(out)
html = maruku.to_html
File.write(demo_file, html)