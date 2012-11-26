#!/usr/bin/env ruby

$LOAD_PATH << File.expand_path(File.dirname(__FILE__)+"/lib")

require "commandline-sample-maker"

File.open("../_includes/samples/#{__FILE__}.md", "w") do |io|

	DemoCommandline.new(MarkdownRenderer.new($stdout)) do
		show []

		sh 'hg init'

		sh 'hg branch releases'
		edit '.hg/hgrc', 
			:content =>"[ui]\nlogtemplate=\"{branches}: {desc|firstline}\\n\"\n",
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

		show
		direct <<-eos
Ein Beispiel: Die aktuelle Software hat die Version `1_1_3`. 
Ein neues Feature soll ausgeliefert werden. 
Die QA entdeckt einen Fehler, den es in `1_1_3` noch nicht
gegeben hat.
Das Beispiel zeigt die Branches `releases` und `myfeature`:

		eos

		sh 'hg log --graph'

		direct <<-eos
Zeige alle Änderungen auf dem Branch `myfeature`. 

		eos

	    sh 'hg log -r "branch(myfeature)"'

		direct <<-eos
Oha, ganz schön viele! Aber halt: Teile von `myfeature`
wurden schon in `1_1_3` ausgeliefert. Die können wir
aussortieren.

		eos

	    sh <<-eos
hg log -r "branch(myfeature) 
           and not ancestors(release_1_1_3)"
        eos

		direct <<-eos
QA sagt, der Fehler könnte was mit Berechtigungen zu tun haben.
Wir untersuchen, ob auf dem Branch seit `release_1_1_3` die Datei
`user-roles.xml` verändert wurde.

		eos

	    sh <<-eos
hg log -r "branch(myfeature) 
           and not ancestors(release_1_1_3)
           and file(\'user-roles.xml\')"
        eos

		direct <<-eos
Falls wir jetzt Commits gefunden haben, lohnt es sich vielleicht
noch zu prüfen, ob die Änderung wirklich auf `myfeature` stattgefunden 
haben, und nicht von woanders "hereingemerged" wurde.

		eos

	    sh <<-eos
hg log -r "branch(myfeature)
           and not ancestors(release_1_1_3)
           and modifies(\'user-roles.xml\')
           and not merge()"
        eos
	end
end