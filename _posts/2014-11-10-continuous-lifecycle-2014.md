---
layout: post
title: "Continuous Lifecycle Konferenz 2014 - Montag"
category: Git
tags:
 - Git
 - ConLi2014
 - Docker
 - Gradle
 - Code-Reviews
 - Contiuous
 - Packer
 - DevOps
 - Branches
author: bst
---

Montag
======

Jetzt bin ich doch da, auf der Continuous Lifecycle Konferenz in Mannheim.
Danach sah es zunächst nicht aus. Erst am späten Freitagnachmittag ereilte mich die Nachricht, dass die GDL ihren Streik schon am Samstag beenden würde. Ich konnte am Sonntag anreisen.

Hier ein paar Notizen zu den Vorträgen, die ich gehört habe.

[The Culture of Continuous Flow<br/>(Jez Humble)](http://continuouslifecycle.de/lecture.php?id=4582)
===========================================

Erstmal vorweg: Mit dem amerikanischen Vortragsstil hab' ich mitunter so meine Probleme. Gerade lese ich ein amerikanisches Fitnessbuch. Bevor man die erste Kniebeuge machen darf, muss man sich anhören wie toll Fitness ist, Chakka!, um wieviel Prozent man gleichzeitig das Gewicht reduzieren und die Kraft steigern kann, und warum alle anderen Ansätze zur Fitnessertüchtigung erbärmliche Krücken sind. Dieser Keynote beginnt sehr amerikanisch. Missionarisch mit Pauken und Trompeten angekündigt wird der Claim angekündigt: IT-Performance ist messbar. IT-Performance korreliert messbar mit Unternehmenserfolg. DevOpsige Kultur steigert IT-Performance. Ich bin ja Meßbarkeitsskeptiker, wenn großzügig Prozentzahlen in den Raum geworfen werden, um Behauptungen zu untermauern. Mir geht es mit solchen Zahlen oft so wie mit Wurst: Wenn man ahnt, wie sie enstanden sind, schmecken sie nicht mehr.

Das Gute: Nachdem der Hurra-Teil abgearbeitet ist, folgen etliche Anekdoten und Beobachtungen, die auch für mich interessant sind.

### Continuous Delivery

Am Beispiel des HP Laserjet Firmware Team. Ausgangspunkt war eine extrem zähe Entwicklung mit separaten Branches für jedes Device (Bad Idea). Vor lauter Integrations-, Test- und Spezifikationsaufwänden blieb kaum Zeit für Anderes. Durch Umstellung auf eine gemeinsame Codebasis auf einem Branch mit Continuous Delivery mit stark automatisierten Tests konnte wieder Spielraum für Innovation geschaffen werden.

Schönes Zitat:

> You're only one day away from trunk.


### Lean

> Lean is about investing to remove waste.

> ... 2/3 of the ideas turned out to have no or negative impact.
> We could go skiing 2/3 of our time and deliver the same value to our customers.

Doch leider:

> ... you don't know which ...

Der Fehler: Klassisches Produktmanagement geht davon aus, es würde Anforderungen kennen. In Wahrheit macht es nur Hypothesen.

> We dont have requirements we have hypotheses.


### Agile, Scrum

Spannend: *Kultur* ist als Buzzword bei Entwicklern und Admins ankommen. Eine Personengruppe, die damit bisher eher wenig Berührungsängste hatten.

Kultur läßt sich leider nicht transplantieren. Was dem einen Unternehmen hilft, muss bei einem Anderen nicht funktionieren. Grund: Unternehmen sind komplexe dynamische Systeme. Forciertes aufdrängen einer fremden Kultur klappt oft nicht:

> Sometimes adapting Scrum means you take your orders standing instead of sitting.

### Diversity

Über das Auditorium

> All are Dudes

Es gibt keine wirklichen Grund, weshalb Frauen keine DevOps sein können. Trotzdem gibt es (fast) keine. Und von den wenigen, wechseln viele in andere Tätigkeitn. Jez forderte jeden auf, etwas tun, um das Klima in der IT für Frauen zu verbessern.



[Packer, Vagrant, Puppet<br/>(Alexander Pacnik)](http://continuouslifecycle.de/lecture.php?id=4525)
==========================================

Vortrag über Packer, ein Tool um virtuelle Maschinen für verschiedene Plattformen zu generieren. Eher ein technischer How-To-Vortrag. Daher keine Notizen von mir.

[Verzweigungen beherrschen<br/>(Ralf Gronkowski)](http://continuouslifecycle.de/lecture.php?id=4561)
===========================================

#### Wer hat Angst vor dem bösen Branch?

Ralf Gronkowski nimmt die Angst und argumentiert, dass man mit einem guten Übersichtsplan, festen Regeln und etwas gesundem Menschenverstand Branches nutzbringend einsetzen kann.

Hilfreich ist es die Branches nach Stabilität zu sortieren. Er nannte es die Tofu-Skala: Die harten (stabilen) Branches oben und die weichen (experimentierfreudigeren) Branches unten. Es empfiehlt sich dann

 * frei und häufig oben nach unten Mergen,
 * aber nur gezielt und kontrolliert per Copy (in Git: Fast-Forward) von unten nach oben zu übertragen .

Zitat:

> Geheimwaffe als Lösung für fast alles: Mach' Dir doch 'nen Branch.

Das geht mir persönlich dann doch zu weit. Ein wichtiger Einwand hierzu kam aus dem Publikum: Starkes Refactoring verträgt sich schlecht mit langlebigen Branches. Das kann ich bestätigen. Wer größere Mengen Code im Sinne von Fowlerschen Refactoring überarbeiten möchte, der muss dafür sorgen, dass solche Änderunge zeitnah auf allen aktiven Branches integriert werden. Sonst droht eine Merge-Konflikt-Hölle. Da hilft es auch nichts, dass moderne Merge-Tools mit Datei-Umbenennungen umgehen können, denn nach Änderunge wie Verschiebungen, Inlinings, Methodenextrahierungen u. Ä. bleibt das Mergen schwierig.


[DevOps - The dawn of hierarchies<br/>(Matthias Kainer)](http://continuouslifecycle.de/lecture.php?id=4533)
==================================================

Motiverender Erfahtungsbericht über eine DevOps-Einführung.

<!--
Unfertige Featuers herausbringen. Das haben wir gemacht. Echte Experimente. Beispiel: Buttons statt klassischer Landing-Page.

MobileWebApp Relaunch. Trick: Nur die Features im Relaunch, die wirklich genutzt werden.

Organisatorisches Problem: Gilden für DevOps, DevPM, DevPX, NewMobile. -> Immer dynamischer Organisation. Kein Organigramm mehr.

Ownership? Wer kümmert um die Bugs?

Architektur? Soll willst Du nicht, dass die Architektur aussieht. (Wenn sie isch der dynamisch umstrukturierenden Organisation angleicht)

Kommunikation? Wer ist Ansprechpartner

Ziele? Wo kommen die her?

Persönliche Entwicklung? Wo ist meine Jobbeschreibung

### Warum trotzdem weitermachen?

http://continuouslifecycle.de/lecture.php?id=4583

Wegen der Werte. Agile Manifesto ernst nehmen. Alles was man tut daraufhin hinterfragen.

Buchtipp "Feel is Change". Patterns für Akzeptanz.

Buchtipp "Tribal Leadership"

Ansatz: Stories aus dem Backlog. Pull: Wer will da mitmachen. Wenn sich keiner findet, war es wohl doch nicht so wichtig.

> So'n Rechenzentrum selber aufzubauen ist super ... <br/>
> ... wenn man viel lernen möchte.

Entscheidung: Alles neu bauen. DevOps-Style. Microservices. Deployment von Anfang an integraler Bestandteil.

Interessante Punkt. **Ownership**. Alle. Wenn Du etwas findest, ist es Deine Verantwortung, es zu beheben, oder dafür zu sorgen, dass es behoben wird.

Ergebnis: Flexibilität, Geschwindigkeit, Wir-Gefühl, Spaß.

Pattern: Just do it.


[Multi-Projekt-Builds mit Gradle<br/>(Stoyan Stoyanov, @s_stoyanov)](http://continuouslifecycle.de/lecture.php?id=4583)
==============================================================


Build-Prozess wächst und wird kryptisch. Problem, wenn nur ein Build-Engineer dafür zuständig ist.

Frustriert von komischen Plugins und XML.

Migration mit automatischem Vergleich der gebauten *ar's.

Verwenden Grunt (JavaScript-Tool) für andere Tasks, die vorher mit Ant-Targets gebaut wurden.

Notiz: Es gibt ein "buildSrc" Verzeichnis für Code, der im Build benötigt wird.

Man kann mit wenig Code viel erreichen. Viel übersichtlicher.



[Code-Reviews<br/>(Frank Sons)](http://continuouslifecycle.de/lecture.php?id=4554)
=========================



Notiz: Jeff Atwood: Talk "How to stop sucking and start being really awsome"

Pair-Programming. Driver/Navigator. Wenig Neues.

### Reviews im Team

> Kannst Du mir meinen Code erklären?

Echt spannend. Klappt erstaunlich gut. An unerwarteten Stellen aber gar nicht.

Freitag für 2 Stunden in Big Round. Zentrales im Sprint. 300-400 Zeilen Code.

Die große Runde hilft dem Team einen Standard festzulegen. Ein Reviewing-Tool hilft dann später Strecke zurückzulegen.

Tut richtig weh. Ist aber trotzdem gut? (Meine Anmerkung: Muss das sein?)

Man lernt in der Gruppendiskussion, wann Kommentare Sinn machen.

[CD mit Gradle und Docker<br/>(Tobias Gesellchen)](http://continuouslifecycle.de/lecture.php?id=4541)
============================================

### Docker



Die Technik dahinter ist schon 20 Jahre alt. Die Leichtigkeit machts. Leichter testen, schneller Testen. Wie in PROD.

Docker ist "Die Applikation" aus Operations sicht.

 * Operations um den Docker-Container herum
 * Devs im Docker-Container

Deployen durchaus auch Container, die mehrere Server enthalten.

### Gradle, warum?

> Das schönste daran ist Groovy

Nützliche Plugins.

### Sonstiges

Externe Services künftig nicht mehr als WARs deployen sondern separat. Über URL aufrufbaur.

Noch offen, wie sich die Orchestrierung im Docker-Umfeld.

Zu lernen: Monitoring, Security

[Culture: the invisible ingredient<br/>(Pavlo Baron)](http://continuouslifecycle.de/panel.php?id=4615)
====================



> "DevOps-Team": Creating a silo team to solve a silo problem seems somewhat ironic.<br/>(Jez Humble)


-->
