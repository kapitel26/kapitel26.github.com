

# Team Größe


================================================================

## Kleine Teams vs grosse/multiteams auf einem Repo

P Und wie wúRDEST du das machen, wenn ihr nicht ein Team wäret, sondern 6 Teams.

P Arbeiten die den alle und wie viele Builds bekomme ich denn,
  wenn jeder aller halbe stunde integriert.
  
C Müssen die denn alle auf demselben Repo arbeiten,
  Die könnten doch auch separates Repos haben, 
  unabhängig versionen
  und zur Laufzeit (Microservices) kommunizieren (Shared Nothing)

P Aber
  - REfactoring über REpogrenzen hinweg werden dann schwierig
  - Was ist dann überhaupt die gesamtversion
    - Meine Version kann funktionieren abhängigt vom Kontext
    - -> Client-Driven-Test, Contracts
    
P Und wenn es doch ein Repo ist

P Dann spricht vieles für Featurebased
  Wie in Open Source (man kann ja nicht jeden auf den master lassen).
  
### Fazit

Bei vielen Entwicklern in mehrren Teams,
ist der Overhead für FB oft gerechtfertigt.  
  
