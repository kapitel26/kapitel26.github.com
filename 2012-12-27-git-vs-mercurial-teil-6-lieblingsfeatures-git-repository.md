---
layout: post
title: "Git vs. Mercurial - Lieblingsfeatures: Git Repository (Teil 6)"
category: Git
tags: [Git, Mercurial, Repository, Garbage Collection]
# just to fix a highlightin problem]()
author: bst
---
{% include JB/setup %}

{% include git-vs-hg.md %}

Dieser Post hat etwas länger gebraucht und das lag nicht nur an der Weihnachtszeit. 

Lange habe ich gegrübelt, über welches Feature von Git ich schreiben möchte. Es gibt ja so viele. Erst nach einer Weile wurde mir klar, dass das Besondere an Git gar nicht die einzelnen Features sind, sondern die genial einfache Architektur des Repositorys, die wiederum unzählige coole Features ermöglicht.

Klassische Versionsverwaltungen wie CVS und Subversion (auch Mercurial) speichern ihre Daten Datei für Datei. Weil sich Dateien ändern können, darf eine Datei mehrere Versionen haben. 
Um Speicher zu sparen, werden immer nur die Differenzen zur jeweils vorigen Version derselben Datei gespeichert. Ein Projekt ist in diesen Systemeen Menge versionierter Dateien.

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

*... und alle, die mitdenken so: "WTF, Git is broken!"*

Jaja, das stimmt schon. Wenn zwei verschiedene Objekte den selben Hash-Wert haben, liefert Git falschen Content aus. Andererseits ist ein Risiko von ca. 0,0000000000000000000000000000003% für eine Kollision (bei einen Repository mit 100 Millionen Objekten) wirkt nicht gerade furchterregend. Und die Sache hat auch ein paar Vorteile:

 * Hashes lassen sich dezentral berechnen

 * Beim Synchronisieren ist leicht festzustellen, 
   ob ein Objekt vom entfernten Repository geholt werden muss
   oder ob lokal schon ein identisches vorhanden ist.

 * Die Hashes sind gleichzeitig Prüfsummen,
   um Übertragungs- oder Festplattenfehler zu erkennen.

Objekte in der *Object Database* sind unveränderbar (*immutable*) und das ist gut so, denn es macht Git robust. Ein neues Commit erzeugt neue Objekte in der *Object Database*, bereits vorhandene Objekte bleiben unverändert. Auch wenn Git während einer Operation abstürzt (was ich persönlich noch nicht erlebt habe) oder abgebrochen wird, ist es sehr unwahrscheinlich, dass vorherige Commits beschädigt werden.

*... und die functional Programmers: "Immutable! Da ha'm wir endlich auch mal was zum Jubeln!"*

Die *Datenbank* unterstützt im Wesentlichen nur
drei Operationen:

 1. Ein *Object* einfügen
 2. Ein *Object* holen, dessen Hash-Wert man kennt
 3. [Garbage Collection](/Git/2012/05/28/wer-hat-angst-vor-dem-garbage-collector/))

*... und alle Anderen so: "Yeah, that's stupid! And everybody: STUPID!"*

Interessant ist, dass auf dieser Ebene weder von *Dateien* oder *Verzeichnissen* noch von *Commits* die Rede ist. Diese Dinge werden natürlich in der *Object Database* gespeichert, aber es können dort eben auch beliebige andere Dinge abgelegt werden. Das macht Git so flexibel und ermöglicht es Tools wie Gollum (ein Wiki) oder Bup (eine Backup-Lösung) zu bauen, die andere Dinge tun als eine klassische Versionsverwaltung.

*... und Bastler so: "Yeah, damit könnte man ja auch ein ... bauen!"*

Das schöne an so einer einfachen Fassade ist, dass man unterschiedliche Implementierungen dahinter setzen kann. Und das tut Git auch. 

Frische Objekte, z. B. nach einem Commit, werden einfach als Dateien geschrieben. Der Hashwert des Inhalts bestimmt den Verzeichnis- und Dateinamen.

  f2/8f7d6cbe1cf69c7bf018c9d27ebb65b69c701b

In modernen Dateisystemen ist der direkte Zugriff auf Dateien über derenn Namen schnell. Unveränderbare Dateien lassen such außerdem prima cachen. Und Git muss dafür selber gar nichts tun. Der File System Cache erledigt das für uns.

*... und die Performance-Leute so: "Yeah, blazing fast! Until the disc is full ..."*

Der Nachteil: Auch wenn sich nur ein einziges Bytes einer Datei ändert, hat der Content einen anderen Hashwert und muss als neues Objekte in der *Object Database* gespeichert werden. Das Repository bläht sich auf. 

Git löst dies, durch eine zweite Form der Speicherung in der *Object Database*. Gelegentlich packt Git sogenannte *Pack Files* aus vielen Objekten. Bei ähnlichen Objekten wird dann nur einmal das ganze Objekt abgelegt, die anderen werden durch Differenzen dargestellt.
Der Vorteil: Da in Git die Kompression nachgelagert wird, kann es das gesamte Repository nach Ähnlichkeien durchforsten und ist dabei nicht auf die Historie einer einzelnen Datei beschränkt. Beispiel: Auch eine per Copy & Pase angelegte und dann veränderte Datei kann per Differenz abgebildet werden. Gerade bei großen Projekten erreicht Git so eine sehr gute Kompression. Auch bei langer Historie bleibt das Repository nicht selten kleiner als der entpackte Workspace.

*... und die Sparbrötchen so: "Yeah, das spart Speicher!"*

*... und die Ungeduldigen so: "Und wie speichert Git nun Commits?"*

Ach so ja, hätt' ich fast vergessen vor lauter Begeisterung über die *Object Database*. 

 * Für jedes Datei wird der Hash des Inhalts berechnet. 
   Falls noch nicht vorhanden, wird der Inhalt in der *Object Database* gespeichert

 * Für jedes Verzeichnis wird Textschnipsel in der *Object Database* 
   abgelegt, der die Dateinamen und die Hashes der jeweiligen 
   Inhalte dazu enthält, z. B. so

   ```
100644 blob 2391b6784939b955b898258f84c27828c8d04f0a default.html

100644 blob 7985e03e3612197ed008d29c9210546042404927  page.html
 
100644 blob 66490a9d72cbd12ec0b830a5a04845610c0a6063  post.html  
   ```

 * Commits und Tags werden ebenfalls durch einfache Textschnipsel 
   beschrieben.

*... und alle XML-geplagten so: "Einfacher Plain-Text, Yeah!"*

