#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.dirname(__FILE__)+"/lib")

require "commandline-sample-maker"

File.open("../_includes/samples/#{__FILE__}.md", "w") do |io|

#	DemoCommandline.new(MarkdownRenderer.new($stdout)) do
	DemoCommandline.new(MarkdownRenderer.new(io)) do
		show []

		hg 'init'

		hg 'branch releases'
		edit '.hg/hgrc', 
			:content =>"[ui]\nlogtemplate=\"{rev}@{branches}: {desc|firstline}\\n\"\n"

		edit 'hello', :line_numbers => [0,1,2,3,4,5]

		edit 'hello', :on_branch => 'FIX_merge_before'
		hg_merge :onto => "releases"

		edit 'hello', :on_branch => 'FIX_graft_before'
		hg_graft :onto => "releases"

		hg 'tag release_1_1_3'

		edit 'hello', :on_branch => 'FIX_merge_after'
		hg_merge :onto => "releases"

		edit 'hello', :on_branch => 'FIX_graft_after'
		hg_graft :onto => "releases"

		edit 'hello', :on_branch => 'FOX'
		hg_merge :onto => "releases"

		hg 'branch FIX_open'
		edit 'hello'

		hg 'log --graph'

		sh <<-eos
hg log -r "branch('re:FIX_.*')"
        eos

		sh <<-eos
hg log -r "ancestors('release_1_1_3')"
        eos

		sh <<-eos
hg log -r "origin(ancestors('release_1_1_3'))"
        eos

        show [:command, :comment]

		direct <<-eos
Mehr? Herausfinden, welche Bugfixes im `release_1_1_3` noch nicht
enthalen sind:
		eos

		sh <<-eos
hg log -r "branch('re:^FIX_.*')
           - ancestors('release_1_1_3')"
        eos

		direct <<-eos
Stimmt noch nicht ganz. Bugfixes könne ja auch per Cherry-Pick
(`graft`, `transplant` oder `rebase`) übertragen worden sein:
		eos

		sh <<-eos
hg log -r "branch('re:^FIX_.*')
           - (ancestors('release_1_1_3')
              or origin(ancestors('release_1_1_3')))"
        eos

	end
end