---
layout: post
title: "Reflog für Bare-Repositorys in Git"
description: ""
category: 
tags: []
---

{% include JB/setup %}

Das *Reflog* ist dein Freund
----------------------------

Im Reflog wird jede einzelne Änderung an Branches (und auch ein paar
anderen Dingen) aufgezeichnet. Was auch immer schiefgegangen ist,
z. B. ein [unglückliches `push`][/2012/04/28/push-mit-force-in-git]:
Fast immer lässt es sich mit [Hilfe des Reflogs der vorige Stand wiederherstellen.][/2012/05/08/abgeschnittene-commits-zurueckholen]
Es ist also gut, ein Reflog zu haben, aber:

Achtung: Bare-Repositorys haben oft kein Reflog!
------------------------------------------------

Für normale Repository mit Workspace ist das Reflog in der Regel
aktiv. Für sogenannte *Bare Repositorys*, die zum Austausch zwischen
Entwicklern genutzt werden, ist Reflog per Default nicht aktiv.
Am besten schalten Sie es gleich ein:

	git config core.logAllRefUpdates true

Oder gleich als Default für die gesamte Installation.

	git config --system core.logAllRefUpdates true

Man kann es auch schon gleich beim Klonen aktivieren:

	git clone --bare --config core.logAllRefUpdates=true ~/work/kapitel26/	

Schutz vor Manipulation der Historie
------------------------------------

Git ermöglicht es, die Historie zu manipulieren. Vielleicht habe ich mich
beim Entwickeln verrannt und möchte die letzten beiden Commits verwerfen 
(`reset --hard head^^`), oder ich möchte die versehentlich hinzugefügte
Datei mit den Klartextpasswörtern wieder loswerden. Kein Problem mit Git.
Ersteres erledigt ein `reset --hard head^^` erreichen, letzteres
ermöglicht der `filter-branch`-Befehl.

Manchmal möchte man aber genau das nicht. Manchmal möchte man
(oder muss man), die "offizielle" Historie aller Änderungen in einem
zentralen Repository dokumentieren. Man kann ein solches Repository 
durch `denyNonFastForward` schützen. Git akzeptiert neue Commits
dann nur, wenn sie Nachfahren der vorigen Commits sind. Dann kann nichts
verloren gehen (schützt auch vor `push -f`).

	git config receive.denyNonFastForwards true
	
Wer hat Angst vor dem Garbage Collector?
----------------------------------------

Git arbeitet mit einem Garbage-Collector, der *nicht mehr benötigte* Objekte 
abräumt. Einerseits kann man ihn direkt mit `git gc` aufrufen,
andererseits wird er bei manchen Befehlen implizit mit ausgeführt.
Das hat bei mir immer ein ungutes Gefühl hinterlassen.
Was löscht Git dabei eigentlich? Mache ich mit einem
`git gc` alles kapput?

Die Hilfe (`git help gc`) beginnt mit: 
"Runs a number of housekeeping tasks ...". Hmmm, nicht sehr hilfreich.
Es folgt die Git-typische längliche Auflistung von Optionen und Konfigurationen.
Doch dann, fast ganz unten, steht der beruhigende Satz:

>	git gc tries very hard to be safe about the garbage it collects.

Und es folgt eine detaillierte Auflistung von Dingen, die Git
nicht löscht. Dazu gehört natürlich alles, was von den aktuellen Branches 
und Tags referenziert wird. Vor allem gehört aber auch alles (!) dazu, was 
im Reflog referenziert wird, so dass man Fehler, die man beispielsweise
mit `reset`, `amend`, `rebase` oder `branch -d` gemacht hat, mit Hilfe des 
Reflogs leicht wieder korrigieren kann. `filter-branch` speichert die 
Original-Commits in `refs/original`. Auch diese werden nicht abgeräumt.

Nun stellt sich natürlich die Frage: Was räumt Git denn überhaupt ab? Und wann?

Git wäre nicht Git, wenn das nicht konfigurierbare wäre. Und tatsächlich:
Es gibt eine Reihe von Konfigurationsparametern dafür.

	git config gc.pruneexpire 2.weeks.ago              #entspricht default

Selbst wenn Objekte gar nicht mehr referenziert werden, räumt Git sie
frühestens nach zwei Wochen ab. Schon mal ganz beruhigend.

	git config gc.reflogexpireunreachable 30.days.ago  #entspricht default

Die Einträge im Reflog für Commits, die durch `git commit --amend`, `git rebase` 
oder ähnliches werden frühestens nach 30 Tagen entfernt. Mindestens so lange
sind auch die dazu gehörenden Commits geschützt. 
	
	git config gc.reflogexpire 90.day.ago

Einträge im Reflog, die zur aktuellen Historie gehören, werden für mindestens
90 Tage gehalten. Die Commits selber sind ohnedies geschützt, da Git nie
einen Vorfahren des aktuellen Standes eines Branches löschen würde.



Links
-----

  [1]: http://stackoverflow.com/questions/3876206/how-do-i-view-a-git-repos-recieve-history
  [2]: http://stackoverflow.com/questions/6140083/how-to-create-reflogs-information-in-an-existing-bare-repository

