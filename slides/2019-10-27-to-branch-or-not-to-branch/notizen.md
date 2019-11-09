
## Wie man mit Git richtig arbeitet

* Team vorstellen, wir bauen ein XY
* Release alle 14 Tage
  - Machen GitFow
* (evtl.) Machen Scrum, 6, 1 sm, 1 po, Haben Product Owner
* Task-Board JIRA
* 1..* Entwickler ziehen einen Tasks aus der Spalte Ready
* Erstellen Feature-branch für den Task
  `git checkout master`
  `git checkout -b dsakfjksdj`
* Entwickeln
* Vor dem fertigstellen develop reinmergen, test
* Pull-Request + featuree-build
* Review
* Nacharbeiten aus dem Review
* develop reinmergen, + feauter-build, erneut reviewen
* Auf develop integrieren
* auf develop build


================================================================


# To-Branch or not To-Branch

##Idee
* Vorab "konkretes" Projekt vorstellen
	* Scrum, FB
	* Kanban, Tasks
* Trunkbased in Entwicklung vs. Trunkbased bis Produktion	

* Definition Trunkbased
 * "reines", "pures"

* PRs

## Pro Feature-Branches
* isoliertes Arbeiten
* stabiler Master
* Peer-Reviews
	* Feature-Review
	* Review vor der Integration
* Fachlich gruppierte Änderungen
	* Mapping auf User-Stories	
- lange Feature-Branches sind oft problematisch
- Teilinkremente (Warten auf andere Features)
*- Selektives Mergen kann klappen meistens nicht
 * Erwartungshaltung von picken kurz vor dem Release	
* "Schöne" Historie (First-Parent) 
*- PO-Review auf Feature-Branches bevor es auf den Master kommt
*- Nicht alle Feature-Branches haben CI Pipeline
	* Höhere Ressourcenverbrauch des CI Servers
- Man neigt dazu, den Feature-Branch nicht immer "release-fähig" zu haben
-* Anderer Umgang mit Fehlern (Reverts)

##  Pro "reines" Trunkbased
* schnellere Integration (kein Warten auf PR)
	* Je mehr Branches um so langsamer
* "kein" isoliertes Arbeiten, Wissen was die anderen tun, schnelleres Feedback
* einfachere Merges / seltener Konflikte
* einfacheres Arbeiten mit Git etc (Anlegen von Branches, Mergen)
-* Feature-Togglz für nicht-fertige Features
(https://publish.twitter.com/?query=https%3A%2F%2Ftwitter.com%2Ftastapod%2Fstatus%2F1042036175228358657&widget=Tweet)
* immer genau eine gültige Version
* CI Server läuft bei jedem Push
* Im Falle eines Fehlers gibt es weniger Code-Änderungen
- Auch Irrwege sind enthalten
* Enums und Ids können einfacherer Eindeutig gehalten werden

# Erkenntnisse
* Mit Git hat man eigentlich immer einen lokalen "Feature-Branch"
* Forking-Workflows (ZeroMQ)
* OpenSource-Entwicklung vs Inhouse-Entwicklung

