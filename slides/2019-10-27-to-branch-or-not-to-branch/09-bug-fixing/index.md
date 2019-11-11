
<!-- .slide: data-background-image="09-bug-fixing/bug-hunter.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="09-bug-fixing/bug-hunter.png"  data-background-opacity="0.4"  data-background-size="contain" -->

# Bug Fixing


Notes: 

TODO Außerdem Bild mit Ketten-Merges.
  
B: Beim Bug-Fixing hat FB aber klar die Nase vor mit strukturiertem Vorgehen.\
Wir fixen genau jene Version, die in Production ist,\
und auch nur genau das was hierzu nötig ist.

R: Ich weiss. Und danch müsst ihr \
den Bugfix-Branch auf den Release-Branch mergen,\
den Release-Branch auf den master,\
den master auf develop,\
und wenn ihr Pech habt auch noch develop in die Feature-Branches.\
Wer soll da noch den Überblick behalten?

R: Und wenn jemand einen Bugfix an der falschen Stellen beginnt \
(z. B. auf dem FB), dann wird es richtig kompliziert,\
und nur noch namhafte Git-Buch-Autoren können euch\
für exorbitante Honorare retten ;-)

B: OK, OK. Aber ihr macht den Bugfix direkt auf dem `master` und\
released eine Menge Zeug gleich mit, das mit dem Fix nichts zu tun hat.

R: Bei uns ist der `master` die *beste Version, die wir je hatten*.

R: Außerdem sind unfertige oder nicht abgenommene Feature "weggetoggled".


================================================================


# Fazit

  * Git-Flow Bug-Fixing
    - Ausgehend von Release-Version
    - Fixed aber exakt die Zielversion
    - Merge-Ketten
    - erforder Git-und Prozess-Know-How
  * Trunk-Based Bug-Fixing
    - Forward fixing Strategie
    - Immer auf dem `master`, kein Sonderprozess nötig
    - Unfertiges "wegtogglen"
    - Erfordert weniger Skills
    - Ggf. höheres Risiko, weil mehr Code im Fix ausgerollt wird.
