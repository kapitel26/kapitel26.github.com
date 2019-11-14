

<!-- .slide: data-background-image="12-zusammenfassung/two-visions-3.png"  data-background-opacity="1.0"  data-background-size="contain" -->


================================================================


 * **Ungestörtes Arbeiten**: Sowohl trunk-based als auch beim Feature-Branching können Entwickler ihren Flow finden.
 * **Stabile Basis**: Feature-Branching setzt mehr auf Prävention, Trunk-based-Development eher auf schnelle Problembehebung.
 * **Refactorings**: Trunk-based-Developmemnt erleichtert Refactorings.
 * **Schöne Historie**: Bei Feature-Branching kann man die Historie nutzen, um die Integration der Features darzustellen.

================================================================


 * **Truck-Faktor**: Pair Programming verringert den Truck-Faktor.
 * **Bug-Fixing**: Feature-Branching ermöglicht zielgenaues Bugfixing. Pragmatisch, ist "Forward-Fixing" oft effizienter.
 * **Feature-Picking**: Ein echtes wahlfreies Feature-Picking funktioniert auch in Feature-Branching nicht wirklich gut.
 * **Teamgröße**: Bei vielen Entwicklern in mehreren Teams auf dem selben Repo, 
   Monolithen und Open-Source-Projekten
   ist der Overhead für Feature-Branching oft gerechtfertigt.


================================================================


<!-- .slide: data-background-image="12-zusammenfassung/two-visions-3.png"  data-background-opacity="0.4"  data-background-size="contain" -->

## Well ... it depends.




===============================================================


Wenn es keinen besonderen Grund gibt, etwas Anderes zu tun, macht

    **Trunk Based Development**,
    
weil es einfach und schnell ist.


===============================================================


Es gibt aber Faktoren, welche die Waagschale in Richtung des Feature-Branching verschieben.

 * Langsamer Feedbackzyklus
    * langsamer Build und/oder Integegrationstest
 * Geringes Vertrauen in Qualität
    * z. B. bei schlechter Test-Coverage
 * Spezielle Review- und Dokumentationsanforderungen
    * durch gesetzliche Anforderungen oder Unternehmensprozesse
    * verteilte Standorte in verschiedenen Zeitzonen
    * Nachweispflicht für Änderungen
 * Art des Produkts
    * mehrere Produktreleases: Umgang mit Bugfixes und Backports
    * Open Source: Wenn Beiträge von unbekannten Autoren gereviewed und übernommen werden sollen.
 
Je mehr von diesen Faktoren zutreffen,
desto eher solltet Ihr in Erwägung ziehen, 
Feature-Branching zu machen.