<!-- .slide: data-background-image="01/monorepo.png" -->

## Wie man mit Git richig arbeitet

* Team vorstellen, wir bauen ein XY
* Release alle 14 Tage
  - Machen GitFow
* (evtl.) Machen Scrum, 6, 1 sm, 1 po
* Haben Product Owner
* Task-Board JIRA
* 1..* Entwickler ziehen einen Tasks aus der Spalte Ready
* Erstellen Feature-branch für den Task
  `git checkout master`
  `git checkout -b dsakfjksdj`
* Entwickeln
* Vor dem fertigstellen
* dev reinmergen, test
* Pull-Request + feauter-build
* Review
* Nacharbeiten aus dem Review
* dev reinmergen, + feauter-build, erneut reviewen
* Auf dev integrieren
* aum dev build
* (evtl. Bugfixing, reverts)

## Warum so kompliziert?

Warum so viele Branches? So viele Tools?

## Autarkes Arbeiten 

Bezieht auf mental load in den Köpfen der Entwickler.

P Wir haben den coolen Vorteil, dass die Entwickler an einem Feature mehrer Tage konzentriert und ungestört arbeiten können.

C Git ist dezentral, man kann auf dem Klon lokal ungestört arbeiten so lange man will 
  und pushen wenn man fertig.

P Aber dann hat man ja kein backup.

C! Wann ist zum letzten Mal deine festplatte kaputt gegangen? 

C Und überhaupt, wie lange dauern der eure Tasks denn normalerweise?

P Ein paar Tage, höchstens eine Woche

C Dann kriegst du ja eine Woche lang gar nichts mit, was die anderen gemacht.

C! Und dann hast du den Ärger später beim Mergen.

C Außerdem werden am Schluss viele/grosse änderungen zummengeword, 
  die noch nie gemeinsam durch CI gelaufen sind.
  
P Aber wenn alle auf dem  master würden, 
  dann wird man ja ständig durch Änderungen abgelenkt
  die nicht zu tun haben, mit dem was man selber macht

C! Aber man kann selber wählen, wann man ein Pull durchführt.

C! Außerden sind die Integration meist harmlos, weil klein und durch CI gelaufen.

### Fazit

 * Technisch ist der Unterschied gering.
 * Aber Unterschied in der Bewerung des Nutzen von autarker Arbeit
   * entweder häufig integrieren (alle 1/2 Stund, oder alle 3 Tage)

## Stabiler dev-Branch

Ziel: dev jederzeit grün.

P Aber wenn alle alle halbe Stunde integrieren, wie halte ich dann den maser/dev grün?

C Git erzwingt, dass holeden der änderungen (pull/fetc) vor dem Push
  Mit gutem Grund: 
  Als verantwortungsvoller Entwickler würde vor dem push compilieren und testen
  
P Aber das hätte ich schon gerne (Lenin)

C Selbst wenn ein Fehler durchrutscht, würde der Build-Server das melden.

C Aber in einem dauer die Itestsuite 2 Stunden -> Feature
  (Dann hätte man einen halben Tag später eine)

P Aber in einem modernen Projekt hhätte man innerhalb von Minuten Feedback.

C Wenn es trotzdem rot, dass es sicht frü alle und klar, wer/was das verursacht hat
  (Erforderlich höchste PRIO, dass schnell repariert wird)
  
P Das ist aber auch wieder ein Kontextwechsel.

##  4 augen prinzip Sicherheit und Truck-Faktor

C Wer ist denn der Reviewer.

P Ein anderer Team, der nicht an dem Feature beteiligt war.

C Aber kann dann nur auf Code und Sicherheit, inhaltlich weiss der ja gar nicht worum es geht.

C! Würdest Du Pair Programming machen, dann hättest eine Blick auf Code und Sicherheit 
   aber zusätzlich auch einen fachlen Know-How-Transfer.
   - das gemeinsame Code durchgehen ist eh notwendig
   - den Truckfaktor echt zur verringen -> Random Pairings
   
C Code-Style, statische Analyse -> Automatisieren

C Variante nachgelagerte Reviews
  - zB bei Schliessen von JIRA am Platz
  
