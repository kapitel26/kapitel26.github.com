---
layout: post
title: "Git vs. Mercurial (Teil 0)"
description: ""
category: Git
tags: [Git, Mercurial]
# just to fix a highlightin problem]()
author: bst
---
{% include JB/setup %}

{% include git-vs-hg.md %}

Jede Epoche stellt die Menschheit vor große Alternativen:

 * Paradies: Apfel **essen** oder **nicht essen**?
 * Irgendwann später: **Goethe** oder **Schiller**?
 * Kalter Krieg: **Kapitalismus** oder **Kommunismus**?
 * 70er: **C** oder **Pascal**
 * Dann: **vi** oder **emacs**
 * 80er: **Mac** oder **Windows**
 * 00er: **EJB3** oder **Spring**
 * Immer noch: **vi** oder **emacs**

Heute ist es natürlich die Frage:

 * Heute: **Git** oder **Mercurial**?

Um es vorwegzunehmen: Ich beantworte diese Frage hier nicht.

Ich schätze beide Systeme sehr. Mit Mercurial arbeite ich 
seit über 2 Jahren fast täglich und gerne. Git hat wiederum
hat mich mich so fasziniert,
dass ich unbedingt ein [Buch](Git-Buch) darüber schreiben mußte.

Vorstellung der Kontrahenten
============================

Beide Systeme kämpfen in der Klasse der verteilten Versionsverwaltungen
(DVCS) und sind Open Source (GPLv2).

Der Champion - Git
------------------

2005 begann Linus Torvalds mit der Entwicklung von [Git](http://git-scm.com), weil
er sich mit keinem der Open-Source verfügbaren Versionsverwaltungssysteme anfreunden
konnte. Es ist schwer belastbare Zahlen zur Verbreitung zu finden. Bei Git ist das aber
auch kaum nötig. Fast jedes neue Open-Source-Projekt, und auch so manches große alte
Projekt, versioniert mit Git. Dazu beigetragen hat auch der große Erfolg der
"Social Coding"-Plattform [Github](https://github.com).
Die Enterprise-Welt ist natürlich etwas träger, 
viele Projekte arbeiten noch mit Subversion oder proprietären Systemen. 
Aber wenn ich mich in meinem Bekanntenkreis umhöre,
dann scheint Git auch dort an Boden zu gewinnen.

Der Herausforderer - Mercurial
------------------------------

Auch hier begann die Entwicklung im Jahr 2005. Mercurial ist inzwischen
weit verbreitet und hat ebenfalls eine starke Community aufgebaut, 
kann aber in diesem Punkt nicht an Git heranreichen. 
Mit einer besonders einfachen und klaren Kommandoschnittstelle,
der leichten Erweiterbarkeit mit Python und einer Query-Sprache
für den Commit-Graphen bietet es auch einige Features,
die es zu einer interessanten Alternative machen.

Und was ist mit den Anderen?
----------------------------

Natürlich gibt es da draußen noch ein paar weitere Alternativen. 
Im Open-Bereich wären da beispielsweise noch Bazaar, Darcs
und Fossil zu nennen. Ich glaube aber, dass derzeit keines
davon größere Verbreitung hat. Und selbst wenn, ehrlich
gesagt, ich habe sie nicht ausprobiert und kann also auch nichts
sinvolles darüber schreiben.

Proprietäre Systeme gibt es natürlich auch. Aber alle Sourcen
langfristig an einen einzigen Hersteller zu binden, wer 
möchte das schon?



