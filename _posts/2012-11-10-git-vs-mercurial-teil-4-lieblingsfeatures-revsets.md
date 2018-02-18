---
layout: post
title: "Git vs. Mercurial - Lieblingsfeatures: Revsets (Teil 4)"
category: Git
tags: [Git, Mercurial, Revsets]
# just to fix a highlightin problem]()
author: bst
---

{% include_relative git-vs-hg.md %}

In den letzten Folgen ging um das, was beide Tools können. Heute
werfe ich mal einen Blick auf ein Feature, das nur in Mercurial
vorhanden ist.

Mercurial Revsets
-----------------

Wenn viele Entwickler an einer Software arbeiten,
kann die Commit-Historie unübersichtlich werden.
Sowohl Git als auch Mercurial bieten zahlreiche Kommandos,
um die Historie zu analysieren. Aber nur Mercurial hat eine
eigene *Query Language* dafür:

{% include_relative 2012-11-10-revsets/hg-revsets-sample-1.rb.md %}

{% include_relative 2012-11-10-revsets/hg-revsets-sample-2.rb.md %}

Noch ein Beispiel: Wissen, welche Sachen ich noch nicht abgeschlossen habe.

    hg log -r "head()
               and author("stachi")
               and not closed()"

Das Ganze funktioniert übrigens nicht nur für `hg log` sondern
für jedes Kommando, das eine Option `-r` bzw. `--rev` Option
bietet.

Großartiges Feature! Wer [mehr darüber wissen](http://www.selenic.com/hg/help/revsets)
möchte:

    hg help revsets

Und Git?
--------

Natürlich bietet auch Git zahlreiche Möglichkeiten, Dinge
über das Repository herauszufinden. Aber sie sind
verteilt auf viele Optionen, verschiedene Befehle und
ein paar syntaktische Sonderlocken. Sie lassen sich nicht
nicht so frei kombinieren und sind oft schlechter lesbar
als die SQL-artige Syntax der *Query Language* von Mercurial.

Fazit
-----

Die Mercurial-Revsets *Query Language* ist ein ungemein
nützliches Tool, um die Historie zu analysieren.
Ich wünschte, dass Git so etwas auch hätte.
