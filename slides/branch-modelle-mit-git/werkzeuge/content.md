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


Wichtig!
-------

In Git ist ein Branch<br/>
ein **Verweis** auf ein Commit,<br/>
aber **nicht Teil** des Commits.

_________________________________________

#### Branchen ist leicht.

## Aber wie bekommen wir das wieder zusammen?

_________________________________________


 * Merge
 * Cherry-Pick
 * Rebase

_________________________________________

Merge
=====

![Branch Merge](werkzeuge/abb-branches-beispiel-merge.png)

_________________________________________


Merge
--------------

* Erzeugt neues Commit
* Zwei Parents

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

  * Kopiert Commits
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

 * Kopiert Commits
 * Sieht dann nachher so aus,<br/>
   als wären die Commits verschoben.

_________________________________________

   Achtung! -  Rebase verändert die Historie.
   ------------------------------------------

    * OK, für lokale Änderungen.
    * OK, für Features-Branches in geschlossenen Teams.
    * Nicht OK, sonst.

_________________________________________

History-Tree
------------

![History-Tree](werkzeuge/abb-1st-parent-history-0.png)

_________________________________________

**Merges** zeigen Integrationen, <BR/>
**Rebases** und **Cherry-Picks** verbergen sie.
<BR/>

Mit der Wahl der Werkzeuge bestimmt man,<BR/>
welche Integrationen das History-Tree zeigt.

_________________________________________

1st-Parents
-----------

![1st-Parent](werkzeuge/abb-1st-parent-history-1.png)

_________________________________________

1st-Parent-History
------------------

![1st-Parent-History](werkzeuge/abb-1st-parent-history-2.png)

_________________________________________

**1st-Parent** dient als Heuristik für Branch-Zugehörigkeit

_________________________________________



Konzepte und Werkzeuge
-----------------------

 * Branch
 * Merge
 * Cherry-Pick
 * Rebase
 * 1st-Parent-History
