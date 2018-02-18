---
layout: post
title: "Git vs. Mercurial - Branches (Teil 1)"
description: ""
category: Git
tags: [Git, Mercurial]
# just to fix a highlightin problem]()
author: bst
---

{% include_relative git-vs-hg.md %}

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
seinen Vorgänger kennt und sogenannte Merge-Commits zwei Vorgänger zusammenführen.
Die Commits bilden einen gerichteten azyklicken Graphen (DAG). Beide nutzen diesen Graphen,
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
 * ermöglichen es die Integrität der Historie durch SHA1 Prüfsummen zu validieren, und
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
Jeder Repository-Klon hat seinen eigenen Satz an Branches.
Bei Push- und Pull-Operationen kann jeder lokale Branch
auf einen beliebigen Branch im anderen Repository abgebildet werden.
Ein Beispiel: Beim einem Push kann ich den Stand meines lokalen
`branch-a` auf den `master` eines anderen Repositorys
bringen, falls ich das möchte.

Unterstützung
-------------

Soviel Freiheit hat ihren Preis.
Viele Klone mit vielen Branches können die Situation unübersichtlich werden lassen.
Doch Git unterstützt hier recht gut:

* Git überträgt automatisch auf namensgleiche Branches, wenn man nichts angibt.
  Einigen sich die Entwickler auf einheitliche Branchnamen, ist alles dann doch wieder recht einach.

* Damit man weiß, was in anderen Repositorys los ist, gibt es *Remote Tracking Branches*.
  Im Beispiel unten zeigt `server/branch-a` auf den Stand,
  den `branch-a` beim letzten Pull vom Repository `server` hatte.

* Man kann Branches anderer Repositorys als *Upstream* deklarieren, dann zeigt Git Meldungen wie
  `Your branch is ahead of 'server/branch-a' by 2 commits.`.

Ein Beispiel:


                            branch-a
      server/branch-a          |
             |                 |
             V                 V
    A--------B--------C--------D

Branches löschen?
-----------------

Wenn man in Git einen Branch löscht, wird nur der Zeiger entfernt. Die Commits
werden später durch ein [Garbage Collect][gc-post] abgeräumt.

Keine Branch-Historie in Git
----------------------------

Das Modell von Git kennt die Historie der Commits, aber **keine
Historie der Branches**.

Im Beispiel oben kann ich zwar sehen, dass `branch-a` jetzt auf
`D` zeigt. Aber woher her ist er gekommen?
Durch ein Commit von `C` aus?
Durch ein `reset` von einem Commit `E`, das wir jetzt gar nicht mehr sehen?
Durch ein Fast-Forward-Merge?

Was ich hingegen genau weiß ist,
dass die Version `D` aus der Version `C` hervorgegangen ist.
Zu jeder einzelnen Zeile des Codes kann Git mir genau sagen, ob sie in
`A`, `B`, `C` oder `D` hinzugefügt wurde und auch durch wen Sie hinzugefügt
wurde (oft sogar dann, wenn wenn Codeteile verschoben oder kopiert werden).

Die Git-Historie zeigt welche Code-Änderungen erfolgt sind,
aber nicht auf welchen Branches diese entstanden sind.
Das ist so gewollt, denn Git versteht sich als "stupid content tracker"
(Eigenbeschreibung der Man-Page) und nicht als "workflow tracking system".

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

Stäken und Schwächen von Git
----------------------------

**Vorteile**

 * Das **Arbeiten mit lokalen** Branches ist einfach. Der Entwickler
   hat die volle Kontrolle, wann er welche Änderungen veröffentlicht.

 * Man kann Repositorys durch das Löschen von Branches und durch Garbage
   Collect **aufräumen**, so dass nur noch relevante Commits übrig bleiben.

 * Remote Tracking Branches ermöglichen einen guten **Überblick** auch dann,
   wenn man Teilergebnisse  aus **vielen verschiedenen Repositorys**
   zusammenführen muss. Die ist bei der Integration großer Open-Source-Projekte
   sehr hilfreich (Integration Manager Workflow).

 * Das flexible Modell mit Branches als Zeigern erleichtert es,
   die Geschichte oder Teile davon gezielt neu zu schreiben (Rebasing).
   Bevor sie ihre lokalen Branches veröffentlichen können
   Entwickler können so die Historie lokaler Branches aufräumen,
   zum Beispiel Commit-Kommentare verbessern, unnötig Änderungen zurücknehmen oder
   zusammenhängende Änderungen gruppieren.
   Damit ist möglich, eine Commit-Historie aufzubauen,
   die eine **lesbare Geschichte** der Änderungen am Projekt darstellt.

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
angelegt. Das ist ger schlimm, als es klingt, denn Mercurial
nutzt Hardlinks im lokalen Klonen, so dass der Klon nur wenig
Speicherplatz kostet und schnell erstellt ist.
(Klonen mit Hardlinks kann Git natürlich auch)
In der Praxis hat sich das nicht so durchgesetzt, wahrscheinlich weil

 * es lästig ist immer wieder neue Projekte-Klone in der Entwicklungsumgebung
   an- und später wieder abzumelden, und

 * es umständlich ist, das Klonen der Branches auf dem
   Team-Server zu koordinieren, wenn mehrere Teammitglieder gemeinsam
   auf einem Feature-Branch arbeiten, und

 * der Trick mit den Hardlinks nicht funktioniert, wenn man
   vom Team-Server auf den lokalen Rechner klont.


Named Branches in Mercurial
---------------------------

