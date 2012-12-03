---
layout: page
title : Git
header : Aktuelles zu Git
group: navigation
weight: 4
---
{% include JB/setup %}

Interessantes über Git
----------------------

 * **Git vs. Mercurial**
   <br>
   {% include git-vs-hg-series.md %}
 * [Subtree](Git/2012/08/10/git-subtree---alternative-zu-submodulen)
 * [Reflog](/Git/2012/05/09/reflog-fuer-bare-repositorys-in-git-einrichten)
 * [Garbage Collector](/Git/2012/05/28/wer-hat-angst-vor-dem-garbage-collector)

Best Practices
--------------
 
 * [Passwörter verwalten](/Git/2012/12/03/Passwoerter-verwalten)
   mit dem "Credential Helper"
 * Klarere Historie durch [No-Fast-Forward als Default](Git/2012/10/12/no-fast-forward-als-default)

Troubleshooting: Falls doch mal was schief geht
-----------------------------------------------

 * [Verlorene Commits wiederfinden](/Git/2012/05/08/abgeschnittene-commits-zurueckholen)
 * [Push mit Force](/Git/2012/04/28/push-mit-force-in-git)


Alle Beiträge (chronologisch)
-----------------------------

<ul>
	{% assign pages_list = site.categories["Git"] %}  
	{% include JB/pages_list %}
</ul>

 

