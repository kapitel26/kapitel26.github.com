

# Stabile Basis für die Entwicklung


================================================================

# BILD

Kartenhaus?

Notes:



================================================================


B: Nichts ist schlimmer als brüchiger Integrationsbranch (bei uns `develop`).\
Bevor man sich mit der eigenen Story beschäftigen kann,\
muss man sich mit den Fehlern Anderer herumschlagen.\
Wir schaffen das durch sorgfältige Reviews\
und Integrationstest vor dem Merge.\
Wie haltet ihr euren `master` *grün*,\
Wenn alle gleichzeitig daran herumschraubt?

R: Git erzwingt, nicht ohne Grund,\
das Integrieren von Änderungen mit  `pull` vor dem `push`\
nach einen Push-Reject.\
Unsere Entwickler machen nach einem Reject erstmal die Tests wieder grün,\
bevor sie erneut pushen.
   
B: Aber das hätte ich schon gerne automatisiert.\
Lenin hat gesagt: Vertrauen ist gut, Kontrolle ist besser.

R: Selbst wenn ein Fehler durchrutscht,\
unser Build dauert nur ein paar Minuten,\
und die "bösen" Entwickler erhalten sofort eine Email.

B: Der gebroche Build verursacht dann aber schon Kontextwechsel.

R: Es passiert aber nicht oft\
Und der Fehler ist fast immer schnell behoben,\
denn die Änderungen seit dem letzen erfolgreichen Build sind klein.

B: Wenn der Integrationstest ein paar Stunden braucht,\
funktioniert das dann aber nicht mehr so gut.

R: Nee, in einem modernen Projekt sollte das kaum nötig sein.
Es viele Projekte, die lange Tests haben,\
aber nur wenige, die sie wirklich brauchen.
  

================================================================


### Fazit: Stabilität

 * Ein brüchiger `master` (oder `develop`) nervt.
 * Trade-Off: Invest in Prävention vs. Schnelle Reparatur 
   - Beim FB sorgt man mit Reviews und Pre-Merge-Integrationstests\
     für Stabilität.
   - Beim TBD hingegen werde die  Probleme oft\
     schneller erkannt und gefixed.
 * In kleinen erfahrenen Teams\
   wird der Integrationsbranch nur ab und zu mal *rot*.
 * Vertrauen statt Kontrolle funktioniert.
 * Lange Testsuiten sind ein Killer für TBD,\
   weil man dann genau jene Kontextwechsel erhält,\
   die man eigentlich loswerden wollte.

