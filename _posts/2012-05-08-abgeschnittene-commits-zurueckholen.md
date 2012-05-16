---
layout: post
title: "Abgeschnittene Commits zurückholen"
description: "Über Reparaturen nach versehentlich abgeschnittenen Commits (Dangling Commits)"
category: 
tags: [dangling commits, reflog]
---
{% include JB/setup %}

Git gibt dem Entwickler viele Freiheiten. Die Freiheit
Fehler zu machen, gehört auch dazu.
Nicht selten habe ich diese Freiheit in Anspruch genommen, 
z. B. durch ein vermurkstes `git rebase` oder 
durch [ein voreiliges `git push -f`](/2012/04/28/push-mit-force-in-git).
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
enthalten. Man nennt sie *Dangling Commits* oder allgemeiner
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


Es gibt mehrere Möglichkeiten, solche Commits wieder zu finden:

 * das Reflog

Hat man Zugriff auf das Reflog des Ziel-Repositorys, ist es leicht, den
vorherigen Stand zu finden, und das Problem zu beheben.
[Ohne Zugriff auf auf das Reflog](/2012/05/08/reparaturen-nach-push--force-ohne-zugriff-auf-das-reflog),
ist es schwerer.
  
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


 
 * git fsck
 
    <pre>
	$ git fsck --lost-found
	dangling commit 24503845dfa44353e5ebd64dc75183823538e85f
	dangling commit fdb36f69a12d16bf345d29c69057115ed19ac96a
    </pre>
 
 * Informationen aus Client-Repositorys
   * Das Reflog von Client-Repositorys
   * Branches und Tags

  [1]: http://stackoverflow.com/questions/3876206/how-do-i-view-a-git-repos-recieve-history "asfd"
  [2]: http://stackoverflow.com/questions/6140083/how-to-create-reflogs-information-in-an-existing-bare-repository
  [3]: http://sitaramc.github.com/concepts/reflog.html
  [4]: http://gitready.com/intermediate/2009/02/09/reflog-your-safety-net.html
  [5]: http://de.gitready.com/advanced/2009/01/17/restoring-lost-commits.html
