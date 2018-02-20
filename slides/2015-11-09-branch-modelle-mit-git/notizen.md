Branch-Modelle mit Git (40 Minuten)
===========================

 1. Warum (BST)
 2. Werkzeuge (RP)
 3. Patterns (BST)
 4. Branch-Modelle (RP)
 5. Fazit (BST)


Warum?
------

Darstellen, warum es sich lohnt, sich mit Branching-Modellen zu beschäftigen.

Idee/Ansatz: Praktische Probleme anekdotisch beschreiben.

 * Bugfixes/Features in mehreren Releases
 * Nachvollziehbarkeit des Projektstatus (Jira, Stash, Git)
 * Reviews
 * Unabhängigkeit des Entwicklers vs. vermischte Trunks

Außerdem:

 * External Contribution
 * Continuous Delivery, Release/Deployment-Automatisierung
 * Integrationstestphasen (Wasserfall)
 * Silo-Workflows

Was?
----

Werkzeuge Bausteine. Was bietet Git.

Basics: Branch, Merge (Inkl. Fast-Forward/no-ff-Merges, 3-Wege-Merge), Udate-Merges, Rebase, Interactive Rebase, Log/History, Cherry-pick

Basics Tooling: Pull-Request,

Aufbauend: Feature-Branch, Integrationsbranch, Release-Branch, Hotfix-Branches, Code-freezes, Quality Gate, 1st-Parent-History, Hoch- und Ketten-mergen, Merge-Check, Variant-Branches/Patch-Queues

Wie?
----



Wohin noch?
-----------

Evtl. Rerere.

Komplexere Versionierung mit Subtrees, Submodules oder externem Dependency-Management.

Umgang mit Varianten. Branches als Patch Queue.


Checkliste oder Matrix zur Auswahl einer Branching Strategie.

Themen
------

Lesbare Historie erstellen

Lauffähigkeit von master/stable/release vs. temporäre Unbrauchbarkeit

Undoing Merges

Begriffe, Techniken
-------------------

1st-Parent history

Hoch-mergen

Cherry-pick

Rebasing

Notizen zum Buch
----------------

Feature-Branches S. 169, evtl. nach gescheitertem Push das eigene Merge rebasen.

Feature-Branches S. 169, `git push origin :feature-a` ist veraltet --delete

Feature-Branches S. 170, Pull-Requests in Stash/Github, verhalten auf Server Seite bzgl. First-Parent-History

TODO
----



Log-Statement
