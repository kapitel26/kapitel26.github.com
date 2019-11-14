---
layout: post
qcategory: Git
tags: [Branch, ConLi2019]
author: bst-rp
background: /slides/2019-10-27-to-branch-or-not-to-branch/13-abspann/abspann.png
---

## To Branch or Not to Branch

### Vortrag zur [Continuous Lifecycle 2019](https://www.continuouslifecycle.de)

Dies Frage war, ist und bleibt und heiß. 
Im Anschluss ergaben sich einige interessante Diskussionen mit Zuhörern.
Insbesondere wurden wir dann auch mehrfach gefragt,
wann wir denn Trunk-Based-Development und wann wir Feature-Branching empfehlen würden.
Deshalb haben wie die Präsentation um zwei Slides ergänzt.
Die Zusammenfassung unserer Empfehlung findet ihr unten.

#### [-> Slides als Vollbild](/slides/2019-10-27-to-branch-or-not-to-branch/)
#### [-> Slides zum Ausdrucken](/slides/2019-10-27-to-branch-or-not-to-branch?print-pdf)

<iframe src="/slides/2019-10-27-to-branch-or-not-to-branch" width="640" height="480" name="Slides embedded">
  [**To Branch or Not to Branch**](/slides/2019-10-27-to-branch-or-not-to-branch)
</iframe>


Wenn es keinen besonderen Grund gibt, etwas Anderes zu tun, dann macht

**Trunk Based Development**,
    
weil es einfach und schnell ist.


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
