---
layout: post
title: "Oops: Push mit Force in Git"
description: "push --force"
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
   
 * wenn man es [richtig konfiguriert](#configure-reflog),
   führt Git Buch über alle Änderungen an Branches und
   Tags. Das *Reflog*.
   
Der einfache Fall
----------------- 
 
Hat man Zugriff auf das Reflog des Ziel-Repositorys, ist es einfach, den
vorherigen Stand zu finden.
  
	$ git log --walk-reflogs --date=iso master

	commit 03aacfa668b36bc0f5d03195aff2ae2a8bf917c7
	Reflog: HEAD@{2012-05-02 22:04:56 +0200} (bstachmann)
	Reflog message: push
	Author: bstachmann
	Date:   2012-05-02 22:04:44 +0200
	
	    M2
	
	commit 5276d1cc8e730043c73fbcf17b281518d6b93f10
	Reflog: HEAD@{2012-05-02 22:03:37 +0200} (bstachmann)
	Reflog message: push
	Author: bstachmann
	Date:   2012-05-02 22:03:26 +0200
	
	    F2

	...

Im Beispiel ist `5276d1cc` die Version, die "übergebügelt"
wurde. Wir merken uns diese Version unter dem Namen 
`old-master`.

    $ git branch old-master 5276d1cc

Die eigentliche Reparatur kann man dann in einem beliebigen
Klon des 
    
    $ git fetch origin master old-master
    $ git checkout master
	$ git merge old-master
	$ git push


Bare-Repositorys richtig konfigurieren    <a id="configure-reflog"/>
--------------------------------------

	git clone --bare --config core.logAllRefUpdates=true ~/work/kapitel26/	
	
	
Links
-----

  [1]: http://stackoverflow.com/questions/3876206/how-do-i-view-a-git-repos-recieve-history "asfd"
  [2]: http://stackoverflow.com/questions/6140083/how-to-create-reflogs-information-in-an-existing-bare-repository
  [3]: http://sitaramc.github.com/concepts/reflog.html
  [4]: http://gitready.com/intermediate/2009/02/09/reflog-your-safety-net.html
  [5]: http://de.gitready.com/advanced/2009/01/17/restoring-lost-commits.html
  [push discussion]: http://thread.gmane.org/gmane.comp.version-control.git/192547/focus=192694)
