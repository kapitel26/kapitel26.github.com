---
layout: post
title: "Oops: Push mit Force in Git"
description: ""
category: Git
tags: [force, push, oops]
---
{% include JB/setup %}

Aufgrund eines "Vorfalls" in einem befreundeten Projekt wurde ich
neulich gefragt, ob wir in unserem Buch denn auch vor "`push` mit `-f`" 
warnen. Für einen kurzen Augenblick stieg der Puls: Hatten wir das tatsächlich 
übersehen? Ein kurzer Blick in Inhaltsverzeichnis beruhigte mein Gewissen. 
Auf Seite 79 (ganz unten) wird ordnungsgemäß vor `-f` gewarnt.
Für all jene, die Seite 79 vielleicht nicht mit der vollen Aufmerksamkeit
gelesen haben, gibt's hier ein paar Tipps kann was man tun kann, wenn 
man sich "verpushed" hat.

Versehentlich "mit Force gepushed"
----------------------------------

Wie viele andere Befehle auch hat der `push`-Befehl in Git eine Option `-f` 
bzw. `--force`:

	$ push -f               # Hoppla, das war nicht gewollt!

Und wie bei vielen anderen Befehlen auch, ist es nur selten 
gut, diese Option zu nutzen. Ein Beispiel:

 * **Vorher** 
   <pre>
   --O---A---F1---F2  origin/master
          \
           M1---M2  master   
   </pre>

 * **Nach dem `push -f`** 
   <pre>
   --O---A---F1---F2  "Abgeschnitten!"
          \
           M1---M2  master, origin/master   
   </pre>

Etwas unerfreuliches ist passiert: Features, die mit `F1` und `F2`
implementiert wurden, sind plrözlich verschwunden.
Auf Überraschungen dürfen sich jetzt jene Entwickler gefasst machen,
die diese Features gebaut haben. Mit etwas Pech dürfen sie beim nächsten 
`pull` erneut mergen, was sie schon längst abgeliefert haben.
Vollends verwirrt aber werden jene Entwickler sein,
die auf Basis von `F1` oder `F2` ganz andere Features entwickelt haben.
Ihnen kann es passieren, dass sie beim `pull` einen Merge-Konflikt 
erhalten, bei dem Änderungen aus `F1` oder `F2`
als *eigene Änderungen* angezeigt werden, obwohl
sie von jemand anderem implementiert wurden.

Oft sind mehrere Branches betroffen
-----------------------------------

Das Default-Verhalten, wenn man ein `push` ohne weitere Parameter
ausführt, ist wie folgt. Git führt ein "Matching" durch,
es führt das `push` für jeden lokalen Branch aus, 
dem ein gleich benannter Branch im entfernten Repository gegenüber steht.
Es können also viele Branches betroffen sein.

Wer das doof findet kann zweierlei tun: 

 1. `git config push.default upstream`
 2. Sich an der [Diskussion][push discussion]
    über das künftige Default-Verhalten von `push` beteiligen.

Trotz allem: *Don't Panic!* 
---------------------------

Git wird mit Handtuch ausgeliefert. Es ist unwahrscheinlich, 
dass wirklich etwas verloren gegangen ist.
Zwar sind einige Commits im Hauptrepository nicht mehr sichtbar,
wenn man `git log` ausführt, aber

 * sie sind aber sehr wahrscheinlich immer noch im da 
   und bleiben es auch, bis Git das nächste *Garbage Collect* durchführt.
   
 * Git ist dezentral. Sicherlich gibt es auch noch Kopien auf den Rechnern
   der Entwickler, die diese Commits erstellt oder bereits gepulled haben.
   
 * Jedes Git-Repository führt lokal Buch über alle Änderungen an Branches,
   Tags und Stashes. Man nennt dies das *Reflog*. Siehe 
   
   
Die Reflogs zeigen, was passiert ist.
-------------------------------------   
 
	git log --walk-reflogs jax@{now}

Bare-Repository richtig konfigurieren [config]
-----------------------------------------------

<a name="config"/>

	git clone --bare --config core.logAllRefUpdates=true ~/work/kapitel26/	
	
	
Test the link [] [1].
	
Links
-----

  [1]: http://stackoverflow.com/questions/3876206/how-do-i-view-a-git-repos-recieve-history "asfd"
  [2]: http://stackoverflow.com/questions/6140083/how-to-create-reflogs-information-in-an-existing-bare-repository
  [3]: http://sitaramc.github.com/concepts/reflog.html
  [4]: http://gitready.com/intermediate/2009/02/09/reflog-your-safety-net.html
  [push discussion]: http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694)
