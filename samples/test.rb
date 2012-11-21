#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.dirname(__FILE__)+"/lib")

require "commandline-sample-maker"

DemoCommandline.new do
	sh 'hg init'

	sh 'hg branch releases'
	edit '.hg/hgrc', 
		:content =>"[ui]\nlogtemplate=\"{rev} on {branches}: {desc|firstline}\\n\"\n",
		:commit => :false
	edit 'user-roles.xml', :line_numbers => [0,1,2]
	edit 'file2'

	sh 'hg branch myfeature'
	edit 'file3'

	sh 'hg up releases'
	sh 'hg merge myfeature'
	sh 'hg commit -m "merge myfeature into releases"'
	edit 'user-roles.xml', :line_numbers => [0]
	sh 'hg tag release_1_1_3'

	sh 'hg up myfeature'
	edit 'user-roles.xml'
	sh 'hg merge releases --tool internal:merge'
	sh 'hg commit -m "merge releases into feature"'
	edit 'file4'

	sh 'hg log --graph'

    sh 'hg log -r "branch(myfeature)"'
    sh 'hg log -r "branch(myfeature) and not ancestors(release_1_1_3)"'
    sh 'hg log -r "branch(myfeature) and not ancestors(release_1_1_3)' +
       ' and file(\'user-roles.xml\')"'
    sh 'hg log -r "branch(myfeature) and not ancestors(release_1_1_3) ' +
       'and modifies(\'user-roles.xml\') and not merge()"'

    sh 'cat file2'
    sh 'cat file3'
    sh 'cat file4'
    sh 'cat user-roles.xml'

end