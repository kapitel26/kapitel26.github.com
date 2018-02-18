---
layout: post
title: "Aufräumen: Alte Feature-Branches archivieren oder löschen."
category: Git
tags: [Git, Branching, Feature-Branches]
author: bst
---

Wenn man über längere Zeit mit Feature-Branches arbeitet und nicht jeden Branch sofort 
nach der Fertigstellung schließt, wird es irgendwann unübersichtlich im Repository. 
Ich zeige heute, wie man dann aufräumen kann.

### Alte Branches nach "archive/" verschieben

Auf dem Branch `master` ausgeführt werden alle Branches, die bereits vollständig 
in `master` enthalten sind, in den Namensraum `archive/` verschoben, d. h. aus
`old-feature` wird ` archive/old-feature`.

	git branch --merged | grep -v  -e "* " -e "  archive/" | xargs -I NAME git branch -m NAME archive/NAME

### Wie funktioniert es?

Ein Beispiel: Im Repository sind einige Branches bereits abgeschlossen
und wurden in `master` gemerged, während andere noch offene Änderungen haben.

<pre>
repo $ <b>git checkout master</b>
repo $ <b>git branch --merged</b>
  branch-a
  branch-b
  branch-c
* master
repo $ <b>git branch --no-merged</b>
  branch-d
  branch-e
</pre>
Folgender Befehl wird ausgeführt:

<pre>
repo $ <b>git branch --merged | grep -v  -e &quot;* &quot; -e &quot;  archive/&quot; | xargs -I NAME git branch -m NAME archive/NAME</b>
repo $ <b>git branch</b>
  archive/branch-a
  archive/branch-b
  archive/branch-c
  branch-d
  branch-e
* master
</pre>
Es passieren 3 Dinge:

 1. Mit `branch --merged` werden nur Branches angezeigt, die bereits
    vollständig im aktuellen Branch enthalten sind.

 2. Das `grep`-Statement filtert den aktuellen Branch und die bereits archivierter Branches heraus.

 3. Mit `branch -m` werden die Branches verschoben (umbenannt).
    `xargs -I` sorgt dafür, dass der Befehl für jeden Branch aus Schritt 2. einmal ausgeführt wird.

## Wegwerfer oder Behalter?

Falls Sie lieber reinen Tisch haben wollen, können Sie die Branches
natürlich auch löschen.

<pre>
repo $ <b>git branch --merged | grep -v  -e &quot;* &quot; | xargs -I NAME git branch -D NAME</b>
Deleted branch archive/branch-a (was d4d58e2).
Deleted branch archive/branch-b (was 457bfed).
Deleted branch archive/branch-c (was 54fcb38).
</pre>
