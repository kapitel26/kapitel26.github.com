Branch-Modelle mit Git (40 Minuten)
===========================

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

Wie?
----

Wohin noch?
-----------



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
