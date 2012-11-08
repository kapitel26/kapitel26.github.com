---
layout: post
title: "Git vs. Mercurial - Lieblingsfeatures: Revsets (Teil 4)"
category: Git
tags: [Git, Mercurial, Revsets]
# just to fix a highlightin problem]()
author: bst
---
{% include JB/setup %}

{% include git-vs-hg.md %}

In den letzten Folgen ging es um Dinge, die beide Tools können. Interessant ist aber, auch Git kann und Mercurial nicht und
umgegekehrt?

Mercurial Revsets
-----------------

Wenn viele Entwickler an einer Software arbeiten, 
kann die Commit-Historie ganz schön unübersichtlich werden. 
Sowohl Git als auch Mercurial bieten zahlreiche Kommandos,
um die Historie zu analysieren. Aber nur Mercurial eine 
eigene *Query Language dafür*:

Ein Beispiel: Die aktuelle Software hat die Version `1_1_3`. 
Ein neues Feature soll ausgeliefert werden. 
Die QA entdeckt einen Fehler, den es in `1_1_3` noch nicht
gegeben hat.

    hg log -r "branch(myfeature)"

Zeigt alle Änderungen auf `myfeature`. 
Oha, ganz schön viele! Aber halt: Teile von `myfeature`
wurden schon in `1_1_3` ausgeliefert. Die können wir
aussortieren.

    hg log -r "branch(myfeature) and not ancestor(release_1_1_3)"

QA sagt, der Fehler könnte was mit Berechtigungen zu tun haben.
Wir untersuchen, ob auf dem Branch seit `release_1_1_3` die Datei
`user-roles.xml` verändert wurde.

    hg log -r "branch(myfeature) and not ancestor(release_1_1_3)
               and file('user-roles.xml')"

Falls wir jetzt ein Commit gefunden haben, lohnt es sich vielleicht
noch zu prüfen, ob die Änderung original auf `myfeature` stattgefunden hat, oder ob sie von einem anderen Branch 
"hereingemerged" wurde.

    hg log -r "branch(myfeature) and not ancestor(release_1_1_3)
               and modifies('user-roles.xml') and not merge()"

Großartiges Feature!

Wer mehr darüber wissen möchte:

    hg help revsets

Fazit
-----

Mercurial-Revsets sind ein ungemein nützliches Tool,
um die Historie zu analysieren. 
Ich wünschte, Git hätte auch etwas vergleichbares.