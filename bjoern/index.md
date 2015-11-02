---
layout: page
title: "Bjørn"
description: "Über Bjørn Stachmann"
group: navigation
author: bst
weight: 5
---

Bjørn Stachmann
---------------

{% include author.html %}

**Moin**,

ich bin **Bjørn Stachmann**, komme aus Flensburg, und mache
Software. Angefangen hat das ungefähr so:

	3584 BYTES FREE
	READY.

	10 PRINT "Moin!"
	20 GOTO 10

	RUN

Das ist jetzt 30 Jahre her (der Rechner war ein *Commodore VC 20*,
ein Vorgänger des bekannteren *C64*) und Software mach ich immer noch.
Mal als Programmierer, mal als Softwarearchitekt, mal als Berater,
mal als Trainer und heute als Software Developer für [OTTO](https://www.otto.de/unternehmen/). Vieles hat sich verändert:
Statt überschauberen 3584 Byte arbeiten wir heute mit Server-Clustern,
die über Hunderte von Gigabytes an Hauptspeicher verfügen (8 Größenordnungen
Unterschied!).
Aus 8 Bits wurden 64, natürlich Multicore.
Nach Basic kamen weitere Programmiersprachen: Assembler, Pascal,
C, Lisp, Oberon, C++, Smalltalk, Java, Java, Java, Python, PHP und Ruby.
Weitere Betriebssysteme natürlich auch: C64, Atari ST/Gem, DOS,
BS2000, Macintosh, Windows (von 95 bis XP), OS X, Linux.
Ein Hype folgte auf den Nächsten: CORBA, OOA/OOD, J2EE, MDA, SOA, TDD,
NoSQL, Big Data. Viel Nützliches dabei, viel Schrott auch, ein
*Silver Bullet* war nie dabei. Mit der Aufzählung der Frontend-Technologien
könnte man eine eigenes Blog füllen. Ich mach' das jetzt mal nicht.
Darüber hinaus hat sich kaum was getan und die Probleme sind irgendwie
immer noch die gleichen und gute Software zu machen ist immer noch
ein wenig Abenteuer und viel harte Arbeit.
Trotzdem, oder vielleicht gerade deshalb, mag ich nicht davon lassen.

<div class="row">

	<div class="span3" align="left">
		Bjørn auf Social Media<br/>
	    <a href="http://www.twitter.com/old_stachi">Twitter</a>
	    <a href="http://www.xing.com/profile/Bjorn_Stachmann">Xing</a>
	    <a rel="me" href="https://plus.google.com/107293837004630946370">Google+</a><br/>
	</div>

</div>

Meine Beiträge
--------------

<table class="table table-striped">
  {% for post in site.posts %}
    {% if post.author == "bst" %}
      {% assign current_post = post %}
      {% include post_in_a_table_row %}
    {% endif %}
  {% endfor %}
</table>
