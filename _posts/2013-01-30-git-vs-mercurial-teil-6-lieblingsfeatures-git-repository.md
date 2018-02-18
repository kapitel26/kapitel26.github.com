---
layout: post
title: "Git vs. Mercurial - Lieblingsfeatures: Das Git Repository selbst (Teil 6)"
category: Git
tags: [Git, Mercurial, Repository, Garbage Collection]
# just to fix a highlightin problem]()
author: bst
---

{% include_relative git-vs-hg.md %}

Dieser Post hat etwas länger gebraucht und das lag nicht nur an der Weihnachtszeit. Lange konnte ich mich nicht entscheiden, über welches Feature ich schreiben möchte. Bei jedem einzelnen Feature dachte ich: "Ja, ist ganz nett. Aber nicht der Grund, warum Git so faszinierend ist.".

Ich beschäftige mich viel mit Softwarearchitektur. Kent Beck hat mal eine Definition dazu gegeben: ["Software architecture is what software architects do ..."][Beck on Software Architecture]. Klingt albern. Ist es aber nicht. Der beste Weg Softwarearchitektur zu lernen ist zu beobachten, was erfolgreiche Softwarearchitekten tun. Im Fall von Git ist das kein Geringerer als Linus Torvalds, dem es gelungen ist, die Welt der Versionsverwaltung komplett umzukrempeln. Und das mit einer bemerkenswert einfachen Architektur.

Deshalb beschäftige ich heute mal mit den Entwurfsentscheidungen, die Git zu dem gemacht haben, was es ist.

Klassische Versionsverwaltungen
-------------------------------

Klassische Versionsverwaltungen wie CVS und Subversion (auch Mercurial) speichern ihre Daten Datei für Datei. Weil sich Dateien ändern können, darf eine Datei mehrere Versionen haben.
Um Speicher zu sparen, werden immer nur die Differenzen zur jeweils vorigen Version derselben Datei gespeichert. Projekte sind dort einfach Ansammlungen von versionierten Dateien.

Git ist anders.

The Stupid Content Tracker
==========================

Das Git Repository ist nicht nach Dateien strukturiert.
Das Herz von Git ist ein Key-Value-Store, gennant *Object Database*.

*... und alle NoSQLer so: "Yeah, ein Key-Value-Store!"*

Der *Value* darf beliebiger Content sein:
Ein Text, ein Bild, egal was.
Für Git ist es immer nur eine Folge von Bytes,
genannt *Object*. Der *Key* ist immmer der
*SHA1-Hash-Wert des Contents*.

*... und alle die mitdenken so: "WTF, Git is broken!"*

Jaja, das stimmt schon. Wenn zwei verschiedene Objekte den selben Hash-Wert haben, liefert Git falschen Content aus. Andererseits ist das Risiko von ca. 0,0000000000000000000000000000003% für eine Kollision (bei einen Repository mit 100 Millionen Objekten) nicht so hoch. Und die Sache hat auch ein paar Vorteile:

 * Hashes lassen sich dezentral berechnen

 * Beim Synchronisieren ist leicht festzustellen,
   ob ein Objekt vom entfernten Repository geholt werden muss,
   oder ob lokal schon ein Identisches vorhanden ist.

 * Die Hashes sind gleichzeitig Prüfsummen,
   um Übertragungs- oder Festplattenfehler zu erkennen.

Wenn sich Content ändert, bekommt er einen neuen Hashwert, d. h. er wird von Git als neues Objekt unter dem neuen Hashwert abgelegt.
Objekte in der *Object Database* sind also unveränderbar (*immutable*) und das ist gut so, denn es macht Git robust. Auch wenn Git während einer Operation abstürzt (was ich persönlich noch nicht erlebt habe) oder abgebrochen wird, ist es extrem unwahrscheinlich, dass vorherige Commits beschädigt werden.

*... und die functional Programmers: "Immutable! Da ha'm wir endlich auch mal was zum Jubeln!"*

Die *Datenbank* unterstützt im Wesentlichen nur
drei Operationen:

 1. Ein *Object* einfügen
 2. Ein *Object* holen, dessen Hash-Wert man kennt
 3. [Garbage Collection](/git/2012/05/28/wer-hat-angst-vor-dem-garbage-collector)

*... und alle Anderen so: "Yeah, that's stupid! And everybody: STUPID!"*

Git hat kennt zwei Ebenen von Kommandos: *Porcelaine* und *Plumbing*. *Porcelaine* sind jene Kommandos wie "Commit", "Merge" oder "Rebase", die man Alltag nutzt. Darunter liegt aber eine Schicht primitiver Kommandos, die es ermöglichen, die grundlegenden Strukturen (*Object Database*, *Index* und *Workspace*) so zu nutzen, wie es die *Porcelaine* Kommandos selber auch tun.

