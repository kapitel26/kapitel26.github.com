

<!-- .slide: data-background-image="03-trunk-based-team/friends-gitflow.png" data-background-size="60%" -->


Notes:

([Zitat nicht vorlesen, einfach wirken lassen](https://twitter.com/tastapod/status/1042036175228358657?ref_src=twsrc%5Etfw%7Ctwcamp%5Etweetembed%7Ctwterm%5E1042036175228358657&ref_url=https%3A%2F%2Fpublish.twitter.com%2F%3Fquery%3Dhttps%253A%252F%252Ftwitter.com%252Ftastapod%252Fstatus%252F1042036175228358657%26widget%3DTweet))

R: WARUM SO KOMPLIZIERT?

R: Das geht auch einfacher!


================================================================


<!-- .slide: data-background-image="03-trunk-based-team/trunk-based-team.png"  data-background-size="contain" -->


Notes:

R: Aber erstmal möchte ich uns kurz vorstellen.

R: Meine 5 Leute und ich entwickeln und
betreiben Software für die East India Company.


================================================================


<!-- .slide: data-background-image="03-trunk-based-team/trunk-based.png" data-background-opacity="0.4" data-background-size="contain" -->

Der `master` ist die beste Version, 
die es jemals gab.

Jedes neue Commit macht ihn,
ein kleines bisschen besser.

Alles unser Wissen und Können steckt darin.

https://trunkbaseddevelopment.com/

Notes:

R: Wir brauchen nur EINEN BRANCH: den `master`!
R: Wir machen Trunk-Based-Development!\
R: Das ist viel einfacher und klarer.\
R: Alles was wir bauen, integrieren wir\
   so schnell wie möglich in den master,
   so dass alle sofort die Änderungen sehen.


================================================================


<!-- .slide: data-background-image="03-trunk-based-team/task-board.png" data-background-size="contain" -->


Notes:

R: Wir haben auch ein Board, aber nur 3 Spalten

R: Wir arbeiten im PAIR (bei 6 Leuten deshalb WIP: 3)

R: Es wird immer die oberste Karte aus Open gezogen.

R: Bei uns bedeutet ein Task meist nur ein paar Stunden Arbeit.
   Tagelange Tasks mögen wir nicht.


================================================================


<!-- .slide: data-background-image="03-trunk-based-team/master.png" data-background-size="contain" -->

Notes:

 * Die Entwickler "Pullen", erstellen Commits, und "Pushen",
   sobald die lokalen Tests grün sind.
 * Unfertige Features können über ein Feauture-Toggle
   nach belieben ein und ausgeschaltet werden.
 
 

================================================================


> Was man kaputt macht,\
> muss man reparieren.\
> Und zwar SOFORT!


=================================================================

## Bug-Fixing

 * `git stash`, 
 * Bug fixen auf `master` 
 * `git commit`
 * `git pull`, Testen, `git push`  
 * `git stash pop`, weiter machen
  

Notes:

Unsere Regel (siehe oben):

R: Sobald der Build bricht und Jenkins eine Mail verschickt

R: (oder ein Fehler aus PRD bekannt wird,)

R: geht eine Rote Karte ans Board

R: beginnen 2 Entwickler SOFORT mit dem Debugging:

R: `git stash` und `git pull` und los geht`s.

R: NULL DELAY!, Das geht sofort.

R: `git push` sobald, der Bug gefixed ist.


================================================================


Und wenn ich sehen möchte,

Was die anderen gemacht haben?

# Ratet mal ...


Notes:

Austausch mit anderen.


================================================================


# `git pull`


================================================================


## So arbeiten wir mit Git

 1. **Entwickler** ziehen einen Task auf **in Progress**
 2. Implementieren (ggf. mit Feature-Toggles)    
    <ul>
      <li>a. <code>git commit</code></li>
      <li>b. <code>git pull</code></li>
      <li>c. <code>git push</code>, sobald lokale Tests grün</li>
      <li>d. Falls noch nicht fertig, weiter bei a.</li>
    </ul>

 3. Task auf **Done**, weiter bei **1.**
 

      


================================================================


<!-- .slide: data-background-image="03-trunk-based-team/two-visions-1.png" data-background-size="contain" -->




================================================================


<!-- .slide: data-background-image="03-trunk-based-team/two-visions-2.png" data-background-size="contain" -->




================================================================


<!-- .slide: data-background-image="03-trunk-based-team/two-visions-3.png" data-background-size="contain" -->



Notes:

Umfrage: Wer gehört zu welchem Lager?

 * Eher trunk-based?
 * Eher feature-branching?
 
OK, dann müssen wir jetzt doch mal klären,
was richtig ist.