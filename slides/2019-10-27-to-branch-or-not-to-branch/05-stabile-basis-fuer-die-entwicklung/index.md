
<!-- .slide: data-background-image="05-stabile-basis-fuer-die-entwicklung/kartenhaus.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="05-stabile-basis-fuer-die-entwicklung/kartenhaus.png"  data-background-opacity="0.4"  data-background-size="contain" -->

# Stabile Basis für die Entwicklung


================================================================


# BILD

Kartenhaus?

Notes:


B: Nichts ist schlimmer als ein brüchiger Integrationsbranch (bei uns `develop`
 bei euch master).\
Bevor man sich mit der eigenen Story beschäftigen kann,\
muss man sich mit den Fehlern Anderer herumschlagen.\
Wir schaffen das durch sorgfältige Reviews\
und Integrationstest vor dem Merge.\
Wie haltet ihr euren `master` *grün*,\
Wenn alle gleichzeitig daran herumschrauben?

R: Git erzwingt, nicht ohne Grund,\
das Integrieren von Änderungen mit  `pull` vor dem `push`\
Ansonsten bekommt man einen Push-Reject.\
Unsere Entwickler machen nach einem Reject erstmal die Tests wieder grün,\
bevor sie erneut pushen.
   
B: Aber das hätte ich schon gerne automatisiert.\
Lenin hat gesagt: Vertrauen ist gut, Kontrolle ist besser.

R: Selbst wenn ein Fehler durchrutscht,\
unser Build dauert nur ein paar Minuten,\
und die "bösen" Entwickler erhalten sofort eine Email und fixen das Problem.

B: Der gebroche Build verursacht dann aber schon Kontextwechsel.

R: Es passiert aber nicht oft\
und sehr unmittelbar nach dem pushen


B: Wenn der Integrationstest ein paar Stunden braucht,\
funktioniert das dann aber nicht mehr so gut.

R: Nee das stimmt, aber in einem modernen Projekt kann man Tests so bauen, dass sie schnell laufen und bei Bedarf kann man diese parallelisieren.
Es gibt viele Projekte, die lange Tests haben,\
aber nur wenige, die sie wirklich brauchen.
  

================================================================


### Fazit: Stabilität

 * Ein brüchiger `master` (oder `develop`) nervt.
 * Beim FB sorgt man mit Reviews und Pre-Merge-Integrationstests\
   für Stabilität.
 * Beim TBD hingegen werden Probleme schneller erkannt und gefixed.
 * In kleinen erfahrenen Teams\
   wird der Integrationsbranch nur ab und zu mal *rot*.
 * Vertrauen statt Kontrolle funktioniert.
 * Lange Testsuiten sind ein Killer für TBD.

Für beide Verfahren ist ein stabiler Integrationsbranch (`master`, `develop`) essenziel.
FB setzt mehr auf Prävention, TBD eher auf schnelle Problembehebung.