C Invest in Monitoring, und Recovery uU effizienter als vollständige Fehlervermeidung (Chaos Monkey)

Note commit-by-commit reviews

## schöne historie

P Aber bei uns sieht (anhand first-parent/merges) sehr schörn, wer wann was integriert hat

TODO Bild

C Feature Branches (ohne Rebasing ) werden trotzdem hässlich. 
  Und mit Rebasing erforden noch mehr git-know-how und Abstimmung.

TODO Bild

C! Wer schaut sich die globale Historie denn wirklich an. 

 * Release Notes
 * eher auf File annotate blame, verstehen was passiert ist
 * Grob granulaer vs. fein: Welches comit gehÓr zu jedem FEator
   - git diff X^1...X^2
   - Jira issue in commit-message
 * Reverten (und Cherrypicken) eines Feature (schwierig, wenn auf mehre commits verteilt)
   - wie oft tritt das auf? Bis wann geht das überhaupt?
   - Alternative: Einzelreverts oder manuell ausbauen
   - Revert
     - Undo ist kompliziert
     - Ist ohne fachliches des Features müglich
   

C! Außerdem habe wir JIRA

P Wir könne aus der Historie die Release Notes ableiten

  - REverten kann sehr unübersichtlich werden

C Könnte man aber auch aus JIRA holen

 
##  feature management, feature picking

P Vor dem Release, kann Der PO entscheiden, welche Features Reif sind

C Das ist brenzlig, weil die Integration dann fast vollständig ans Ende des Sprints verschoben werden

P Immerhin kann der PO entscheiden, welches Feature aufgenommen wird.

C Abhängigkeit zwischen Feature-Branches

P Wir verbieten zwischen Feature-Branches hin- und herzumergen

C Dann dauert es ja ewig, ein neue Feature zu beginne, 
  das einem andern Feauture basiert.
  
P Ggf. Zwischenmerges auf den Master/dev. Oder aufteilen. 
  In jedem organisatorischer Overhead.

P Aber der PO kann immer entscheiden, was fachlich integert.
  - trunk-based müsste er ja jedes einzelne Commit fachlich prüfen.
   
C Natürlich würde PO erst prúfen, wenn das Feature fachlich abgeschlossen (JITA zu)
 
P Aber denn sind fachlich unvollständig Zwiechenversionen auf dem angeblich stabilen master?

C Das Könnte man aber Feature-Togglen

## Kleine Teams vs grosse/multiteams auf einem Repo

P Und wie wúRDEST du das machen, wenn ihr nicht ein Team wäret, sondern 6 Teams.

P Arbeiten die den alle und wie viele Builds bekomme ich denn,
  wenn jeder aller halbe stunde integriert.
  
C Müssen die denn alle auf demselben Repo arbeiten,
  Die könnten doch auch separates Repos haben, 
  unabhängig versionen
  und zur Laufzeit (Microservices) kommunizieren (Shared Nothing)

P Aber
  - REfactoring über REpogrenzen hinweg werden dann schwierig
  - Was ist dann überhaupt die gesamtversion
    - Meine Version kann funktionieren abhängigt vom Kontext
    - -> Client-Driven-Test, Contracts
    
P Und wenn es doch ein Repo ist

P Dann spricht vieles für Featurebased
  Wie in Open Source (man kann ja nicht jeden auf den master lassen).
  
  
## Evtl Zwischenfazit zu Entwicklungsaspekten

Trunkbased

 * kleines, die eng zusammen arbeiten
 * schnellers Feedback, schneller integration
   - schneller Build erfoderlich
 * eher Vertrauten statuu kontrolle
 * eher monitoring/fixing statt prävention

FEauter Based

 * Größere TEams, Organsitionseinheiten, Open Source
 * formalere Prozesse, striktere Kontrolle über Inhalt
 * Hohe Anforderungen an dokumentierte Reviews
 * Schwer zu automatisierend/langlaufend Testcases
   Beispiele: SEcurity Dinge
 * Folgen von Fehlern schwer zu begrenzen (medizin, raumfahrt)
   


  



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