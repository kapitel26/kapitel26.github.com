---
layout: post
title: "Continuous Lifecycle Konferenz 2015 - Dienstag"
category: Git
tags: [Branch, ConLi2015]
author: bst
---

### Branching-Modelle mit Git

(unser Vortrag)

<iframe src="/slides/branch-modelle-mit-git/" width="480" height="300" name="Slides embedded">
  [**Branch-Modelle mit Git**](/slides/branch-modelle-mit-git/)
</iframe>

[**-> Slides als Vollbild**](/slides/branch-modelle-mit-git/)

## Was sonst so passiert ist

### The Rationale for Continuous Delivery

(Dave Farley)

Mich muss man ja nun nicht mehr davon überzeugen, dass Continuous Delivery notwendig ist, um innovative Software zu entwickeln. Ich habe das (bei etracker) ja über mehrere Jahre erlebt, und bin, zurückhaltend formuliert, *sehr überzeugt*. Genau darum ging es in Daves Keynote: Leute überzeugen, dass Continuous Delivery der richtige Weg ist. Wer Material sucht, um in der eigenen Organisation zu evangelisieren, der sollte sich das Video der Präsentation einfach selber Mal ansehen. Es ist motivierend.

Im Mittelpunkt sieht Dave die *Cycle Time*: Das ist die Zeit, welche die kleinstmögliche Änderung benötigt, bis sie vom Anwender produktiv genutzt wird. Die *Cycle Time* ist so wichtig, weil sie die Geschwindigkeit des Lernens bestimmt. Die These von Dave: Ohne Continuous Delivery und Agile/Lean wird man eine brauchbare *Cycle Time* nicht erreichen können.

> If you start optimizing cycle time now, you will start inventing all of agile and continuous delivery.

Sehr prägnant das Statement zum manuellen Testen:

> Human Beings doing regression testing is waste!
>
> Use Human Being for exploratory testing.

<!--

Bild über Example Continuous Delivery Process ist nützlich.

Have you used Amazon recently? Which version did you use? Amazon releases every 11.6 Seconds.

Wieviel unserer Zeit verbringen wir eigentlich mit % Innovation?

-->


### Das Docker-Ökosystem

(Peter Rossbach)

Guter [Überblick](http://continuouslifecycle.de/2015/material/Rossbach/Rossbach_DockerOrchestration.pdf) über das Tooling, das Docker heute bereitstellt.


### Die Transformation Richtung DevOps von Microsofts Developer Division

(Christian Binder)

Als wir Git entdeckten, hätten wir nicht erwartet, dass ein paar Jahre später Konferenzvorträge von Microsoft gehalten werden, in denen Git ungefähr ein dutzend Mal auf den Slides auftaucht. Das war heute so :-)

