
<!-- .slide: data-background-image="04-ungestoert-arbeiten-koennen/ohren-zuhalten.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================

<!-- .slide: data-background-image="04-ungestoert-arbeiten-koennen/ohren-zuhalten.png"  data-background-opacity="0.3"  data-background-size="contain" -->
 

# Ungestört arbeiten können


================================================================


# BILD

Zum Thema autarkes Arbeiten, Evtl. Entwickler mit Kopfhörer.


Notes:

Bezieht auf mental load in den Köpfen der Entwickler.

B: Entwickler brauchen Ruhe zum Arbeiten.
Bei uns könnnen die Entwickler mehrer Tage konzentriert 
und ungestört an einer Aufgabe arbeiten können.

R: Git ist dezentral, 
man kann auf einem Klon lokal ebenso ungestört arbeiten.
In einem lokalen Klon entsteht eine unabhängige Folge von Commits,
genau wie bei einem Feature-Branch,
solange bis man ein `pull` durchführt. 

B: Aber dann hat man ja kein Backup.

R: Mal ehrlich, wann ist Dir zum letzten Mal die Festplatte kaputt gegangen? 
Und wieviel Arbeit geht verloren, wenn Du alle par Stunden integrierst.

R: Und überhaupt, wie lange dauern der eure Tasks denn normalerweise?

B: Ein paar Tage, höchstens eine Woche

R: Dann kriegst du ja eine Woche lang gar nichts mit, 
was die anderen gemacht haben
und dann hast du den Ärger später beim Mergen.

R: Außerdem werden am Schluss große Änderungen zusammengeführt, 
die noch nie gemeinsam durch CI gelaufen sind.
  
B: Aber wenn ständig alle auf dem  `master` integrieren würden, 
dann wird man ja ständig durch Änderungen abgelenkt
die nichts zu tun haben, mit dem was man selber macht.

R: In Wahrheit merkt man von den meisten Merges fast gar nichts.
Weil die Änderungen klein sind 
und die Kollegen an anderen Stellen gearbeitet haben.

R: Außedem kann jeder Entwickler kann selber wählen, 
wann man ein Pull durchführt.
Auch bei sehr konzentriertem Arbeiten, 
sollte man spätestens nach ein paar Stunden einen Zeitpunkt finden,
um ein `pull` durchführen zu können, ohne aus dem Flow zu kommen.


================================================================


### Fazit: Unabhängig arbeiten können.

 * Git-technisch ist der Unterschied  
   zwischen Feature-Branch und `master`-Klon gering.
 * Bei TBD sind  
   die Zeiten zwischen Merges 
   meist kürzer(Stunden) als beim FB (Tage)
 * Kleine Merges: Kleine Probleme
 * Große Merges: Große Probleme
 * Flow: Entwickler sollten selber bestimmen können,
   wann sie integrieren.

Sowohl in TBD als auch beim FB können Entwickler ihren Flow finden.

