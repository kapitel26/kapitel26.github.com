#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.dirname(__FILE__)+"/lib")

require "commandline-sample-maker"

def hg command
	sh "hg #{command}"
end

def hg_merge(p)
	p[:branch] ||= silent_sh("hg branch")[0]
	hg "up #{p[:onto]}"
	hg "merge #{p[:branch]}"
	hg "commit -m 'merge #{p[:branch]} onto #{p[:onto]}'"
end

def hg_graft(p)
	p[:rev] ||= "."
	hg "up #{p[:onto]}"
	hg "graft -r #{p[:rev]}"
end

File.open("../_includes/samples/#{__FILE__}.md", "w") do |io|

	DemoCommandline.new(MarkdownRenderer.new($stdout)) do
#	DemoCommandline.new(MarkdownRenderer.new(io)) do
#		hide

		hg 'init'

		hg 'branch releases'
		edit '.hg/hgrc', 
			:content =>"[ui]\nlogtemplate=\"{branches}: {desc|firstline}\\n\"\n"

		edit 'hello', :line_numbers => [0,1,2,3,4,5]

		hg 'branch FIX_merge_before'
		edit 'hello'
		hg_merge :onto => "releases"

		hg 'branch FIX_graft_before'
		edit 'hello'
		hg_graft :rev => "FIX_graft_before", :onto => "releases"

		hg 'tag release_1_1_3'

		show
		direct <<-eos
BlaBla
		eos

		hg 'log --graph'
	end
end