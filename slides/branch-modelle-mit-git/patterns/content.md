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

### Feature-Branch

 * Entkoppelte Entwicklung
   - weniger Störungen
   - Basis für Reviews
 * Lebenszyklus je Feature
   - ermöglich unabhängige Releases
   - Typisch: Verknüpfung mit Issue-Tracker

_________________________________________


### Auf einem Feature-Branch gemeinsam arbeiten

Für einen Feature-Branch wünscht man sich eine lineare Historie.

Integration erfolgt daher durch `pull --rebase`.

Notes:

Rebase auch als Voreinstellung für Pull möglich.


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

(Auch Merge-Request genannt.)

_________________________________________


### Quality-Gate beim Pull-Request


![Feature Branches](patterns/abb-jenkins-pull-requests-stash-config.png)

(Beispiel aus Bitbucket Server, fka Atlassian Stash)


_________________________________________


Staging-Branches
----------------

![Staging-Branches](patterns/abb-staging-branches.png)

_________________________________________


Staging-Branches
----------------

Jeder Staging-Branches entspricht einem Qualitätsniveau, z. B. `stable` ist getestet und kann jederzeit in Produktion gehen.

_________________________________________


Merge-Ketten
------------

![Merge-Ketten](patterns/abb-merge-ketten.png)

_________________________________________

Merge-Ketten
------------

Merge-Ketten gehen von älteren Branches zu neueren Branches.

Geht man in die andere Richtung, spricht man von **Backporting**.

Notes:

Backporting erwähnen.
