---
layout: post
title: "Continuous Lifecycle Konferenz 2014 - Montag"
category: Git
tags:
 - Git
 - ConLi2014
author: bst
---

The Culture of Continuous Flow (Jez Humble)
===========================================

Erstmal vorweg: Ich hab' ja so meine Probleme mit dem amerikanischen Stil.
Gerade lese ich ein amerikanisches Fitnessbuch. Bevor man die erste Kniebeuge machen dar, muss man sich anhören wie toll Fitness ist (Chakka!), um wieviel Prozent man sein Gewicht reduzieren und die Kraft steigern kann und man erfährt ausführlich, warum alle vorigen Ansätze zur Fitnessertüchtigung erbärmliche Krücken sind. Dieser Vortrag beginnt sehr amerikanisch. Missionarisch mit Pauken und Trompeten angekündigt wird der Claim angekündigt: IT-Performance is messbar. IT-Performance korreliert messbar mit Unternehmenserfolg. DevOpsige Kultur steigert IT-Performance.

Dann werden eine Menge Prozentzahlen in den Raum geworfen, die belegen sollen wie toll das angekündigte ist. Mir geht es mit solchen Zahlen oft so wie mit Wurst. Wenn man ahnt, wie sie enstanden ist, schmeckt sie nicht mehr.

Das Gute: Nachdem der Hurra-Teil abgearbeitet ist, folgen Anekdoten und Beobachtungen, die auch für mich interessant sind.

### Continuous Delivery

> You're only one day away from trunk.

Gibt Beweglichkeit:

Beispiel hp laserjet firmware team: Device Branches very bad idea. Solution: One Branch and Continuous Delivery.
Automation of testing is important. Quality built in. Stop the line.

No Stabilization Phase. Test every day for every piece of code.

### Lean

> 2/3 of the ideas turned out to have no or negative impact.
> We could go skiing 2/3 of our time and deliver the same value to our customers.

And you don't know which.

Viewpoint: Productmanagemnt difficult. We dont have requirement we have hypotheses.

> Lean is about investing to remove waste.


### Scrum

Spannend dabei: *Kultur* ist als Buzzword bei Entwicklern und Admins ankommen. Eine Personengruppe, die damit bisher eher wenig Berührungsängste hatten.

Scrum (transplanted):

> Sometimes adapting Scrum means you take your orders standing instead of sitting.

No particular practice works in general. Reason: Complex Systems. Practices are Counter Measures for the problems in a particular situation.


### Diversity

All are Dudes. We have the same problem in US.

Packer, Vagrant, Puppet (Alexander Pacnik)
==========================================

Packer: Virtuelle Machinen für unterschiedliche Plattformen aus einer Quelle generieren.

Vagrant: Virtualbox und VMWare Management.

Puppet: Provisionierung


Verzweigungen beherrschen (Ralf Gronkowski)
===========================================

Unterschiedlicher Versinen der Software beim Kunden im Einsatz.

Parallele Entwicklung verschieder "Projekt" in Branches/Codelines

Varianten per Branches. (Ist das gut?)

Angeblich erfordert agile Entwickling Spring-Branches und Task-Branches.

Claim: Es man braucht viele Branches.

Und das ist erstmal komplexer. Erzeugt Angst.

> Geheimwaffe als Lösung für fast alles: Mach' Dir doch 'nen Branch.

### Hilfmittel

 * Pläne -> Baseline vom weicheren zum Stabilern
 * Protokolle -> Übertragung (Merge, Copy) nach Härterichtung
 * Etikette
   - Akzeptiere stabilisierende Änderungen
   - Erzwinge nie destabilisierende Änderungen
   - Merge nur in eine Richtung, so oft wie nötig, an der richtigen Stelle zuerst.

Begriffe: Kopieroperation (Copy) -> Fast Forward merge
Merge down, Copy up.

Interessanter Einwand: Refactorings. Sind erschwert, wenn man länger auf länger lebenden Projekt-Branches arbeitet.



DevOps - The dawn of hierarchies (Matthias Kainer)
==================================================

Unfertige Featuers herausbringen. Das haben wir gemacht. Echte Experimente. Beispiel: Buttons statt klassischer Landing-Page.

MobileWebApp Relaunch. Trick: Nur die Features im Relaunch, die wirklich genutzt werden.

Organisatorisches Problem: Gilden für DevOps, DevPM, DevPX, NewMobile. -> Immer dynamischer Organisation. Kein Organigramm mehr.

Ownership? Wer kümmert um die Bugs?

Architektur? Soll willst Du nicht, dass die Architektur aussieht. (Wenn sie isch der dynamisch umstrukturierenden Organisation angleicht)

Kommunikation? Wer ist Ansprechpartner

Ziele? Wo kommen die her?

Persönliche Entwicklung? Wo ist meine Jobbeschreibung

### Warum trotzdem weitermachen?

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

Multi-Projekt-Builds mit Gradle (Stoyan Stoyanov, @s_stoyanov)
==============================================================

Build-Prozess wächst und wird kryptisch. Problem, wenn nur ein Build-Engineer dafür zuständig ist.

Frustriert von komischen Plugins und XML.

Migration mit automatischem Vergleich der gebauten *ar's.

Verwenden Grunt (JavaScript-Tool) für andere Tasks, die vorher mit Ant-Targets gebaut wurden.

Notiz: Es gibt ein "buildSrc" Verzeichnis für Code, der im Build benötigt wird.

Man kann mit wenig Code viel erreichen. Viel übersichtlicher.



Code-Reviews (Frank Sons)
=========================

Notiz: Jeff Atwood: Talk "How to stop sucking and start being really awsome"

Pair-Programming. Driver/Navigator. Wenig Neues.

### Reviews im Team

> Kannst Du mir meinen Code erklären?

Echt spannend. Klappt erstaunlich gut. An unerwarteten Stellen aber gar nicht.

Freitag für 2 Stunden in Big Round. Zentrales im Sprint. 300-400 Zeilen Code.

Die große Runde hilft dem Team einen Standard festzulegen. Ein Reviewing-Tool hilft dann später Strecke zurückzulegen.

Tut richtig weh. Ist aber trotzdem gut? (Meine Anmerkung: Muss das sein?)
