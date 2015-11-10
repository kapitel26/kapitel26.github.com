___SECTION_______________________________


Branch-Modelle
==============


_________________________________________

Gitflow
-------

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

Trunk-Based
-----------------------------

![Gitflow trunk](branch-modelle/abb-branching-strategie-trunk.png)

* Stabiler Master-Branch. Häufige Releases.
_________________________________________

Multiple Releases
-----------------

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

Code-Reviews
============

Hat man nur ein Quality-Gate und geht sofort in Produktion, <BR>
dann sind gute Code-Reviews wichtig.

_________________________________________

#### Das Problem

Bei Feature-Branches entstehen oft so viele Änderungen, dass das Review am Ende sehr komplex wird.


#### Lösungsansatz

Nicht "das Diff" am Ende des Branches reviewen<br/>
sondern jedes Commit einzeln.

_________________________________________

#### Das Problem dabei

Zu viele Commits. Oft zu unstrukturiert.

#### Lösung dazu

*Interactive Rebasing* schafft eine lesbare Historie.
