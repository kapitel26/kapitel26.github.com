
<!-- .slide: data-background-image="02-feature-branching-team/wie-man-es-richtig-macht.png" data-background-color="0000FF" data-background-size="contain" -->

================================================================


<!-- .slide: data-background-image="02-feature-branching-team/team-feature-branching.png" data-background-color="0000FF" data-background-size="contain" -->


Notes:

Meine Leute!

8 wackere aber manchmal etwas übermütige Streiter

1 agiler Zuchmeister, der dafür sorgt, 
dass keiner aus der Reihe tanzt und wir strikt agil bleiben

Und meine Wenigkeit, der Produktvogt, 
also irdischer Stellvertreter der Bank of England, unseres Kunden, 
für die wir die Ehre habe entwickeln zu dürfen.

Jeden zweiten Mittwoch um Punkt 8:15 liefern
wir funktionierende Software aus.


================================================================


<!-- .slide: data-background-image="02-feature-branching-team/scrum-board.png"  data-background-size="contain" -->

Notes:

Alles geht vom Kunden aus.

 1. Am Montag morgen teilt der Kunde uns 
    seine Wünsche für den kommenden Sprint mit.
 1. Nun waltet der Produktvogt sortiert diese in das hlg. Backlog ein
    und wählt die Obersten davon für den nächsten Sprint aus.
 1. Diese werden vom Team ganz agil abgenickt,
 1. Dann commmited sich das Team auf die Erfüllung der Wünsche



Das Vorgehen ist einfach.

Ein Entwickler wird frei und nimmt sich die eine User Story,
die zu seinen Skilla passt, aus dem Backlog.

Erzeugt einen Branch (von `develop`, so heißt der Entwicklungsbranch.


===============================================================


<!-- .slide: data-background-image="02-feature-branching-team/feature-branch.png" data-background-size="contain" -->


Notes:

Arbeitet dann **ein paar Tage**
ungestört auf diesem Branch, bis die seine Arbeit abgeschlosssen.

Möchte seine Änderungen nach Develop bringen.

Aber Hoppla: Nicht so schnell! 
Da könnte ja jeder kommen und irgenden Schmutz in die Codebase bringen.
Nicht mit uns!

Deshalb haben wir die 1-2-3-Regel!


===============================================================


## Unsere goldene 
## 1-2-3-Regel

Vor dem Merge

 1. Audienz beim Produktvogt
 2. Review durch erfahrenen Kollegen
 3. Vorab Integrationstest

Notes:

 1. Produktvogt
    Produktvogt um eine Audienz (Review) bitten. Ggf. Nacharbeiten.
    Kommt schon mal vor, dass jemand die Spezifikation nicht genau gelesen hat.
    Dann darf man auch mal ein Stündchen länger bleiben.
 2. Code-Review
    Striktes Code-Review durch einen erfahrenen Kollegen.
 3. Vorab-integrationStart working
    Wärend der Entwickler gearbeitet hat, haben evtl. schon andere Kollegen Features 
    integriert.

Qualität geht vor. Deshalb geht sogleich nach dem Merge auf  `develop`
der automatische Build.

Anfangs kam es immer mal wieder vor, dass Änderungen den Build gebrochen haben.

Probleme in der agilen Entwicklung ergeben sich oft,
wenn einzelne Mitarbeiter nicht das richtige agile Mindset haben.

Doch dafür gibt es eine einfache Lösung.


================================================================


<!-- .slide: data-background-image="02-feature-branching-team/mindset-improver.png" data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="02-feature-branching-team/integration-merge.png" data-background-size="contain" -->


================================================================


## Und wenn ich sehen möchte,

## Was die anderen gemacht haben?



================================================================


<!-- .slide: data-background-image="02-feature-branching-team/update-merge.png" data-background-size="contain" -->


Notes:

... und seither vergisst kaum noch ein Entwickler\
vor Abschluss eines Feature-Branches den aktuellen Stand\
von `develop` herein zu mergen und die Integrationstests zu starten.


================================================================

<!-- .slide: data-background-image="02-feature-branching-team/release.png" data-background-size="contain" -->


Notes:


Feature-Freeze ab Montag, wenn wir mittwoch releasen

Keine Features-Merges nach develop mehr,\
noch noch einzelne Bugfixes-Branches. (Branch je Jira-Issue)

Entwickler testen dann auf Fehler.\
Der Produktvogt testet auf fachliche Defizite.

Prüft die liste aller Merges (First-Parent-History),\
schreibt die Release Notes\
und bereitet die Präsentation am Mittwoch morgen vor.
   
     
Am Dienstag Nachmittag wird der `develop` auf `master`gemerged, 
ein Versionstag vergeben
und es erfolgt **die Feature-Freigabe**


================================================================

# Bugs?

Notes:

Seit wir den Mindset-Improver haben, sind die natürlich selten geworden.

Ähemm ... trotzdem müssen wir zugeben, 
das kommt gelegentlich vor.

Aber wir haben ein striktes und klares Vorgehen.

================================================================


> Chuck Norris does not go bug hunting.\
> "Hunting" would imply the possibility of failure.\
> Chuck Norris goes bug killing.


================================================================


<!-- .slide: data-background-image="02-feature-branching-team/bugfix.png" data-background-size="contain" -->


Notes:

Kleine Fehler:

 1. Fix-Branch vom `master` abzweigen. TODO oder Release-branch
 2. Testen, in den `master` mergen.
 3. Master nach `develop` hochmergen.
 4. Mail an Entwickler, die ggf. `develop` in ihre Feature-Branches hochmergen.


Große Fehler:

Wir können auch ganze Features wieder Rückgang machen (Stichwort: Reverting Merges)


================================================================


## Und nun komme 

## der nächste Sprint


================================================================


## So arbeitet man mit Git!


================================================================


<!-- .slide: data-background-image="02-feature-branching-team/gral.png" data-background-size="contain" -->


Notes:


