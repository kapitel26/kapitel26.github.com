___SECTION_______________________________


Patterns & Practices
====================


_________________________________________


Feature-Branch
--------------


Notes:

Das elementarste Pattern

Wichtig: Verknüpfung mit Issue-Tracker



_________________________________________


Branch aktualisieren
--------------------


 * Rebase: Besser für Reviews (auf Feature-Branches).
 * Merge: Wo kein Rebase möglich (z. B. auf Integrations-Branches).


Notes:


Alternativ: rerere



_________________________________________


(Teil-) Ergebnis Mergen
-----------------------


Notes:

Langlebige Feature-Branches vermeiden.
Oft Besser: Mergen und neuen Feature-Branch aufmachen.
Jira (Problem: Issue nummer schon belegt): Neuen Task als Obertask. Alten Task in Subtask umwandeln. Dann neuen Subtask aufmachen.

_________________________________________


Branch begradigen
-----------------

 * `pull --rebase`
 * Oder durch Voreinstellung

 * Nach dem Merge entsteht ein Pull
 * Unnötige Merges weg-Rebasen


_________________________________________


Integrations-Branch
-------------------


Notes:

Nur Merges, kein ff.

Mach klar, wann was integriert wurde.


_________________________________________


1st-Parent History
------------------

_________________________________________


Rebase vor dem Merge, macht die Historie lesbarer.


_________________________________________


Pull-Request
------------



_________________________________________


Quality Gate
------------



_________________________________________


Release-Branch
--------------


Note:

Zwei Gründe: Entweder man hat mehrer Releases parallel. Oder man braucht.

Feature-Branches auf Release-Branches nennt man Hotfix-Branches.


_________________________________________


Merge-Ketten
------------


_________________________________________


Code-Freeze-Branch
------------------
