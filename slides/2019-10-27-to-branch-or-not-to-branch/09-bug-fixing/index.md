
<!-- .slide: data-background-image="09-bug-fixing/bug-hunter.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="09-bug-fixing/bug-hunter.png"  data-background-opacity="0.4"  data-background-size="contain" -->

# Bug Fixing


Notes: 

TODO Außerdem Bild mit Ketten-Merges.
  
B: Beim Bug-Fixing hat FB aber klar die Nase vorn mit strukturiertem Vorgehen.\
Wir fixen genau jene Version, die in Production ist,\
und auch nur genau das was hierzu nötig ist.

R: Ich weiss. Und danach müsst ihr \
den Bugfix-Branch auf den Release-Branch mergen,\
den Release-Branch auf den master,\
den master auf develop,\
und wenn ihr Pech habt auch noch develop in die Feature-Branches.\
Wer soll da noch den Überblick behalten?

R: Und wenn jemand einen Bugfix an der falschen Stellen beginnt \
(z. B. auf dem FB), dann wird es richtig kompliziert,\
und nur noch berühmte Git-Buch-Autoren können euch\
für beindruckende Honorare retten ;-)

B: OK, OK. Aber ihr macht den Bugfix direkt auf dem `master` und\
released eine Menge Zeug gleich mit, das mit dem Fix nichts zu tun hat.

R: Bei uns ist der `master` die beste Version, die wir je hatten.

R: Außerdem sind unfertige oder nicht abgenommene Feature "weggetoggled".


================================================================


# Fazit

  * Git-Flow ermöglicht sehr zielgenaue Bugfixes 
    * Erfordert aber viel Know-How, Arbeit und Disziplin.
  * Bei Trunk-Based wird "Forward-Fixing" gemacht 
    * Erfordert immer produktionsreifen 'master'
    * Released immer alles
    * Neue Features können durch Toggles deaktivert sein

FB ermöglicht zielgenaues Bugfixing. Pragmatisch, ist "Forward-Fixing" oft effizienter.