Interessant ist, dass auf der untersten Ebene nicht mehr von *Dateien*, *Verzeichnissen* oder von *Commits* die Rede ist. Diese Dinge werden natürlich in der *Object Database* gespeichert, aber es können dort eben auch beliebige andere Dinge abgelegt werden.

Das macht Git so flexibel und ermöglicht es Tools wie zum Beispiel Gollum (ein Wiki) oder Bup (eine Backup-Lösung) zu bauen, die ganz andere Dinge tun als klassische Versionsverwaltungen.

*... und die Bastler und Tüftler so: "Yeah plumbing!"*

Das schöne an so der einfachen Fassade der *Object Databse* ist, dass man unterschiedliche Implementierungen dahinter setzen kann. Und das tut Git auch.

Frische Objekte, die bei einem Commit entstehen, werden direkt als Dateien geschrieben. Der Hashwert des Inhalts bestimmt den Verzeichnis- und Dateinamen.

  f2/8f7d6cbe1cf69c7bf018c9d27ebb65b69c701b

In modernen Dateisystemen ist der direkte Zugriff auf Dateien über deren Namen schnell. Unveränderbare Dateien lassen such außerdem prima cachen. Und Git muss dafür selber gar nichts tun. Der File System Cache erledigt das für uns.

*... und die Performance-Leute so: "Yeah, blazing fast! Until the disc is full ..."*

Der Nachteil: Auch wenn sich nur ein einziges Bytes einer Datei ändert, hat der Content einen anderen Hashwert und muss als neues Objekte in der *Object Database* gespeichert werden. Das Repository bläht sich auf.

Git löst dies, durch eine zweite Form der Speicherung in der *Object Database*. Gelegentlich packt Git sogenannte *Pack Files* aus vielen Objekten. Bei ähnlichen Objekten wird dann nur einmal das ganze Objekt abgelegt, die anderen werden durch Differenzen dargestellt.
Der Vorteil: Da nachträglich komprimiert, kann es dafür das gesamte Repository nach Ähnlichkeien durchforsten und ist dabei nicht auf die Historie einer einzelnen Datei beschränkt. Beispiel: Auch eine per Copy & Pase angelegte und dann veränderte Datei kann per Differenz abgebildet werden. Gerade bei großen Projekten erreicht Git so eine sehr gute Kompression. Auch bei langer Historie bleibt das Repository nicht selten kleiner als der entpackte Workspace.

*... und die Sparbrötchen so: "Yeah, das spart Speicher!"*

Ein Hinweis am Rande: Dies ist auch einer der Gründe, weshalb Git nicht für die Verwaltung von sehr großen Dateien geeignet ist. Versioniert man beispielsweise ein gigabyte-großes Mailbox-File, dann wird bei jedem Commit erstmal die ganze Datei weggeschrieben, auch wenn nur wenige Mails hinzugekommen sind.

*... und die Ungeduldigen so: "Und wie speichert Git denn eigentlich Commits?"*

Ach so ja, hätt' ich fast vergessen vor lauter Begeisterung:

 * Für jedes Datei wird der Hash des Inhalts berechnet.
   Falls noch nicht vorhanden, wird der Inhalt in der *Object Database* gespeichert

 * Für jedes Verzeichnis wird Textschnipsel in der *Object Database*
   abgelegt, der die Dateinamen und die Hashes der jeweiligen
   Inhalte dazu enthält.

 * Commits und Tags werden ebenfalls durch einfache Textschnipsel
   beschrieben.

Ein Verzeichnis sieht dann zum Beispiel so aus:

	100644 blob 2391b6784939b955b898258f84c27828c8d04f0a  default.html
	100644 blob 7985e03e3612197ed008d29c9210546042404927  page.html  
	100644 blob 66490a9d72cbd12ec0b830a5a04845610c0a6063  post.html  

*... und alle XML-geplagten so: "Einfacher Plain-Text, Yeah!"*

tl;dr
=====

Das Herzstück von Git ist ein bemerkenswert einfacher Datei-basierter Key-Value-Store. Genau das macht Git robust, schnell und flexibel.

Disclaimer
----------

Das Repository von Git ist einfach. Git insgesamt ist es *nicht*. Auf der Porcelaine-Ebene bietet es auch einiges an Komplexität. Für ein Beispiel lesen Sie doch einfach mal die 752 Zeilen der Man-Page über den Befehl `git rebase`.

<!-- Links -->

[Beck on Software Architecture]: http://my.safaribooksonline.com/book/-/9781466603363/chapter-13-the-philosophy-of-software-architecture/151
