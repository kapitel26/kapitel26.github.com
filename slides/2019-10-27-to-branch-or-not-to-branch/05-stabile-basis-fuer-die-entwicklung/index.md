

# Stabile Basis für die Entwicklung


================================================================


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



================================================================


### Fazit: Stabilität

 * In kleine erfahrenen Teams, wird der development nur gelegentlich rot.
 * Vertrauen statt Kontrolle funktioniert
 * Lange Testsuiten sind Killer für Trunkbased-Development, 
   weil man dann wieder jene Kontextwechsel erhält,
   die man eigentlich loswerden wollte.
