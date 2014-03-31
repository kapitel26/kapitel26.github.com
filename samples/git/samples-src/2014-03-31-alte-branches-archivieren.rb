# encoding: UTF-8

samplename = 'sumpfin-else'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do

	text <<-__
---
layout: post
title: "Aufräumen: Alte Feature-Branches archivieren oder löschen."
category: Git
tags: [Git, Branching, Feature-Branches]
author: bst
---
	__

	hide_all do
		new_repo 'repo'
		cd 'repo'

		create 'file'

		shell 'git checkout -b master'
		create_and_commit 'file-master'

		['a', 'b', 'c', 'd', 'e'].each do |b|
			shell "git checkout -b branch-#{b} master"
			create_and_commit "file-#{b}"
		end

		shell 'git checkout master'
		shell 'git merge --ff branch-a'		
		shell 'git merge branch-b'
		shell 'git merge branch-c'
	end

	stmt = 'git branch --merged | grep -v  -e "* " -e "  archive/" | xargs -I NAME git branch -m NAME archive/NAME'

	text <<-__
Wenn man über längere Zeit mit Feature-Branches arbeitet und nicht jeden Branch sofort 
nach der Fertigstellung schließt, wird es irgendwann unübersichtlich im Repository. 
Ich zeige heute, wie man dann aufräumen kann.

### Alte Branches nach "archive/" verschieben

Auf dem Branch `master` ausgeführt werden alle Branches, die bereits vollständig 
in `master` enthalten sind, in den Namensraum `archive/` verschoben, d. h. aus
`old-feature` wird ` archive/old-feature`.

	#{stmt}

### Wie funktioniert es?

Ein Beispiel: Im Repository sind einige Branches bereits abgeschlossen
und wurden in `master` gemerged, während andere noch offene Änderungen haben.
	__


	shell 'git checkout master'
	shell 'git branch --merged'
	shell 'git branch --no-merged'

	text <<-__
Folgender Befehl wird ausgeführt:
	__

	shell stmt
	hide_all { shell stmt } # nur um zu checken, dass das idempotent ist

	shell 'git branch'

	text <<-__
Es passieren 3 Dinge:

 1. Mit `branch --merged` werden nur Branches angezeigt, die bereits
    vollständig im aktuellen Branch enthalten sind.

 2. Das `grep`-Statement filtert den aktuellen Branch und die bereits archivierter Branches heraus.

 3. Mit `branch -m` werden die Branches verschoben (umbenannt).
    `xargs -I` sorgt dafür, dass der Befehl für jeden Branch aus Schritt 2. einmal ausgeführt wird.

## Wegwerfer oder Behalter?

Falls Sie lieber reinen Tisch haben wollen, können Sie die Branches
natürlich auch löschen.
	__

	stmt = 'git branch --merged | grep -v  -e "* " | xargs -I NAME git branch -D NAME'

	shell stmt

	# shell 'git branch'



end

