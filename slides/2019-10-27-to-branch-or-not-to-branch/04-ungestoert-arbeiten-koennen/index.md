
<!-- .slide: data-background-image="04-ungestoert-arbeiten-koennen/ohren-zuhalten.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================

<!-- .slide: data-background-image="04-ungestoert-arbeiten-koennen/ohren-zuhalten.png"  data-background-opacity="0.4"  data-background-size="contain" -->
 

# Ungestört arbeiten können


Notes:


B: Entwickler brauchen Ruhe zum Arbeiten.
Bei uns könnnen die Entwickler mehrer Tage konzentriert 
und ungestört an einer Aufgabe arbeiten.

R: Git ist dezentral, 
man kann auf einem Klon lokal ebenso ungestört arbeiten wie auf einem Branch.
In einem lokalen Klon entsteht eine unabhängige Folge von Commits,
genau wie bei einem Feature-Branch,
solange bis man ein `pull` durchführt. 

B: Aber dann hat man ja kein Backup.

R: Mal ehrlich, wann ist Dir zum letzten Mal die Festplatte kaputt gegangen? 
Und wieviel Arbeit geht denn verloren, wenn Du alle paar Stunden integrierst.

R: Und überhaupt, wie lange dauern der eure Tasks denn normalerweise?

B: Ein paar Tage, höchstens eine Woche.

R: Dann kriegst du ja eine Woche lang gar nicht mit, 
was die anderen gemacht haben
und dann hast du den Ärger später beim Mergen.

R: Außerdem werden am Schluss große Änderungen zusammengeführt, 
die noch nie gemeinsam gelaufen sind.
  
B: Aber wenn ständig alle auf dem  `master` integrieren, 
dann wird man ja ständig durch Änderungen abgelenkt
die nichts zu tun haben, mit dem was man selber macht.

R: In Wahrheit merkt man von den meisten Merges fast gar nichts.
Weil die Änderungen klein sind 
und die Kollegen an anderen Stellen gearbeitet haben.

R: Außedem kann jeder Entwickler selber wählen, 
wann ein Pull durchgeführt wird.
Auch bei sehr konzentriertem Arbeiten, 
sollte man spätestens nach ein paar Stunden einen Zeitpunkt finden,
um pullen zu können, ohne aus dem Flow zu kommen.


================================================================


### Fazit: Unabhängig arbeiten können.

 * Git-technisch ist der Unterschied  
   zwischen Feature-Branch und `master`-Klon gering.
 * Bei TBD sind  
   die Zeiten zwischen Merges 
   meist kürzer(Stunden) als beim Feature-Branching (Tage)
 * Kleine Merges: Kleine Probleme
 * Große Merges: Große Probleme
 * Flow: Entwickler sollten selber bestimmen können,
   wann sie integrieren.

Sowohl trunk-based als auch beim Feauture-Branching können Entwickler ihren Flow finden.