Microsofts Entwicklung kommt aus dem klassischen Enginnering, das für seltene Releases optimiert ist (DVD's brennen). Inspirationsquelle für neue Wege war das Google Engineering System. Heute entwickeln 35-Feature-Teams Visual-Studio in einem viel agileren Prozess.

#### Autonomie vs. Alignment

Die Teams arbeiten in hoher Autonomie. Einige Dinge werden aber als Randbedingungen fest vorgegeben (Alignment), z. B.

 * Ein hoher Qualitätslevel ist wichtig. Active Defects werden kontinuierlich und je Team kontrolliert. Trotz Autonomie der Teams führt daran kein Weg vorbei.

 * 3-Wöchige Sprints. Teams dürfen feingranularer arbeiten. Aber die Integrationspunkte sind für alle gleich.

Die Trennung zwischen QA and Dev wurde aufgehoben. Testen ist in der Verantwortung der Teams. Es keine dedizierten Testing Engineers mehr sondern nur noch die Rolle Software Engineer.

Nicht bewährt hat sich das Konzept von regelmäßigen Stabilisierungssprints. Der Speaker sprach sogar von einm "Epic Fail". Es lädt leider ein, Defekte bis zum Stabilisierungssprint zu parken.

Ein anderes Anti-Pattern ist es Burndown-Charts durch Manager überwachen zu lassen. Einziges Ergebnis: Geschönte Burndowns.

Teams sind grundsätzlich *Cross Discipline* und werden lange intakt gehalten. Es gibt geschlossene Team-Rooms mit Rückzugsräumen um die Team-Rooms.

Planning in erfolgt 3 Zeithorizonten (Sprint 3-Week, Season 5 Monate, Vision 18 Monate). Das Season-Planning rolliert. Wird alle 6 Monate neu gemacht.

Das Deployment erfolgt nach dem Sprint, parallel zum Beginn des nächsten Sprints.

Viele Teams nutzen Kanban-Boards.

Es wird mit Git versioniert. Es gibt viel Traffic auf dem Repo. Pull-Requests sind mit einem Quality Gate verbunden. Code-Review sind obligatorisch für alle.

Feature-Toggles werden großflächig eingesetzt.

Nutzen (überall) aufgehängte Monitore um die Pipeline sichtbar zu machen.

Impact:

> Dein Code wird nach 3 Wochen von Hunderttausenden von Nutzern verwendet.

### Konfiguration zur Laufzeit

(Alexander Schwartz, [@ahus1](https://twitter.com/ahus1de))

Arbeiten ohne Wartungsfenster.

 * Archaius - Umgang mit Konfigurationdateien
   - Kaskadierende Konfigurationdateien
   - Typsicherer Zugriff
   - Callbacks bei Wertänderungen (der entscheidende Punkt)

 * etcd - Konfigurationsdatenbank
   - Einfach, zuverlässig, sicher und schnell.

 * Togglz - Tooling für Feauture-Toggles
   - Web API zur Steuerung
   - Prozentuales Rollout
   - Feauture-Toggles bedeuten Aufwand, lohnen sich aber oft.

### Operation am offenen Herzen

(Dirk Ehms [@d_ehms](https://twitter.com/d_ehms))

Ziel war eine große Migration ohne Downtimes, wegen neuet Version des Application Servers Glassfish. Wichtig dabei: Kontinuierlich die Abwärtskompatipibilität der Codeänderungen überprüfen. Es werden dazu Maven-Profile genutzt, um unterschiedliche Builds zu ermöglichen. Schön dargestellt: Blue/Green-Rollouts.


### Building Microservices in the Cloud at Autoscout24

(Christian Deger [@cdeger](https://twitter.com/cdeger), Wolf Schlegel [@wolfwolf](https://twitter.com/wolfwolf))

Wirklich große Miration von Monolith zu Microservices, .net/Window zu JVM/Linux
, Dev+Ops zu DevOps.

Scala Sprache der Wahl.

Arbeiten in Scheiben (vertikale Schnitte inkl. UI).

Services und Teams sind um Business-Capabilities herum organisiert. Nicht nach Layers.

> You invent it. You build it. You run it.

T-Shaped Skill für Entwickler ist gefordert. Ein Team muss alle Rollen abdecken.

Mantra: Shared Nothing. Teams haben hohe Eigenständigkeit. Sharing schafft Abhängigkeiten. Achtung: Bevor man Sharing in Betracht zieht, versucht man erstmal Copy&Paste. Weil Microservices klein sind, ist das nicht so schlimm. Erst wenn etwas wirklich dafür reif ist, wird es als "internal Open-Source" geteilt.

> Wir entscheiden schnell und lokal.
> Wir haben kein Kommittee mehr, das lange nachdenkt.

Hilfreich: Shadow-Traffic und Feature-Toggles.

Nicht DevOps: Wenn Infrastruktur-Anforderungen doch immer von denselben Leuten im Team erledigt werden und liegen bleiben, wenn die im Urlaub sind. Abhilfe: Aufgaben bewußt rollierend vergeben.

Kein Infrastruktur-Team. Übergreifende Themen werden durch Gilden abgebildet mit. Diees erledigen die Aufgaben aber nicht, sondern erstellen Tasks für die Teams. Die Teams dürfen 20% ihrer Zeit für solche Tasks nutzen.

<!--

Noch ein guter Vortrag: "Building Microservices in the Cloud at Autoscout24" #ConLi2015. Meine Notizen dazu: http://kapitel26.github.io/git/2015/11/09/continuous-lifecycle-2015/

-->
