---
layout: post
title: "Logbucheintrag: Continuous Lifecycle '13 in Karlsruhe"
category: Git
tags: [Continuous Delivery, Git, Mercurial, Konferenz]
author: bst
---

[zu den Slides für unsere Vorträge](/git/2013/11/14/continuous-lifecycle-konferenz-vortraege/)

Continuous-Delivery machen wir bei [etracker](http://www.etracker.de), wo ich arbeite, schon eine ganze Weile. Deshalb war ich mir nicht sicher, ob ich eine [Konferenz](http://www.continuouslifecycle.de/) besuchen soll, wo 72% aller Vorträge (gefühlter Wert) erklären, wie man Continuous-Delivery einführt. Die Entscheidung fiel, als [René](/rene/) und ich die Gelegenheit bekamen zwei Git-Vorträge dort zu halten. Gut so. Sonst hätte ich eine interessante Veranstaltung verpasst.

In der Keynote (*Mirko Novakovic* "Lean Startups Eat the World!") ging es um *disruptiven Wandel*. Viele Beispiele wurden gezeigt, wie ganze Märkte umgekrempelt werden (Amazon Buchhandel, AWS, mytaxi, airbnb, ...). Fast immer kamen die Innovationen von Branchenfremden. Ausschlaggebend ist oft die User-Experience nicht so sehr der Preis (wir kaufen bei Amazon wegen des perfekten Services, nicht wegen des Preises). Viele Branchen werden sich auf Disruptionen einstellen müssen. Continuous Delivery ist ein Hilfsmittel, um mehr Beweglichkeit für Innovation zu schaffen. Preisfrage: Wann wird es in Deutschland echte Online-Versicherungen geben?


Pflichtprogramm für mich war natürlich "Software-Architektur für DevOps und Continuous Delivery". Es ist offensichtlich, fast schon Binsenweisheit, das man sich das DevOps-Leben mit einer stimmigen Architektur erheblich leichter macht. *Eberhard Wolff* hat verschiedene Ansätze gezeigt, wo Architektur DevOps unterstützen kann. Erstmal wurde betont wie wichtig die Automatisierung der *Pipeline* ist, die auf dem Weg zur Produktion durchlaufen wird. Gefällt mir natürlich, weil man das so schön durch *Pushes* von einem Git-Repository zum nächsten abbilden kann. Die nächste Empfehlung war dann, große Projekte in Komponenten zu zerlegen, die über eigene Pipelines separat deploybar sind. Dann werden die Zyklen schneller und die Deployments übersichtlicher. Das erfordert allerdings eine starke Entkopplung über Services. Wenn das nicht gerade aus der Mode geraten wäre, würde man es wohl SOA nennen. Ich persönlich glaube, dass starke Entkopplung einen hohen Preis hat und sich nicht immer rechnet. Ich habe viel zu viele hypergenerisch verquaste Modul-, Komponenten, Plugin- und Service-Architekturen scheitern und zu viele häßliche aber Monolithen Erfolge feiern gesehen, um Modularisierung als Allheilmittel zu empfehlen. Hat schon mal wer von diesem Linux gehört? Wie viele Enterprise-Class Anwendungen werden eigentlich schon au GNU/Hurd betrieben? Bevor sich jemand in eine große Modularisierungsorgie abtaucht, rate ich daher, wie einst der große Vorsitzende: "Dreimal nachdenken". Sehr viel besser gefiel mir der nächste Punkt. Postel's Law: "Be conservative in what you send, be liberal in what you accept.". Beherzigt man dies, wird das Gesamtsystem robuster, weil kleine Unstimmigkeiten und Abweichungen dann seltener Störungen verursachen. Ein weiteres wichtiges Konzept ist *Graceful Degradation*. Dahiner steckt die Idee, das System so zu bauen, dass es nicht einfach anhält, wenn ein einzelner Service gestört ist. Statt dessen bietet man den Service mit eingeschränkter Leistung an (z. B. Bestellungen bis 100 € ohne Bonitätsprüfung). Gute Sache das. Ebenfalls empfehlenswert *Circuit Breakers* (nach Michael Nygard), die dafür sorgen, dass ein System abschaltet (oder drosselt), bevor es andere Teilssysteme im Mitleidenschaft zieht. Naja, und *Feature Toggles* soll man natürlich auch machen. Insgesamt ein sehr hörenswerter Vortrag.

Später gab es dann einen Vortrag von *Simon Olofsson*, der Git, Mercurial und Bazaar verglichen hat. Es wurde sehr schön dargestellt, wie sich Revisionsnummern, das Konzept von Commits und das Branching in den Tools unterscheiden. Auch der Staging-Bereich von Git wurde vorgestellt. Mir hat in diesem Vortrag aber ein wenig das "Warum?" gefehlt: Es gibt also Unterschiede. Aber warum sind die Unterschiede wichtig? Wie bewertet man sie, um das "richtige" Tool auszuwählen?

Und dann kamen unsere beiden Vorträge. Wir hatten ein sehr interessiertes Publikum, es gab gute Fragen und hat viel Spass gemacht. Die Slides dazu werden wir hochladen, sobald wir wieder eine "normale" Internet-Verbindung erreichen.

"Infrastructure as Code" ist ein heißes Eisen. *Mathias Münch* hat einen sehr guten Vortrag darüber gehalten. Kaum ein Programmierer würde heute noch den generierten Binärcode eines Programms nachträglich patchen. Server hingegen werden oft im laufenden Betrieb umkonfiguriert. Etwas beschönigend nennt man das dann "administrieren". Das hat was von Kunsthandwerk, führt aber leider auch dazu, dass jeder Server im Laufe der Zeit zum kostbaren Einzelstück wird. Münch schlägt als Gegenkonzept vor, auf *Immutable Server* zu setzen. Die Idee ist einfach. Anstatt einen bestehenden Server umzukonfigurieren wird ein neuer Server mit der neuen Konfiguration aufgesetzt. Der neue Server durchläuft automatische Tests, bevor er in Betrieb genommen wird. Der Vortrag zeigt, wie man mit Hilfe von Automatisierung und Virtualisierung dahin kommen kann, dass neue (virtuelle) Maschinen mit Jenkins in einigen Minuten gebaut, getestet und in Betrieb genommen werden können.

Das waren Highlights einer guten Konferenz. Zufrieden sitze ich jetzt in der Bahn und fahre den weiten Weg nach Hause.




