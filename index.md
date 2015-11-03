---
layout: page
title: Git - Das sechsundzwanzigste Kapitel
tagline:
---

<!-- Carousel
================================================== -->
<link href="/assets/bootstrap/css/carousel.css" rel="stylesheet">

<div id="myCarousel" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
    <li data-target="#myCarousel" data-slide-to="1"></li>
  </ol>
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <div class="container">
        <div class="carousel-inner text-center">
          <div class="col-xs-12" style="height:20px;"></div>
          <div class="col-md-12">
            <a class="btn btn-lg btn-primary" href="git-buch/" role="button">Das Buch, 3. Auflage, jetzt NEU!</a>
          </div>
          <div class="col-xs-12" style="height:20px;"></div>
          <a href="git-buch/">
            <img src="git-buch/buch-cover.jpg" alt="Git-Buch Cover"/>
          </a>
        </div>
      </div>
    </div>
    <div class="item">
      <div class="container">
        <div class="carousel-inner text-center">
          <div class="col-xs-12" style="height:20px;"></div>
          <div class="col-md-12">
            <a class="btn btn-lg btn-primary" href="archive.html" role="button">Das Blog</a></p>
          </div>
          <div class="col-xs-12" style="height:20px;"></div>
          <table class="table table-striped">
            {% for post in site.posts limit:10 %}
              {% assign current_post = post %}
              {% include post_in_a_table_row %}
            {% endfor %}
          </table>
        </div>
      </div>
    </div>
  </div>
  <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div><!-- /.carousel -->


Wenn man ein [Buch](git-buch) schreibt, muss man irgendwann aufhören.
Schließlich soll das Ganze ja irgendwann gedruckt und verkauft werden.
Bei unserem Git-Buch, war das nach 25 Kapiteln der Fall.
Mit 25 Kapiteln ist Git aber noch lange nicht erschöpfend behandelt,
es gäbe so viel mehr darüber zu schreiben. Und es gibt noch viel
mehr Themen, die uns beschäftigen, nicht nur Git.
Das **Sechsundzwanzigste Kapitel** steht also für all die Dinge,
über die wir immer schon mal etwas schreiben wollten.
Wir hoffen, dass für Euch (Ihr anonyme Masse da draußen im Internet),
etwas Interessantes dabei ist:

**[René](/rene)**  & **[Bjørn](/bjoern)**
