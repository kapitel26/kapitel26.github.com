---
layout: post
title: "Wer hat Angst vor dem Garbage Collector?"
description: ""
category: Git
tags: [git, Garbage Collector]
---

{% include JB/setup %}

	
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