Um das Arbeiten mit Branches in einem Repository zu ermöglichen,
kamen dann die "Named Branches" hinzu.
Zunächst vergibt man einen Namen für den aktuellen Branch
`hg branch feature-a`
ab dann wird zu jedem Commit dieser Name hinzugefügt.
Dies ermöglicht

 * das schnelle Wechseln von einem Branch zum Anderen, z. B. mit `hg update feature-a` und
 * das Anzeigen aller Commits zu diesem Branch, z. B. mit `hg log --branch feature-a`.

Der Branch-Name ist fest mit dem Commit verknüpft.
Man wird ihn, auch später, nicht mehr los.
Es braucht es immer eine frisches Merge-Commit,
um Änderungen auf einen anderen Branch bringen.
Selbst dann, wenn sich auf dem anderen Branch gar nichts getan hat.
Es gibt also keine Fast-Forward-Merges, wie in Git.
Das kann man als Nachteil auffasen, weil der Commit-Graph so verzweigter
wird als notwendig. Man kann es auch als Vorteil sehen,
weil es sichtbar macht, von welchem Feature-Branch die Änderungen
kamen und wann sie übernommen wurden.

Da man Branches nicht löschen kann, kann die Liste aller Branches im
Laufe der Zeit beliebig lang. Deshalb sollte man Branches durch
ein sogenanntes Closing-Commit schließen, dann werden sie in der
Anzeige herausgefiltert.

Bookmarks in Mercurial - fast wie in Git
----------------------------------------

Seit Version 1.8 enthält Mercurial standardmäßig das Plugin "Bookmarks".
Es implementiert lokale Branch-Zeiger, die (fast)
**wie Branches in Git** funktionieren.
Mit einer Ausnahme: Es ist nicht möglich, einen lokalen Bookmark
auf einen anders benannten Bookmark im entfernten Repository
abzubilden.

Phases
------

In neueren Versionen unterstützt Mercurial sogenannte Phases.
Es merkt sich, welche Commit schon veröffentlicht wurden,
und welche nur lokal bekannt sind. Man kann Commits sogar
als *privat* markieren, um sie vor versehentlicher Veröffentlichung
zu schützen. Das erleichtert es, ähnlich wie in Git
private experimentelle Branches zu pflegen.

Löschen und Aufräumen in Mercurial
----------------------------------

Mercurial wurde ursprünglich auf die Idee einer
unveränderbaren Historie hin entwickelt. So hat es,
anders als Git keinen Garbage-Collector.
Außerdem ist das Default-Verhalten bei Push und Pull so,
dass immer alle Änderungen übertragen werden.
Das hat zur Folge, das sich im Laufe der Zeit "Zeug"
in einem Mercurial-Repository ansammelt.

Man hat zwei Möglichkeiten damit umzugehen.
Möglichkteit 1: Ignorieren. Möglichkeit 2: Man erstellt
ein frisches Repository und holt mit selektivem Pull
nur genau das ab, was man noch benötigt.


Stärken und Schwächen von Mercurial
-----------------------------------

**Stärken**

 * Mercurials "Named Branches" bieten ein einfaches Branching-Modell,
   das Feature-Branches gut unterstütz und auch auch für große Projekte trägt.

 * "Named Branches" erleichtern es Ursachen von Problemen zu finde,
   weil man sieht, was auf welchem Branch gemacht wurde.

 * Das "Bookmarks"-Branching-Modell ermöglicht Git-ähnliche Workflows,
   bietet aber etwas weniger Komfort als Git selber (es fehlen
   z. B. Remot-Tracking-Branches, Upstream-Infos und die Verwaltung
   von Remotes)

**Schwächen**

 * Das ursprüngliche Branching-by-Cloning-Modell von ist für größere
   Projekte zu umständlich.

 * Durch die feste Verknüpfung der "Named Branches" mit den Commits,
   ist es aufwändig die Situtation zu bereinigen, wenn man auf
   den falschen Branch committed hat.

 * Generell ist das Aufräumen von Repository in Mercurial eher mühsam.
   Man merkt dem System immer noch an, dass es ursprünglich mit
   der Annahme einer unveränderbaren Historie konstruiert wurde.

tl;dr
=====

Ich hab' sie alle beide lieb.

Ich mag das Branching-Modell von Git,
-------------------------------------

weil es den "Integreation Manager Workflow" so gut unterstützt.
Git (und Github) machen es **leicht** und
komfortabel **zu Open-Source-Projekten beizutragen**.

Als Entwickler schätze ich die Möglichkeit, meine **Commits
bereinigen, sortieren und kommentieren** zu können (interactive Rebasing),
bevor ich sie veröffentliche.

Außerdem ist Git stark,
wenn man in **Repositorys aufräumen** (Garbage Collection,
Rebasing, Filter-Branch, ...) möchte.
Das muss man zwar nicht täglich, aber wenn es nötig ist,
dann unterstützt einen Git dabei sehr..

Branching im Mercurial mag ich auch
-----------------------------------

Am **"Named Branches"** Modell mag ich, dass es so **schön
einfach** ist. Man kann es in wenigen Minuten erklären, und
trotzdem ist es **leistungsfähig** genug, um auch in großen Teams die
parallele Arbeit an vielen Feature-Branches organisieren zu können.
Dass die Commits auch die Historie der Branches wiederspiegeln,
ist nützlich, weil es oft **hilft Probleme aufzuklären**, wenn
sich mal jemand "verbranched" hat.

**Bookmarks** und **Phases** ermöglichen Git-ähnliche Workflows.
Vor allem aber erleichtern sie den Umgang mit **privaten
experimentellen Branches**.

[reflog-post]: /git/2012/05/09/reflog-fuer-bare-repositorys-in-git-einrichten/
[gc-post]: /git/2012/05/28/wer-hat-angst-vor-dem-garbage-collector/
