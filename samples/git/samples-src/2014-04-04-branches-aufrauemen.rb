# encoding: UTF-8

samplename = 'branches-aufraeumen'
FileUtils.rm_rf "workspaces/#{samplename}"
@demo = GitDemos.new("workspaces/#{samplename}")

@demo.section do

	text <<-__
---
layout: post
title: "Die Option --mirror nutzen, um Branches in Git-Repositories aufzuräumen."
category: Git
tags: [Git, Branching, Feature-Branches, Mirror, Clone, Push]
author: bst
---
	__

	hide_all do
		new_repo 'remoterepo'
		cd 'remoterepo'

		create 'file'

		shell 'git checkout -b master'
		create_and_commit 'file-master'

		['a', 'b', 'c'].each do |b|
			shell "git checkout -b branch-#{b} master"
			create_and_commit "file-#{b}"
		end

		shell 'git checkout master'

	end

	text <<-__
Ab und zu sollte man sein Repository entrümpeln
(siehe auch [Alte Branches archivieren](/git/2014/03/31/alte-branches-archivieren.rb/index.html)).
Lokal kann man Branches einfach, ändern oder umbenennen. 
Die Änderungen dann mit einzelnen `push`-Aufrufen in ein entferntes Repository 
zu übertragen ist aber umständlich.

Einfacher ist es mit der Option `clone --mirror`: 
Sie spiegelt den Zustand aller lokalen Branches in das Zielrepository. 
Dabei ist es egal, ob die Branches neu angelegt, geändert oder gelöscht wurden. 
Nach dem Aufruf hat das Zielrepository den gleichen Stand für alle Branches 
wie das lokale Repository. 
Man geht wie folgt vor:

 1. Mit `clone --mirror` eine Arbeitskopie erstellen und
 2. dort mit `branch -d` und `branch -m` die Branches bearbeiten und dann
 3. mit `push --mirror` alle Änderungen übertragen.

**Achtung:** Ein `push` von einem `mirror`-Repository ändert man Branches im Zielrepository,
dies hat dieselben Auswirkungen wie ein `push --force`.
Wegen Risiken und Nebenwirkungen lesen die [Packungsbeilage](/git/2012/04/28/push-mit-force-in-git/)
oder fragen sie einen [Experten](/rene/).

### Beispiel

Ein Repository enthält mehrere Branches.
__

	shell 'git branch'


	hide_all { cd '..' }

	text <<-__
Mit der Option `--mirror` des `clone`-Befehls erstellen wir eine Arbeitskopie
des Repositorys.
__
	shell 'git clone --mirror remoterepo localrepo'

	text <<-__
Alle Branches aus 'remoterepo' sind als hier als *tracking Branch* abgebildet.
__
	cd 'localrepo'
	shell 'git branch -v'

	text <<-__
Diese Branches können wir jetzt nach Lust und Laune bearbeiten.
__

	show :shell do
		shell 'git branch -f branch-a master       # Zurücksetzen'
		shell 'git branch -D branch-b              # Löschen'
		shell 'git branch -M branch-c moved-c      # Umbenennen'
		shell 'git branch new-branch-d             # Neu anlegen'
	end

	text <<-__
Ein einfaches `push` überträgt alles.
__
	shell 'git push'

	text <<-__
Die Branches in beiden Repositorys stimmen überein.
__
	shell 'git branch -v'

	cd '..'
	cd 'remoterepo'

	shell 'git branch -v'

end

