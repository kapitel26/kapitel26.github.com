

# Trunk Based Team


================================================================


# BILD

Kleiner Prinz 

> Perfektion ist nicht dann erreicht, \
> wenn es nichts mehr hinzuzufügen gibt, \
> sondern wenn man nichts mehr weglassen kann.
> (Antoine de Saint-Exupéry in "Der kleine Prinz")

und Sir René tritt auf

Notes:

(Zitat nicht vorlesen, einfach wirken lassen)

R: WARUM SO KOMPLIZIERT?

R: Das geht auch einfacher!


================================================================



# BILD

Sir René, 4 Soldaten 

Im Hintergrund Ein Schiff der East India Company

Notes:

R: Aber erstmal möchte ich uns kurz vorstellen.

R: Meine 5 Leute und ich entwickeln und
betreiben Software für die East India Company.


================================================================


# BILD

Baumstamm, lange Kiefer

Der `master` ist die beste Version, 
die es jemals gab.

Jedes neue Commit macht in,
ein kleines bisschen besser.

Alles unser Wissen und Können steckt darin.

TODO Link zu trunk-based-development.

Notes:

R: Wir brauchen nur EINEN BRANCH: den `master`!
R: Wir machen Trunk-Based-Development!\
R: Das ist viel einfacher und klarer.\
R: Alles was wir bauen, integrieren wir\
   so schnell wie möglich in den master,
   so dass alle


================================================================


# BILD

Tasks auf Board mit 3 Spalten

Open (WIP: 6), in Progress (WIP: 3), Done

Notes:

R: Wir haben auch ein Board, aber nur 3 Spalten

R: Wir arbeiten im PAIR (bei 6 Leuten deshalb WIP: 3)

R: Es wird immer die oberste Karte aus Open gezogen.

R: Bei uns bedeutet ein Task meist nur ein paar Stunden arbeit.
   Tagelange Tasks mögen wir nicht.


================================================================


# BILD

Integration auf dem Master

Nur Push und Pull.


Notes:

 * Die Entwickler "Pullen", erstellen Commits, und "Pushen",
   sobald die lokalen Tests grün sind.
 * Unfertige Features-können über ein Feauture-Toggle
   nach belieben ein und ausgeschaltet werden.
 
 

================================================================


# BILD

Jenkins, rote Ampel

> Was man kaputt macht,\
> muss man reparieren.\
> Und zwar SOFORT!


Notes:

Unsere Regel (siehe oben):

R: Sobald der Build bricht und Jenkins eine Mail verschickt

R: (oder ein Fehler aus PRD bekannt wird,)

R: beginnen die Entwickler SOFORT mit dem Debugging:

R: `git stash` und `git pull` und los geht`s.

R: NULL DELAY!, Das geht sofort.

R: `git push` sobald, der Bug gefixed ist.

 

================================================================


## Und wenn ich sehen möchte,\
Was die anderen gemacht haben?

# Ratet mal ...


Notes:

Austausch mit anderen.


================================================================


# `git pull`

