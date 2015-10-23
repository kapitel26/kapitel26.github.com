___SECTION_______________________________


Basis Werkzeuge
===============


_________________________________________


Branch
======


 * Kann an jedem Punkt der Historie abgezweigt werden.
 * Im Kern: Verweis auf ein Commit. Aber nicht Teil des Commits.


_________________________________________


Branchen ist leicht

Wie bekommen wir das wieder zusammen?
=====================================

 * Merge
 * Rebase
 * Cherry-Pick


_________________________________________


Merge
=====

 * Die wichtigste Operation
 * Zusammenführung in neuem Commit.
 * Es entsteht ein Commit mit mehreren Parents.


_________________________________________


### Fast-Forward

 * Vereinfacht den Graphen
 * Macht den Merge unsichtbar


_________________________________________


Rebase
======


_________________________________________


**Achtung!** Rebase verändert die Historie.

 * OK, für lokale Änderungen, weil niemand sonst die Commits kennt.
 * OK, für Features-Branches in geschlossenen Teams, wenn alle Entwickler danach einen harten Reset durchführen.
 * Nicht OK, sonst.

_________________________________________


Cherry-pick
============


 * Bild malen.


_________________________________________


History-Tree
------------


### 1st-Parent History

History-Tree kennt keine Branches

 * Bild: Nur 3 Lanes, aber eine Raute auf dem Feature-Branch

Rebase vor dem Merge, macht die Historie lesbarer.


**Merges** zeigen die Integration in der Historie, <br/>
**Rebases** und Fast-Forwards verbergen sie.
