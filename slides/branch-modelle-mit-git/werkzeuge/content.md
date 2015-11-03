___SECTION_______________________________


Konzepte & Werkzeuge
====================


_________________________________________


Branch
======

![Branch Vorher](werkzeuge/abb-branches-beispiel-vorher.png)

Notes:

* Kann an jedem Punkt der Historie abgezweigt werden.

_________________________________________

Branch mit neuem Commit
-----------------------

 ![Branch Nachher](werkzeuge/abb-branches-beispiel-nachher.png)


_________________________________________


Wichtig: In Git ist ein Branch<br/>
ein Verweis auf ein Commit,<br/>
aber nicht Teil des Commits.

_________________________________________

Branchen ist leicht.

Aber wie bekommen wir das wieder zusammen?
===========================================

_________________________________________


 * Merge
 * Cherry-Pick
 * Rebase

_________________________________________

Merge
=====

  * Die wichtigste Operation
  * Zusammenführung in neuem Commit
  * Es entsteht ein Commit mit mehreren Parents

_________________________________________


Merge
--------------

  ![Branch Merge](werkzeuge/abb-branches-beispiel-merge.png)

_________________________________________

Fast-Forward-Merge (vorher)
---------------------------

![Vor FF](werkzeuge/abb-branches-beispiel-ff-vorher.png)

_________________________________________

Fast-Forward-Merge (nachher)
---------------------------

![Nach FF](werkzeuge/abb-branches-beispiel-ff-nachher.png)


_________________________________________


Fast-Forward
============

 * Vereinfacht den Graphen
 * Macht den Merge unsichtbar

_________________________________________

Cherry-Pick (Vorher)
--------------------

![Branch Nachher](werkzeuge/abb-branches-beispiel-nachher.png)

_________________________________________

Cherry-Pick (Nachher)
--------------------

 ![Rebase nachher](werkzeuge/abb-branches-beispiel-cherry-pick.png)

_________________________________________

Cherry-Pick
============

  * Kopiert Commits zwischen Branches.
  * Kein struktureller Zusammenhang zwischen kopierten Commits.

_________________________________________

Rebase (vorher)
--------------

  ![Rebase vorher](werkzeuge/abb-branches-beispiel-rebase-vorher.png)

_________________________________________

Rebase (nachher)
---------------

  ![Rebase nachher](werkzeuge/abb-branches-beispiel-rebase-nachher.png)

_________________________________________


Rebase
======

 * Verschiebt Commits des aktuellen Branches im Graphen
 * Sieht dann nachher so aus,<br/>
   als wäre der Branch erst später abgezweigt worden.

_________________________________________


Technisch passiert dabei Folgendes:

 * Commits werden an anderer Stelle neu erzeugt (kopiert).
 * Dann wird der Branchzeiger


   **Achtung!** Rebase verändert die Historie.

    * OK, für lokale Änderungen, weil niemand sonst die Commits kennt.
    * OK, für Features-Branches in geschlossenen Teams, wenn alle Entwickler danach einen harten Reset durchführen.
    * Nicht OK, sonst.

_________________________________________

1st-Parent History
==================

_________________________________________

History-Tree
------------

![History-Tree](werkzeuge/abb-1st-parent-history-0.png)

_________________________________________

Das History-Tree kennt keine Branches, <BR/>
nur Revisions und die Vorgänger-Beziehung.

**Merges** zeigen Integrationen, <BR/>
**Rebases**,  **Fast-Forwards** und **Cherry-Picks** verbergen sie.

Mit der Wahl der Werkzeuge bestimmt man,<BR/>
welche Integrationen das History-Tree zeigt.

_________________________________________

### 1st-Parents

![1st-Parent](werkzeuge/abb-1st-parent-history-1.png)

_________________________________________

Die Reihenfolge der Parents ist relevant.

**1st-Parent** ist das Commit, <BR/>
auf dem das Merge ausgeführt wurde.

Man kann als sehen, in welche Richtung integriert wurde.

_________________________________________

### 1st-Parent-History

![1st-Parent-History](werkzeuge/abb-1st-parent-history-2.png)

_________________________________________


Konzepte und Werkzeuge
======================

 * Branch
 * Merge
   - Fast-Forward
 * Cherry-Pick
 * Rebase
 * 1st-Parent-History
