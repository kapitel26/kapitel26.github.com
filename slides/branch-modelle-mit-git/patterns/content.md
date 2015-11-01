___SECTION_______________________________


Patterns & Practices
====================


_________________________________________


Feature-Branch
--------------


![Feature Branches](patterns/abb-feature-branches.png)

Notes:

Das elementarste Pattern

Wichtig: Verknüpfung mit Issue-Tracker



_________________________________________


### Gemeinsames Arbeiten

Branch begradigen

 * `pull --rebase`
 * Oder durch Voreinstellung

 * Nach dem Merge entsteht ein Pull
 * Unnötige Merges weg-Rebasen





_________________________________________


Integrations-Branch
-------------------


![Integrations-Branch](patterns/abb-integrationsbranch.png)


_________________________________________

### Integrations-Branch

 * Integriert Änderungen anderer Branches.
 * Keine direkte Entwicklung auf diesem Branch.
 * Enthält nur **Merges**.
 * **1st-Parent-History** zeigt die Folge der  Integrationen<BR/>
   z. B. "Feature 1", "Bugfix 1", "Feature 2"

_________________________________________


Pull-Request
------------

![Pull-Request](patterns/abb-pull-request.png)


_________________________________________


### Quality-Gate beim Pull-Request


![Feature Branches](patterns/abb-jenkins-pull-requests-stash-config.png)

(Beispiel aus Bitbucket, fka Atlassian Stash)


_________________________________________


Staging-Branches
----------------

![Staging-Branches](patterns/abb-staging-branches.png)

_________________________________________


Merge-Ketten
------------


 * Dasselbe Bild mit einer hervorgehobenen Merge-Kette.
