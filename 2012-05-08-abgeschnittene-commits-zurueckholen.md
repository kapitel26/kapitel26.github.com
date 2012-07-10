---
layout: post
title: "Abgeschnittene Commits zurückholen"
description: "Über Reparaturen nach versehentlich abgeschnittenen Commits (Dangling Commits)"
category: Git
tags: [dangling commits, reflog]
author: bst
---
{% include JB/setup %}

Git gibt dem Entwickler viele Freiheiten. Die Freiheit
Fehler zu machen, gehört dazu.
Ich nehme sie oft in Anspruch, 
z. B. mit einem vermurksten `git rebase` oder 
[einem voreiligen `git push -f`](/2012/04/28/push-mit-force-in-git).
Was ich an Git liebe, ist das es fast immer Möglichkeiten bietet,
den Kopf wieder aus der Schlinge zu ziehen.

Dangling Commits
----------------

Operationen, die Branch-Zeiger verändern, wie etwa `git reset`, `git branch -d`,
`git commmit --amend` oder `git rebase` können Commits im lokalen 
Repository abschneiden. `git push -f` kann Commits in entfernten Repositorys 
abschneiden.
  
  <pre>
      D1---D2  "Abgeschnitten!"
     / 
  --O---A---M1---M2  master  
         \
          F1---F2  feature-a 
  </pre>
  
Im obigen Beispiel gibt es zwei Branches `master` und `feature-a`
mit den Historien `O--A--M1--M2`und `O--A--F1--F2`. 
Die Commits `D1` und `D2` sind in keiner Branch-Historie mehr
enthalten. Man nennt sie *Dangling Commits* oder etwas allgemeiner
*Loose Objects*.

Garbage Collection
------------------

Gelegentlich (bei bestimmten Kommandos oder manuell durch `git gc`)
räumt Git solche Commits ab, um Speicher zu sparen und damit das Repository
nicht unnötig langsam wird. Aber: **Keine Angst!** In der Default-Konfiguration 
werden *Loose Objects* frühestens nach 2 Wochen abgeräumt 
(Konfiguration `gc.pruneExpire`). Commits, die im Reflog (siehe unten) stehen, 
werden sogar noch länger gehalten (Konfigurationen `gc.reflogExpire` und 
`gc.reflogExpireUnreachable`).

Commits wiederfinden
--------------------

Es ist genau wie bei Rumpelstilzchen: Kennt man den Namen, hat man
die Macht. In Git ist es der Commit-Hash, den man kennen muss.
Um an den Commit-Hash abgeschnittener Commits zu kommen, kann man
verschiedenes tun:

 * **Konsole**: Oft reicht es, in der Konsole nach oben zu scrollen.
   Viele Git Befehle schreiben Commit-Hashes auf die Console, wenn neue
   Commits entstehen. Tipp: Keine Konsolenfenster schließen, bis
   Sie ihr Problem gelöst haben.
   
 * **Reflog**: Git führt Buch über alle Änderungen an Branches und Tags und 
   speichert diese normalerweise für 90 Tage.
  
 * **`git fsck`**: Mit diesem Kommando kann man gezielt nach abgeschnittenen
   Commits suchen. 
 
 * **Andere Repositorys**: Git ist dezentral. Ein Commit das lokal
   gelöscht wurde, kann in den Klonen anderer Entwickler durchaus noch
   vorhanden sein.

Commits wiederherstellen
------------------------

Sobald man Hash des verlorenen Commits kennt, ist es einfach.
Wenn man die Änderungen wieder haben möchste:

	$ git merge 1234567
	
Oder man merkt es sich erstmal, um später darauf zugreifen zu können.	
	
	$ git checkout -b my-lost-changes 1234567
	
Manchmal möchte man einen Branch auf einen alten Stand zurücksetzen.
	
	$ git checkout my-branch
	$ git reset --hard 12334567

Das Reflog
----------

In `.git/logs/` protokolliert Git alle Branch-Änderungen.
Man kann sich die Protokolldort direkt ansehen, wenn man möchte.
Einfacher geht es mit der `--walk-reflogs`-Option
  
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


FSCK
----
 
Neben vielen anderen tollen Dingen kann der `git fsck`-Befehl auch 
abgeschnittene Commits wiederfinden:
 
    <pre>
	$ git fsck --lost-found
	dangling commit 24503845dfa44353e5ebd64dc75183823538e85f
	dangling commit fdb36f69a12d16bf345d29c69057115ed19ac96a
    </pre>
    
Externe Links
-------------

 * [Nick Quaranto über das Reflog][1]
 * [Noch mehr über das Reflog von Sitaram Chamarty][2]
 * [Und noch mal Nick Quaranto über das Wiederherstellen von Commits][3]
 
  [1]: http://gitready.com/intermediate/2009/02/09/reflog-your-safety-net.html
  [2]: http://sitaramc.github.com/concepts/reflog.html
  [3]: http://de.gitready.com/advanced/2009/01/17/restoring-lost-commits.html
