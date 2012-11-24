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
eigene *Query Language* dafür:

{% include samples/hg-revsets-sample-1.rb.md %}

Großartiges Feature!

Wer mehr darüber wissen möchte:

    hg help revsets

Fazit
-----

Mercurial-Revsets sind ein ungemein nützliches Tool,
um die Historie zu analysieren. 
Ich wünschte, Git hätte auch etwas vergleichbares.