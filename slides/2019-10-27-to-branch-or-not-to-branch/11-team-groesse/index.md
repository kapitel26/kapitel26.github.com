
<!-- .slide: data-background-image="11-team-groesse/grosse-truppen.png"  data-background-opacity="1"  data-background-size="contain" -->


================================================================


<!-- .slide: data-background-image="11-team-groesse/grosse-truppen.png"  data-background-opacity="0.4"  data-background-size="contain" -->


# Team Größe


Notes:

B: Und wie würdest du das machen,\
wenn ihr nicht ein Team wärt,\
sondern beispielsweise 25 Teams.\
Wenn die alle einem Repo arbeiten,\
wie Builds bekomme ich denn,\
wenn jeder Entwickler ca. jede halbe Stunde integriert.
  
R: Müssen die denn alle auf demselben Repo arbeiten?\
Die könnten doch auch separates Repos haben, \
unabhängig versionieren\ 
und zur Laufzeit über Microservices kommunizieren (Shared Nothing)

B: Aber 
  - REfactoring über REpogrenzen hinweg werden dann schwierig
  - Was ist dann überhaupt die gesamtversion
    - Meine Version kann funktionieren abhängigt vom Kontext
    - -> Client-Driven-Test, Contracts
    
B: Und wenn es dann doch ein Repo ist?

R: Dann spricht vieles für FB.\
Wie in Open Source Projekten (man kann ja nicht jeden auf den master lassen).
  

================================================================


### Fazit


Bei vielen Entwicklern in mehreren Teams,
ist der Overhead für FB oft gerechtfertigt.  
  
