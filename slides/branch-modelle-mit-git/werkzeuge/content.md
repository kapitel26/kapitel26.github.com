___SECTION_______________________________


Basis Werkzeug
==============


_________________________________________


Branch
======


 * Kann an jedem Punkt der Historie abgezweigt werden.
 * Im Kern: Verweis auf ein Commit.
 * Lokales Konzept: Nicht jeder Branch muss überall existieren.


_________________________________________


Log
===

 * `a..b`
 * Kennt keine Branches


_________________________________________


Merge
=====

 * Die wichtigste Operation
 * Zusammenführung in neuem Commit.
 * Common Ancestore, 3-Wege


_________________________________________


Fast-Forward
============

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


To Merge or Not to Merge?
-------------------------

**Merges** zeigen die Integration in der Historie, <br/>
**Rebases** und **Fast-Forwards** und Fast-Forwards verbergen sie.


___SECTION_______________________________


Spezial-<br/>Werkzeuge
======================


_________________________________________


Cherry-pick
============


_________________________________________


Reset
=====


_________________________________________


Interactive Rebasing
====================
