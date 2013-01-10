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

Wenn man mich fragt, warum ich von Git so fasziniert bin, 
dann rede ich oft nur kurz über Features, und schwärme dann
lange und ausgiebig über das Repository von Git.

Klassiche Versionsverwaltung 
============================

### (Langweiliger Absatz über alte Sachen. Könnse überspringen)

Klassische Versionsverwaltungen (CVS, Subversion, auch Mercurial)
speichern ihre Daten Datei für Datei. Weil sich Dateien ändern 
können, darf eine Datei mehrere Versionen haben. 
Um Speicher zu sparen, werden dafür immer nur die Differenzen zur jeweils vorigen Version gespeichert. 
Ein Projekt ist eine Ansammlung versionierter Dateien.
Eine Version eine Zusammenfassung der Versionsstände der
Dateien des Projekts. 

The Stupid Content Tracker
==========================

Das Git Repository ist nicht nach Dateien strukturiert.
Das Herz von Git ist die *Object Database* 
ein Key-Value-Store für Content.

*... und alle NoSQLer so: "Yeah, ein Key-Value-Store!"*

Der Value darf beliebiger Content sein:
Ein Text, ein Bild, egal was.
Für Git ist es immer nur eine Folge von Bytes,
genannt *Object*. Der Key ist immmer der 
*SHA1-Hash-Wert des Contents*.

*... und alle Pedanten so: "WTF, Git is broken!"*

Jaja, das stimmt schon. Andererseits ist ein Risiko von ca.
0,0000000000000000000000000000003% für eine Kollision
(bei 100 Millionen Objekten im Repository) wirkt nicht
gerade furchterregend. Und die Sache hat auch ein
paar Vorteile:

 * Hashes lassen sich dezentral berechnen
 * Beim Synchronisieren ist leicht festzustellen, 
   ob ein Objekt vom entfernten Repository geholt werden muss, 
   oder ob lokal schon ein identisches vorhanden ist.
 * Die Hashes eignen sich hervorragend als Prüfsummen,
   um Übertragungs- oder Festplattenfehler zu erkennen.

Objekte in der *Object Database* sind *immutable*
(unveränderbar) und das ist gut so, denn es macht Git 
Robust. Ein neues Commit erzeugt neue Objekte in der 
*Object Database*, Alte bleiben unberührt.
Auch wenn Git abstürzt (was ich persönlich noch nicht 
erlebt habe) oder abgebrochen wird, ist es sehr unwahrscheinlich, 
dass alte Daten aus vorigen Commits beschädigt werden.

*... und die functional Programmers: "Immutable! Da ha'm wir endlich auch mal was zum Jubeln!"*

Git selber nennt sich "the stupid content tracker".

Die *Datenbank* unterstützt im Wesentlichen nur
drei Operationen:

 1. Ein *Object* einfügen
 2. Ein *Object* holen, dessen Hash-Wert man kennt
 3. [Garbage Collection](/Git/2012/05/28/wer-hat-angst-vor-dem-garbage-collector/))

*... und alle Anderen so: "Yeah, that's stupid! And everybody: STUPID!"*

Interessant ist, dass auf dieser Ebene weder von *Dateien* oder *Verzeichnissen* noch von *Commits* die Rede ist. Diese Dinge werden natürlich in der *Object Database* gespeichert, aber es können dort eben auch beliebige andere Dinge abgelegt werden. Das macht Git so flexibel und ermöglicht auch Tools wie Gollum (ein Wiki) oder Bup (eine Backup-Lösung), die mehr oder andere Dinge tun als eine klassische Versionsverwaltung.

*... und Bastler so: "Yeah, damit könnte man ja auch ein ... bauen!"*

Das schöne an so einer einfachen Fassade ist, dass man unterschiedliche Implementierungen dahinter setzen kann. Und das tut Git auch. 

Frische Objekte, z. B. nach einem Commit, werden als einfache Dateien geschrieben. Der Hashwert des Inhalts bestimmt den Verzeichnis- und Dateinamen.

  f2/8f7d6cbe1cf69c7bf018c9d27ebb65b69c701b

In modernen Dateisystemen ist der direkte Zugriff auf Dateien über den Namen rasend schnell. Außerdem lassen sich unveränderbare Dateien prima cachen. Git selber muss dafür gar nichts tun. Der File System Cache erledigt das für uns.

*... und die Performance-Leute so: "Yeah, blazing fast! Until the disc is full ..."*

Der Nachteil: Auch wenn sich nur ein einziges Bytes einer Datei ändert, hat der Content einen anderen Hashwert und muss als neues Objekte in der *Object Database* gespeichert werden. Das Repository bläht sich auf. 

Git löst dies, durch eine zweite Form der Speicherung in der *Object Database*. Gelegentlich packt Git sogenannte *Pack Files* aus vielen Objekten. Bei ähnlichen Objekten wird dann nur einmal das ganze Objekt abgelegt, die anderen werden durch Differenzen dargestellt.
Der Vorteil: Da in Git die Kompression nachgelagert wird, kann es das gesamte Repository nach Ähnlichkeien durchforsten und ist dabei nicht auf die Historie einer einzelnen Datei beschränkt. Beispiel: Auch eine per Copy & Pase angelegte und dann veränderte Datei kann per Differenz abgebildet werden. Gerade bei großen Projekten erreicht Git so eine sehr gute Kompression. Auch bei langer Historie bleibt das Repository nicht selten kleiner als der entpackte Workspace.

*... und die Sparbrötchen so: "Yeah, das spart Speicher!"*
