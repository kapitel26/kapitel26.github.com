<!-- .slide: data-background-image="01/monorepo.png" -->


# MONOREPO


================================================================


### Wie viele
 
Dev Teams   
Files  
Lines of Code  
# **?**

notes:

TODO: Bild Auto-Quartett

Schätzen Sie!

über ihr **gesamtes Unternehnmen**

Dev Teams: Wer hat mehr als 2, 5, 10, 20, 50, 100, 500 

Files: Wer hat mehr als 1000, 10.000, 500.000, 1.000.000

Lines of Code: Wer hat mehr als 100.000, 1 Mio., 10 Mio., 100 Mio. 


================================================================


# Think Big!<br/><br/><br/><br/>

<!-- .slide: data-background-image="01/tyranno-watching.png" -->


================================================================


Kleines Gedankenexperiment:

## Tun Sie all das in
# **1 Repo**!



================================================================


... zu groß 
... zu träge 
... bürokratisch
... ständige Konflikte 
... und wo bleibt die Teamautonomie   
... voll unagil
... was geht mich das Zeug aus den anderen Abteilungen an
... zentralistisch
... jedes Klonen dauert ewig
...


================================================================


aber manche machen das, z. B.

 * Google
 * Facebook
 * Microsoft
 * Twitter

### sind die denn komplett verrückt?


================================================================


Ein **Monorepo** unterstützt

 * API Migrationen
 * Large Scale Refactorings
 * Umfassende Analysen: Data Lineage, Vulnerability Detection, Defect Detection, Usage Statistics
 * Aufräumen


================================================================


### One Repo to Rule them All!

 * **1** Repo für Alles™
 * **1** `master` zur Integration
 * Skalierbare Build-Pipeline mit Continuous Delivery 

> Google ist versioniert!

notes:

Stichwort: Trunk Based Development

Nicht alle Großen machen das: Amazon, Netflix


================================================================



> QUOD LICET JOVI
> NON LICET BOVI


Die Riesen dürfen und können das. 

Sollen wir, die Zwerge, nachziehen?

notes:

Diese Frage lassen wir offen.


================================================================


#### Diese Frage beantworten wir heute nicht. 


================================================================


### Dieser Talk  
### gibt Tipps,
### für GROßE REPOS in GIT


notes:

In diesem Talk, soll es **nicht** darum gehen,  
**ob** ein **Monorepo** das **Richtige** für Sie ist.

Aber, wenn Sie sich entschieden haben Monorepo zu machen,  
oder ihr Repo aus anderen Gründen groß ist,  
sind sie hier richtig.

Hier wollen wir eigen, welche **Herausforderungen** vor ihnen liegen, wenn sie ein **Monorepo mit Git aufbauen**, und welche **Lösungansätze** Git zu bieten hat. 

Wir wollen aber auch aufzeigen, wo dabei die **Grenzen von Git** liegen.

Viele der kommenden Tipps helfen auch, wenn sie "nur" ein großen Repo haben, ohne den Monorepo-Ansatz zu verfolgen.

z. B. ist der Linux-Kernel ein großes Repo. Man würde ihn aber eher nicht als *Monorepo* einordnen.


