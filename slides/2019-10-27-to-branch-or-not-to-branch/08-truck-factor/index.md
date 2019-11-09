

# Truck Faktor


================================================================



##  4 augen prinzip Sicherheit und Truck-Faktor

C Wer ist denn der Reviewer.

P Ein anderer Team, der nicht an dem Feature beteiligt war.

C Aber kann dann nur auf Code und Sicherheit, inhaltlich weiss der ja gar nicht worum es geht.

C! Würdest Du Pair Programming machen, dann hättest eine Blick auf Code und Sicherheit 
   aber zusätzlich auch einen fachlen Know-How-Transfer.
   - das gemeinsame Code durchgehen ist eh notwendig
   - den Truckfaktor echt zur verringen -> Random Pairings
   
C Code-Style, statische Analyse -> Automatisieren

C Variante nachgelagerte Reviews
  - zB bei Schliessen von JIRA am Platz
  
C Invest in Monitoring, und Recovery uU effizienter als vollständige Fehlervermeidung (Chaos Monkey)

C Das Abschliesenn von Feature-Branches erfordere eine REihe von Kontext und Toolwelche
  Master reinmergen, PR anlegen, Testergebnis abwarten, PR Reviewen, Nacharbeite, ...

Note commit-by-commit reviews

### Fazit

 * Pair Programming: Fachlicher Know How Transfer + Review-Charakter
 * Nachvollziehbarkeit von Reviews -> Pull-Requests
 * Style etc. soweit móglich automatisieren
 * Trade-Off Prävention vs. Fehlerbehebung
