---
layout: post
title: "No-Fast-Forward als Default"
description: "Fast-Forward deaktivieren"
category: Git
author: rp
tags: [Git, --no-ff, --ff, --ff-only, merge]
---

Fast-Forward-Merges
-------------------
Wenn man mit Git zwei Branches zusammenführt und es keine Änderungen im aktuellen Branch
gibt, dann erzeugt Git kein Merge-Commit sondern setzt nur den aktuellen Branch-Zeiger auf
das letzte Commit des hinzukommenden Branches.
Dieses Verhalten ist beim gemeinsamen Arbeiten auf einem Branch auch gewünscht, weil es zu
einer linearen Historie mit nur minimaler Anzahl von Merge-Commits führt.

No-FF bei Feature- und Release-Branches
---------------------------------------
Arbeitet man dagegen mit Feature-Branches (Git-Buch Seite 123) oder nutzt man
Branches um ein Release vorzubereiten (Git-Buch Seite 167) dann will man eine sinnvolle
First-Parent-Historie um die Commits eines Branches von anderen Branches zu unterscheiden.
Durch Fast-Forward-Merges würde die First-Parent-Historie dagegen uneindeutig werden.

Deswegen wird man beim Merge die Option `--no-ff`angeben.

	$ git merge --no-ff f/feature-a  

No-FF als Default setzen
------------------------
Über eine Konfigurationsvariable kann man No-Fast-Forward als Default setzen:

	$ git config --global merge.ff false

Oder wenn man es nur für das aktuelle Repository will:

	$ git config merge.ff false

Fast-Forward-Merges trotzdem erzwingen
--------------------------------------
Über die Option `--ff-only`kann man normalerweise Erzwingen, dass ein Merge als Fast-Forward-Merge
durchgeführt wird. Falls es Änderungen in beiden Branches gibt, wird der Merge scheitern.
Allerdings ist die Kombination von `merge.ff=false`und `--ff-only`verboten:

	$ git merge --ff-only  f/feature-a
	fatal: You cannot combine --no-ff with --ff-only.

Es ist eine weitere Option `--ff` notwendig um trotz `merge.ff=false` einen Fast-Forward-Merge zu erzwingen.

	$ git merge --ff --ff-only  f/feature-a
	Updating 3192f01..6b1443d
	Fast-forward
	 a.txt | 1 +
	 1 file changed, 1 insertion(+)

Wenn man sich sicher ist, das ein Fast-Forward-Merge ausgeführt wird, kann man auch die Option `--ff-only` weglassen.
Dann verhält sich Git wieder wie im Default-Zustand - wenn ein Fast-Forward möglich ist, wird dieser durchgeführt.

	$ git merge --ff f/feature-a
	Updating 3192f01..6b1443d
	Fast-forward
	 a.txt | 1 +
	 1 file changed, 1 insertion(+)
