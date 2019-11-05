
# Slide: To Branch or Not to Branch

Ein Drama von René Preißel und Bjørn Stachmann


================================================================


Sir Bjørn Baron of the Branches

1 Produkt Vogt, Irdische Stellvertreter unseres Kunden, der Bank of ..., 
  sorgt dafür, das wir genau da bauen, was des Kunden Wunch ist.
  Und nicht irgendwelchen andern Unfug. 
1 Agiler Zuchtmeister, der dafür sorgt dass alle das gleiche agile und flexible Mindset haben
  und niemand aus der Reihe tanzt.
6 Soldaten


Note:

Ankündigung:
Ich kündige eine Korrektur an. 
Der angekündigt Titel ist falsch.


================================================================


Bild: To Branch or Not to Branch


================================================================


Bild: Mit Git entwickeln - wie man es richtig macht.


================================================================


Bild: Meine Leute



Note:

Wir bauen Software.
Unser Kunde, die Bank of ..., liebt Zuverlässigkeit.
Jeden zweiten Mittwoch um Punkt 8:15 liefern
wir funktionierende Software aus.


================================================================


Alles geht vom Kunden aus.


================================================================

## Das Backlog.


Montag: Kunde Nachmittag. Pre-Relase. 
Nach Abnahme der Featuren des vorigen Sprints.
Kunde teilt uns seine neuen Wünsche mit.
Nun waltet der Produktvogt und 
und sortiert diese in das hlg. Backlog ein.
Diese werden dann vom Team agil abgenickt.
Dann committed das Team die Wünsche des Kunden für den nächsten Sprint.


================================================================


# User Storys

Das Vorgehen ist einfach.

Ein Entwickler wird frei und nimmt sich die oberste User Story aus dem Backlog.

