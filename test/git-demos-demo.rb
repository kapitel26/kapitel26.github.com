# encoding: UTF-8

require "rubygems"
require "maruku"

demo_file = 'demo.html'
puts "see the demo in #{demo_file}"
FileUtils.rm_rf 'tmp/demo'

@demo = GitDemos.new('tmp/demo')
@demo.init
@demo.new_repo 'my-little-repo'
@demo.cd 'my-little-repo'
@demo.shell 'touch wurst'
@demo.shell 'ls -lah'

out = @demo.to_markdown
maruku = Maruku.new(out)
html = maruku.to_html
File.write(demo_file, html)