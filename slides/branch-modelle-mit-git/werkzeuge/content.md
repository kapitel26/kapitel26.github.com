___SECTION_______________________________


Basis Werkzeuge
===============


_________________________________________


Branch
======

![Branch Vorher](werkzeuge/abb-branches-beispiel-vorher.png)

* Kann an jedem Punkt der Historie abgezweigt werden.

_________________________________________

 Branch mit neuem Commit
 -----------------------

 ![Branch Nachher](werkzeuge/abb-branches-beispiel-nachher.png)


  * Verweis auf ein Commit. Aber nicht Teil des Commits.

_________________________________________


Branchen ist leicht

Wie bekommen wir das wieder zusammen?
=====================================

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


 Nach dem Merge
 --------------

  ![Branch Merge](werkzeuge/abb-branches-beispiel-merge.png)


_________________________________________


Fast-Forward
============

 * Vereinfacht den Graphen
 * Macht den Merge unsichtbar

_________________________________________

Vor dem Fast-Forward
--------------------

![Vor FF](werkzeuge/abb-branches-beispiel-ff-vorher.png)

_________________________________________

Nach dem Fast-Forward
--------------------

![Nach FF](werkzeuge/abb-branches-beispiel-ff-nachher.png)


_________________________________________


 Cherry-Pick
 ============


  * Kopiert Commits zwischen Branches.
  * Kein struktureller Zusammenhang zwischen kopierten Commits.

_________________________________________

Vor dem Cherry-Pcik
-----------------------

![Branch Nachher](werkzeuge/abb-branches-beispiel-nachher.png)

_________________________________________

 Nach dem Cherry-Pick
 --------------------

 ![Rebase nachher](werkzeuge/abb-branches-beispiel-cherry-pick.png)

_________________________________________


Rebase
======
 * Kopiert Commits zwischen Branches.
 * **Und verschiebt den Branch-Zeiger**.

_________________________________________

 Vor dem Rebase
 --------------

 ![Rebase vorher](werkzeuge/abb-branches-beispiel-rebase-vorher.png)

_________________________________________

  Nach dem Rebase
  ---------------

  ![Rebase nachher](werkzeuge/abb-branches-beispiel-rebase-nachher.png)

_________________________________________

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


Basis Werkzeuge
===============

 * Branch
 * Merge
   - Fast-Forward
 * Cherry-Pick
 * Rebase
 * 1st-Parent-History
