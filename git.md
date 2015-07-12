---
layout: page
title : Git
header : Aktuelles zu Git
---

Interessantes über Git
----------------------

 * **Git vs. Mercurial**
   <br>
   {% include git-vs-hg-series.md %}
 * [Subtree](git/2012/08/10/git-subtree---alternative-zu-submodulen)
 * [Reflog](/git/2012/05/09/reflog-fuer-bare-repositorys-in-git-einrichten)
 * [Garbage Collector](/git/2012/05/28/wer-hat-angst-vor-dem-garbage-collector)

Best Practices
--------------

 * [Passwörter verwalten](/git/2012/12/03/passwoerter-verwalten)
   mit dem "Credential Helper"
 * Klarere Historie durch [No-Fast-Forward als Default](git/2012/10/12/no-fast-forward-als-default)

Troubleshooting: Falls doch mal was schief geht
-----------------------------------------------

 * [Verlorene Commits wiederfinden](/git/2012/05/08/abgeschnittene-commits-zurueckholen)
 * [Push mit Force](/git/2012/04/28/push-mit-force-in-git)


Alle Beiträge (chronologisch)
-----------------------------

<ul>
	{% assign pages_list = site.categories["Git"] %}  
	{% include JB/pages_list %}
</ul>