Erzeugt einen Branch (von `development`, so heißt der Entwicklungsbranch.


===============================================================


# Ungestörtes Arbeiten

Arbeitet dann ungestört auf diesem Branch, bis die seine Arbeit abgeschlosssen.

Möchte seine Änderungen nach Development bringen.


===============================================================

# Die 1-2-3-Regel

Aber Hoppla: Nicht so schnell! 
Da könnte ja jeder kommen und irgenden Schmutz in die Codebase bringen.
Nicht mit uns!

 1. Produktvogt
    Produktvogt um eine Audienz (Review) bitten. Ggf. Nacharbeiten.
    Kommt schon mal vor, dass jemand die Spezifikation nicht genau gelesen hat.
    Dann darf man auch mal ein Stündchen länger bleiben.
 2. Code-Review
    Striktes Code-Review durch einen erfahrenen Kollegen.
 3. Vorab-integrationStart working
    Wärend der Entwickler gearbeitet hat, haben evtl. schon andere Kollegen Features 
    integriert.

In der Zwischenzeit haben Kollegen bereits Änderungen in das Review.


================================================================

Qualität geht vor. Deshalb geht sogleich nach dem Merge auf  `development`
der automatische Build.

Anfangs kam es immer mal wieder vor, dass Änderungen den Build gebrochen haben.

Doch dafür gab es eine einfache Lösung.


================================================================


## Der Mind-Set-Improver


================================================================


# Releases

## Feature-Freeze

Keine Features-Merges nach development mehr, 
noch noch einzelne Bugfixes-Branches. (Branch je Jira-Issue)

Ab Montag Morgen, beginnt die Release Phase.

 * Entwickler testen technisch
 * Produktvogt testet Fachlich
   Prüft die liste aller Merges (First-Parent-History)
   Schreibt die Release Notes
   und bereitet die Präsentation am Mittwoch morgen vor.
   
   
(Entwickler dürfen, wenn es nichts mehr zu testen gibt, neue Features beginnen, aber nicht mergen.)   
   
Am späten Dienstag Nachmittag wird der `develop` auf `master`gemerged, ein Versionstag vergeben
und es erfolgt **die Feature-Freigabe**

================================================================


# Die Demo

Mittwoch findet dann die Präsentation statt.


================================================================

# Bugs?

Seit wir den Mind-set-improver haben, sind die natürlich selten geworden.

Ähemm ... trotzdem müssen wir zugeben das kommt vor.

Aber wir haben ein striktes und klares Vorgehen.


================================================================


Chuck Norris does not go Bug hunting.
Chuck Norris goes But killing.
"Hunting" would imply the possibility of failure.


================================================================




## Handling Bugs

Jira-Issue

Branch vom `master` abzweigen.

Testen, in den `master` mergen.

Master nach `develop` hochmergen.

Mail an Entwickler, die ggf. `develop` in ihre Feature-Branches hochmergen.





================================================================





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

## Warum so kompliziert?

https://publish.twitter.com/?query=https%3A%2F%2Ftwitter.com%2Ftastapod%2Fstatus%2F1042036175228358657&widget=Tweet

Warum so viele Branches? So viele Tools?

C Wir machen trunk based development, das ist viel einvacher

TODO link auf TB webseite

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

C Außerdem werden am Schluss viele/grosse änderungen zummengeführt, 
  die noch nie gemeinsam durch CI gelaufen sind.
  
P Aber wenn ständig alle auf dem  master integrieren würden, 
  dann wird man ja ständig durch Änderungen abgelenkt
  die nicht zu tun haben, mit dem was man selber macht

C! Aber man kann selber wählen, wann man ein Pull durchführt.

C! Außerden sind die Integration meist harmlos, weil klein und durch CI gelaufen.

### Fazit

 * Technisch ist der Unterschied gering.
 * Aber Unterschied in der Bewerung des Nutzen von autarker Arbeit
   * entweder häufig integrieren (alle 1/2 Stund, oder alle 3 Tage)

## Stabiler develop-Branch

Ziel: develop jederzeit grün.

P Aber wenn alle alle halbe Stunde integrieren, wie halte ich dann den maser/develop grün?

C Git erzwingt, dass holeden der änderungen (pull/fetc) vor dem Push
  Mit gutem Grund: 
  Als verantwortungsvoller Entwickler würde vor dem push compilieren und testen
  
P Aber das hätte ich schon gerne automatisiert (Lenin)

C Selbst wenn ein Fehler durchrutscht, würde der Build-Server das melden.

C Aber in einem die Test dauer die Itestsuite 2 Stunden -> Feature
  (Dann hätte man einen halben Tag später eine)

P Aber in einem modernen Projekt hhätte man innerhalb von Minuten Feedback.

C Wenn es trotzdem rot, dass es sicht frü alle und klar, wer/was das verursacht hat
  (Erforderlich höchste PRIO, dass schnell repariert wird)
  
P Das ist aber auch wieder ein Kontextwechsel.


### Fazit 

 * In kleine erfahrenen Teams, wird der development nur gelegentlich rot.
 * Vertrauen statt Kontrolle funktioniert
 * Lange Testsuiten sind Killer für Trunkbased-Development, 
   weil man dann wieder jene Kontextwechsel erhält,
   die man eigentlich loswerden wollte.

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

C Das Abschliesenn von Feature-Branches erfordere eine REihe von Kontext und Toolwelche
  Master reinmergen, PR anlegen, Testergebnis abwarten, PR Reviewen, Nacharbeite, ...

Note commit-by-commit reviews

### Fazit

 * Pair Programming: Fachlicher Know How Transfer + Review-Charakter
 * Nachvollziehbarkeit von Reviews -> Pull-Requests
 * Style etc. soweit móglich automatisieren
 * Trade-Off Prävention vs. Fehlerbehebung
 
## schöne historie

P Aber bei uns sieht (anhand first-parent/merges) sehr schön, wer wann was integriert hat

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


### Fazit

 * Braucht man eine schöne Historie
 * First-Parent
   - Commit nach Features gruppiert
   - Release Historie ablesbare
 
##  feature management, feature picking

P Vor dem Release, kann Der PO entscheiden, welche Features reif sind

C Das ist brenzlig, weil die Integration dann fast vollständig ans Ende des Sprints verschoben werden

P Immerhin kann der PO entscheiden, welches Feature aufgenommen wird.

C Abhängigkeit zwischen Feature-Branches

P Wir verbieten zwischen Feature-Branches hin- und herzumergen

C Dann dauert es ja ewig, ein neue Feature zu beginnen, 
  das einem andern Feauture basiert.
  
P Ggf. Zwischenmerges auf den Master/dev. Oder aufteilen. 
  In jedem organisatorischer Overhead.

P Aber der PO kann immer entscheiden, was fachlich integert.
  - trunk-based müsste er ja jedes einzelne Commit fachlich prüfen.
   
C Natürlich würde PO erst prúfen, wenn das Feature fachlich abgeschlossen (JITA zu)
 
P Aber denn sind fachlich unvollständig Zwiechenversionen auf dem angeblich stabilen master?

C Das Könnte man aber Feature-Togglen

 * Lang laufende Branches
   - geparkte Feauter Branches
   - Migrationsbranche

### Fazit

 * FB gibt direktere Kontroller über die Integration von Features
 * Mehrfachintegration kurz vor schluss ist auch bei FB nicht empfehlenswert
 * In FB soll man Cross-Mergen meiden
 * Das Teilen von zwischenergebnissen in FB zieht organisatorischen overhead nach sich
   und erroder mehr git skill.
 * In TB akzeptiert man, dass unvollständige Features (aber immer grün)
 * in TB geben Feature-Toggles dem PO die Kontroller über Features

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
  
### Fazit

Bei vielen Entwicklern in mehrren Teams,
ist der Overhead für FB oft gerechtfertigt.  
  
  
## Umgang mit Bugs  
  
  * Trunk-Based bis Release = Continuous deliviery
    - Forward fixing
  * Git-Flow Hotfix - Feature- Brances fúr Releases
    Hier Reviewbloxk besonder wichtig.
    - Erfodert hohe Git und Prozesskenntnisse
  
  
## Fazit zu Entwicklungsaspekten

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


================================================================


