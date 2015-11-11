---
layout: post
title: "Continuous Lifecycle Konferenz 2015 - Dienstag"
category: Git
tags: [Branch, ConLi2015]
author: bst
---

Auch dieses Jahr sind wir nach Mannheim gereist, um einen Vortrag über Git zu halten. Und auch dieses Mal haben wir das Konferenzprogramm auch als Teilnehmern mitgenommen. Und auch dieses Mal hat es sich gelohnt. Es waren wieder viele gute und inhaltlich interessante Vorträge dabei.

### Unser Vortrag: Branching-Modelle mit Git

(René und Bjørn)

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

Guter Überblick über das Tooling, das Docker heute bereitstellt.


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

Kein Infrastruktur-Team. Übergreifende Themen werden durch Gilden abgebildet mit. Diese erledigen die Aufgaben aber nicht, sondern erstellen Tasks für die Teams. Die Teams dürfen 20% ihrer Zeit für solche Tasks nutzen.


### Das neue Testparadigma: Behavioral Diff

(Dr. Jeremias Rössler [@roesslerj](https://twitter.com/roesslerj))

Abgrenzung Feature vs. Bug ist gar nicht immer so klar.

> Wenn man keine Spezifikation hat, gibt es keine Fehler, nur Überraschungen.

Beim Sourcecode macht man Reviews auf Diffs, also auf jene Zeilen, die sich ändern. Warum nicht auch für User-Interfaces. Konzept Behavioral Diff: Verhalten bei einem Testlauf protokollieren und dann mit den Ergebnissen für die neue Version vergleichen. Danach bestätigt man, dass die Änderungen so gewollt sind. Wichtig dabei natürlich: Die Läufe müssen deterministisch sein. Ein interessantes Konzept. Persönlich glaube ich aber, dass das nur dann funktioniert, wenn die Diffs so dargestellt werden, dass sie schnell beurteilt werden können. Das ist, gerade für User-Interfaces, keine leichte Aufgabe.

Im zweiten Teil beschäftigt sich der Vortrag mit randomisierten Tests (Monkey Tests). Problem: Um in endlicher Zeit zu guten Ergebnissen zu kommen braucht es "intelligente" Affen, die nicht völlig willürlich klicken. Grundidee: Ein manuell aufgezeichneter Test wird zufällig variiert (Genetischer Algorithmus, z. B. optimiert auf Branch-Coverage). Auf diese Weise bekommt man aus wenigen manuell erstellen Läufen eine breite Abdeckung.

Im dritten Teil werden die Konzepte kombiniert, so dass man Änderungen im Verhalten auf eine breiten Menge von Tests beobachten kann. Klingt für mich spannend, ich bin aber nicht sicher, ob man mit der der entstehenden Menge an Output in der Praxis wirklich gut umgehen kann.

### Fast and Resilient Integration Testing

(Dr. Thomas Schank [@DrTom21](https://twitter.com/DrTom21), Max Albrecht [@EINS78](https://twitter.com/EINS78))

Es geht um das Problem mit zu viele False Negatives. Das sind fehlgeschlagene Tests, die nur auf ein Problem in der Testumgebung zurückzuführen sind, und keine Code-Korrektur erfordern.

Bei Integrationstest gibt es, leider, eine gewisse Wahrscheinlichkeit, dass Tests willkürlich scheitern. Die Wahrscheinlichkeit des Scheiterns der Suite steigt exponentiell mit der Anzahl von Tests. Was hilft: Gezieltes wiederholen gescheiterter Tests.

Klassische CI-Systeme (z. B. Jenkins) können das nicht gut, weil sie zu wenig wissen, über das was sie testen. Krass: Die beiden haben dann eine eingenes CI entwickelt ([Cider-CI](https://github.com/cider-ci/cider-ci)).

> The Source is the Truth.

Konfiguration im Sourcecode als YAML-File.

Tree-id als fingerprint des Sourcecodes. Ermöglich Reproduzierbarkeit und ist Basis für Bisection.

Scripts with Dependencies statt Jobs mit Before- und After-Hooks. Dependenies werden im Web-UI auch grafisch dargestellt.

Fazit: Komplexe Integrationstests sind wegen der False-Negatives immer schwierig. Mit gezielter Wiederholung kann man das in den Griff kriegen. Beeindruckend, was die Beiden in wenigen Monaten neben der eigentlich Projektarbeit auf die Beine gestellt haben.

### Acceptance Testing for Continuous Delivery

(Dave Farley [@davefarley77](https://twitter.com/davefarley77))

> Acceptance Test is kind of an automated version of the definition of done.

Jede Anforderungen aus der Definition of Done soll durch einen Akzeptanztest abgedeckt werden.

Die Akzeptanztests gehören den Entwicklern.

*Language of the Domain*. Nicht jeder muss einen Test programmieren können, aber Fachexperten sollten sie lesen können.

Es ist nicht effizient, die Umgebung für jeden Test einzeln aufzusetzen. Wir wollen viele, sehr viele Akzeptanztests laufen lassen. Das System muss so sein, dass die Anwendung eimal aufgesetzt wird und dann viele Tests dort *parallel* ausführen kann.

Wichtig ist dabei die Isolation der Tests. Wie findet man die richtigen Grenzen und das passende Gleichgewicht zwischen Integration und Entkoplung für einen gebebenen Test? Idee: Functional Isolation.

Auf jeden Fall vermeiden: Abhängigkeiten zwischen Tests. Jeder Test muss einzeln laufen können.

Nützlich zur Isolation:

> Alias your Testing Entities

Jeder Lauf erzeugt seine eigenen Entities, die nicht von anderen Tests oder anderen Läufen desselben Tests genutzt werden, "Buch-testxyz-1234" für Test "xyz" im Lauf "1234".

Ebenfalls hilfreich zur Isolation: Test Doubles. Service die Daten nur für Tests bereit stellen (Ähnlich Mocks in Unit Tests).

Domain Specific Language zur Beschreibung von Tests sind sehr empfehlenswert, um Tests als Mittel der Kommunikation nutzten zu können.

Für viele Systeme ist es wichtig, das zeitlich Verhalten kontrollieren zu können. Eine Time-Travel-Funktion in der Test-DSL wird wichtig. Stichwort: Clock as a Service, ermöglicht Test Doubles dafür.

Oft ist eine Sonderbehandlung für destruktive Tests erforderlich. Andere Tests erforden sehr spezielle Umgebungen. Hierzu nutzt man deklaratives Tagging der Tests.

Production-like Test Environments: Auch hier gilt es wieder ein Gleichgewicht zu finden zwischen produktionsnaher Umgebung, einfachem Setup und schnellen Tests.

Keine Produktionsdaten für Akzeptanztests. Zu schwerfällig.

Sehr schöne Zussamenfassung von Do's und Dont's für Tests.

### Configuration Management mit Clojure

(Michael Jerger)

Thema: Viele CM-Tools versuchen deklarativ zu sein. Keines kommt aber ohne programmatische Möglichkeiten aus. Vielleicht sollte man das Problem direkt programmatisch angehen.

> DevOps kommt niemals ohne Programmierung aus.

<!--
-->
