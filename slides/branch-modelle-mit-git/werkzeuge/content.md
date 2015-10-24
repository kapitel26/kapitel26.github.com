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


History-Tree
------------


### 1st-Parent History

History-Tree kennt keine Branches

 * Bild: Nur 3 Lanes, aber eine Raute auf dem Feature-Branch

Rebase vor dem Merge, macht die Historie lesbarer.


**Merges** zeigen die Integration in der Historie, <br/>
**Rebases** und Fast-Forwards verbergen sie.
