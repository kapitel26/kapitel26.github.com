___SECTION_______________________________


Branch-Modelle
==============


_________________________________________

Gitflow
=======

![Gitflow pur](branch-modelle/abb-branching-strategie-gitflow.png)

_________________________________________

Gitflow: Feature-Branch
------------------------

![Gitflow feature](branch-modelle/abb-branching-strategie-gitflow-patterns-feature-branch.png)

_________________________________________

Gitflow: Integrations-Branch
-----------------------------

![Gitflow integration](branch-modelle/abb-branching-strategie-gitflow-patterns-integrationsbranch.png)

_________________________________________

Gitflow: Pull-Request
-----------------------------

![Gitflow pr](branch-modelle/abb-branching-strategie-gitflow-patterns-pull-requests.png)

_________________________________________

Gitflow: Staging-Branch
-----------------------------

![Gitflow staging](branch-modelle/abb-branching-strategie-gitflow-patterns-staging-branch.png)

_________________________________________

Gitflow: Merge-Kette
-----------------------------

![Gitflow merge](branch-modelle/abb-branching-strategie-gitflow-patterns-merge-kette.png)

_________________________________________



Multiple Releases
=================

![Multiple](branch-modelle/abb-release-produkte.png)

_________________________________________

Multiple Releases mit Patterns
------------------------------

![Multiple](branch-modelle/abb-release-produkte-patterns.png)

_________________________________________



Backports
---------

![Backport](branch-modelle/abb-release-produkte-backport.png)

 * Cherry-Pick zum Kopieren des Bugfix.

_________________________________________


Continuous Delivery Modell
--------------------------

![CD](branch-modelle/abb-release-continuous-delivery.png)

 * Nur ein Quality Gate in Git.

_________________________________________

Reviews
========

Hat man statt einer wochenlangen Integrations- und Testphase, nur ein Quality-Gate und geht danach sofort in Produktion, dann werden gute Code-Reviews im Quality-Gate wichtiger.

_________________________________________

#### Das Problem

Selbst bei kleinen Features-Branches (wenige Personentage) entstehen oft so viele Änderungen, dass "das Diff" am Ende sehr unübersichtlich wird.


#### Lösungsansatz

Nicht "das Diff" am Ende des Branches reviewen<br/>
sondern jedes Commit einzeln.

_________________________________________

#### Das Problem dabei

Zu viele Commits. Oft zu unstrukturiert.

#### Lösung dazu

Commits zum Ende des Features-Branches mit interactive Rebasing aufräumen, so dass eine lesbare Historie entsteht, bei der jedes Commit eine erkennbare Intention hat.
