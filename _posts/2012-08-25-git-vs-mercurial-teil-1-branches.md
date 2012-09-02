---
layout: post
title: "Git vs. Mercurial - Branches (Teil 1)"
description: ""
category: Git
tags: [Git, Mercurial]
# just to fix a highlightin problem]()
author: bst
---
{% include JB/setup %}

Weil es so wichtig fange ich mal mit den Branching-Modellen an.
Ohne Branches könnte eine dezentrale Versionsverwaltung
schließlich gar nicht funktionieren. 
Außerdem sind Branches für Workflows zur Zusammenarbeit
in komplexen Projekten mit vielen Entwicklern nahezu unverzichtbar.
Ein schwerfälliges Branching-Modell ist eine echte Belastung,
wenn man in einem solchen Projekt mehrere Releases einer Software pflegen muss 
und parallel dazu neue Features entwickelt.
Wer so etwas mal mit CVS gemacht hat, kann ein Lied davon singen, 
wie zum Beispiel Linus Torvalds in seinem 
[berühmten Tech Talk](http://www.youtube.com/watch?v=4XpnKHJAok8) über Git.

Mehr als nur ein paar Gemeinsamkeiten
=====================================

Doch bevor ich auf die Unterschiede komme, möchte ich kurz auf die
Gemeinsamkeiten eingehen.

Branching ist der Normalfall
----------------------------

Sowohl Git als auch Mercurial sind konsequent *dezentral* organisiert.
Um an einem Projekt mitentwickeln zu können erstellt man eine lokale Kopie
des Repositorys, genannt *Klon*. Auf dem Klon versioniert man lokal.
Es ist keine Interaktion mit einem Server notwendig.
Der Entwickler entscheidet selber, wann er per *Push* oder *Pull*
Teilergebnisse mit anderen Repositorys abgleicht.

Bei dezentraler Versionsverwaltung ist *Branching* der Normalfall.
Sobald auf zwei oder mehr Klonen entwickelt wird, entstehen Verzweigungen
Git und Mercurial sind sehr gut darin, auseinandergelaufene Entwicklungen
wieder zusamen zu führen (Merge). Im Beispiel wurden die Versionen `3`
und `Y` zu einer Version `E` zusammengeführt.

    Klon 1                      Pull von "Klon 2"          Nach dem Merge   
    
    A--B--C--1--2--3            A--B--C--1--2--3           A--B--C--1--2--3--E
                                       \                       \            /
    Klon 2                              X--Y                    X--Y-------´
                                                  
    A--B--C--X--Y                                     

(fast) gleiches Commit-Modell
-----------------------------

Um das zu ermöglichen, nutzen beide System ein Commit-Modell, bei dem jedes Commit
seinen Vorgänger kennt und Merge-Commits zwei Vorgänger haben dürfen. Die Commits
bilden einen gerichteten azyklicken Graphen (DAG). Beide nutzen diesen Graphen,
um bei Zusammenführungen den gemeinsamen Vorgänger zu identifizieren. 
Damit ist ein *3-Wege-Merge* möglich, der die meisten Konflikte automatisch 
auflösen kann, so dass der Entwickler nur gelegentlich manuell nachhelfen muss.

Das ist übrigens nicht so selbstverständlich, wie es heute vielleicht klingt. 
Subversion-Nutzer mussten viele Jahren lang den gemeinsamen Vorgänger 
beim Merge "zu Fuß" bestimmen. 
Erst mit der Version 1.5 wurde das Feature unter dem Namen "Merge Tracking"
eingeführt.

Gemeinsame Vorteile
-------------------

Beide Systeme

 * ermöglichen den schnellen Wechsel zwischen Branches,
 * unterstützen das Zusammenführen (Merge) durch 3-Wege-Merge gut,
 * sind auch bei großen Operationen schnell,
 * erleichtern Entwicklung an mehreren Standorten,
 * ermöglichen es die Integrität der Historie durch SHA1 Prüfsummen zu validieren,
 * ermöglichen es, offline zu entwickeln.

Branches in Git
===============

In Git ist ein Branch einfach ein Zeiger auf ein Commit.
Bei jedem neuen Commit wird der Zeiger nachgezogen. Mit dem 
`reset`-Befehl kann der Zeiger aber auch auf irgendein
anderes Commit umgesetzt werden.


    Zeigt auf C              Nach Commmit von D            Reset auf X     
                                                                       
         branch-a                   branch-a                branch-a
            |                          |                       |
            |                          |                       V      
        X   |                   X      |                       X     
       /    V                  /       V                      /      
      A--B--C                 A--B--C--D                     A--B--C--D


Git-Branches sind rein lokal
----------------------------

Soweit so einfach. Für den Git-Einsteiger zunächst
verwirrend ist aber: Branches sind rein lokal,
jeder Repository hat seinen eigenen Satz an Branches.
Bei Push- und Pull-Operationen kann jeder lokale Branch 
auf einen beliebigen Branch im anderen Repository abgebildet werden.
Ein Beispiel: Beim einem Push kann ich den Stand meines lokalen
`branch-a` auf den `master` eines anderen Repositorys
bringen, falls ich das möchte.

Unterstützung
-------------

Soviel Freiheit hat ihren Preis. Viele Klone mit vielen Branches können die Situation unübersichtlich werden lassen. Doch Git unterstützt hier recht gut:

* Git überträgt automatisch auf namensgleiche Branches, wenn man nichts angibt. Einigen sich die Entwickler auf einheitliche Branchnamen, ist alles dann doch wieder recht einach.
* Damit man weiß, was in anderen Repositorys los ist, gibt es *Remote Tracking Branches*. Im Beispiel unten zeit `server/branch-a` auf den Stand, denn `branch-a` beim letzten Pull vom Repository `server` hatte.
* Man kann Branches anderer Repositorys als *Upstream* deklarieren, dann zeigt Git Meldungen wie `Your branch is ahead of 'server/branch-a' by 2 commits.`.

Ein Beispiel:

    
                            branch-a
      server/branch-a          |
             |                 |
             V                 V
    A--------B--------C--------D

Branches löschen?
-----------------

Wenn man in Git einen Branch löscht, wird nur der Zeiger entfernt. Die Commits
werden irgendwann später durch ein [Garbage Collect][gc-post] abgeräumt.

Keine Branch-Historie in Git
----------------------------

Das Modell von Git kennt die Historie der Commits, aber **keine
Historie der Branches**. 

Im Beispiel oben kann ich zwar sehen, dass `branch-a` jetzt auf
`D` zeigt. Aber woher her ist er gekommen?
Durch ein Commit von `C` aus? 
Durch ein `reset` von einem Commit `E`, das wir jetzt gar nicht mehr sehen?
Durch ein Fast-Forward-Merge?

Was ich hingegen genau weiß ist dass die Version `D` aus der Version `C` hervorgegangen
ist. Zu jeder einzelnen Zeile des Codes kann Git mir genau sagen, ob sie in
`A`, `B`, `C` oder `D` hinzugefügt wurde und auch durch wen Sie hinzugefügt
wurde (oft sogar dann, wenn wenn Codeteile verschoben oder kopiert werden).

Die Git-Historie zeigt welche Code-Änderungen erfolgt sind, 
aber nicht auf welchen Branches diese entstanden sind.
Das ist so gewollt, denn Git versteht sich als "stupid content tracker"
(Eigenbeschreibung der Man-Page) und nicht als "worflow tracking system".

Trotzdem vermisse ich diese Art von Information manchmal, z. B. 
wenn es darum geht ein Review zu einem Features-Branch zu machen,
oder wenn etwas schief gegangen ist, und ich herausfinden möchte,
wie das passieren konnte.

Anmerkung: Es gibt natürlich Workarounds, um damit umzugehen,
z. B. mit `git notes` oder über Commit-Kommentar-Konventionen.
Aber es fehlte eine direkte Unterstützung für eine Historie der Branches.

Noch eine Anmerkung: Git schreibt ein lokales [Reflog][reflog-post],
welches Änderungen an Branches protokolliert. Aber das ist eben
"nur" ein Log und "nur" lokal.

Und was bedeutet das jetzt?
---------------------------

**Vorteile**

 * Das **Arbeiten mit lokalen** Branches ist einfach. Der Entwickler
   hat die volle Kontrolle, wann er welche Änderungen veröffentlicht.

 * Man kann Repositorys durch das Löschen von Branches und durch Garbage
   Collect **aufräumen**, so dass nur noch relevante Commits übrig bleiben.

 * Remote Tracking Branches ermöglichen einen guten **Überblick** auch dann,
   wenn man Teilergebnisse  aus **vielen verschiedenen Repositorys**
   zusammenführen muss. Die ist bei der Integration großer Open-Source-Projekte
   sehr hilfreich.

 * Das flexible Modell mit Branches als Zeigern erleichtert es,
   die Geschichte oder Teile davon gezielt neu zu schreiben (Rebasing).
   Bevor sie ihre lokalen Branches veröffentlichen können 
   Entwickler so die Historie lokaler Branches aufräumen,
   zum Beispiel Commit-Kommentare verbessern, unnötig Änderungen zurücknehmen,
   zusammenhängende Änderungen gruppieren.
   Damit ist möglich, eine Commit-Historie aufzubauen, die eine **lesbare
   Geschichte** der Änderungen am Projekt darstellt.
   
**Nachteile**

 * Git kennt nur die Historie des Codes, nicht die **Historie der Branches**.
   Es gibt Workarounds, wenn man dies in seinen Workflows benötigt,
   aber eben keine direkte Unterstützung.

 * Das Konzept von lokalen Branches und Remote-Tracking-Branches ist wirkt erst 
   rückblickend einfach. Ich habe es anfangs falsch verstanden. 
   Heute kommt es mir logisch und natürlich vor. Die **Lernkurve ist steil**.

Branches in Mercurial
=====================

In der Anfangszeit hat Mercurial nur "Branching by Cloning" unterstützt.
Später sind dann zwei weitere Möglichkeiten hinzugekommen: "Named Branches"
und "Bookmarks"

Branching by Cloning
-------------------

Man hat für jeden Branch einfach einen weiteren Klon des Repositorys 
angelegt. Das ist weniger schlimm, als es klingt, denn Mercurial
nutzt Hardlinks beim lokalen Klonen, so dass der Klon nur wenig
Speicherplatz kostet und schnell erstellt ist.
(Klonen mit Hardlinks kann Git natürlich auch)
In der Praxis hat sich das nicht so durchgesetzt, wahrscheinlich weil

 * es lästig ist immer wieder neue Projekte-Klone in der Entwicklungsumgebung
   an und später auch  wieder abzumelden, und

 * es umständlich ist, das Klonen der Branches auf dem 
   Team-Server zu koordinieren, wenn mehrere Teammitglieder gemeinsam
   auf einem Feature-Branch arbeiten sollen, und

 * der Trick mit den Hardlinks nicht funktioniert, wenn man
   vom Team-Server auf den lokalen Rechner klont.
   

Named Branches in Mercurial
---------------------------

Um das Arbeiten mit Branches in einem Repository zu ermöglichen,
kamen dann die "Named Branches" hinzu.
Zunächst vergibt man einen Namen für den aktuellen Branch
`hg branch feature-a`
ab dann wir zu jedem Commit dieser Name hinzugefügt.
Dies ermöglicht

 * das schnelle Wechseln von einem Branch zum Anderen, z. B. mit `hg update feature-a` und
 * das Anzeigen aller Commits zu diesem Branch, z. B. mit `hg log --branch feature-a`.

TODO Merging auch in ff-situationen erforderlich

Bookmarks in Mercurial - fast wie in Git
----------------------------------------

Seit Version 1.8 enthält Mercurial standardmäßig das Plugin "Bookmarks".
Es implementiert lokale Branch-Zeiger, die (fast) genau 
**wie Branches in Git** funktionieren.
Mit einer Ausnahme: Es ist nicht möglich, einen lokalen Bookmark
auf einen anders benannten Bookmark im entfernten Repository
abzubilden.

Löschen und Aufräumen in Mercurial
----------------------------------

 * ursprünglich auf unveränderbare historie getrimmt
 * push pushed alles by default
 * commits und branches so eng verknüpft
 * man wird branches nicht so 
 * closen von branches umständlich



[reflog-post]: /Git/2012/05/09/reflog-fuer-bare-repositorys-in-git-einrichten/
[gc-post]: /Git/2012/05/28/wer-hat-angst-vor-dem-garbage-collector/
