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
    <li data-target="#myCarousel" data-slide-to="2"></li>
  </ol>
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <div class="container">
        <div class="carousel-caption">
          <p>
            <a href="https://www.dpunkt.de/buecher/4518.html">
              <img src="git-buch/buch-cover.jpg" alt="Git-Buch Cover"/>
            </a>
          </p>
          <a class="btn btn-lg btn-primary" href="#" role="button">Das Git-Buch</a></p>
        </div>
      </div>
    </div>
    <div class="item">
      <img class="first-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="First slide">
      <div class="container">
        <div class="carousel-caption">
          <h1>Example headline.</h1>
          <p>Note: If you're viewing this page via a <code>file://</code> URL, the "next" and "previous" Glyphicon buttons on the left and right might not load/display properly due to web browser security rules.</p>
          <p><a class="btn btn-lg btn-primary" href="#" role="button">Sign up today</a></p>
        </div>
      </div>
    </div>
    <div class="item">
      <img class="second-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Second slide">
      <div class="container">
        <div class="carousel-caption">
          <h1>Another example headline.</h1>
          <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
          <p><a class="btn btn-lg btn-primary" href="#" role="button">Learn more</a></p>
        </div>
      </div>
    </div>
    <div class="item">
      <img class="third-slide" src="data:image/gif;base64,R0lGODlhAQABAIAAAHd3dwAAACH5BAAAAAAALAAAAAABAAEAAAICRAEAOw==" alt="Third slide">
      <div class="container">
        <div class="carousel-caption">
          <h1>One more for good measure.</h1>
          <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
          <p><a class="btn btn-lg btn-primary" href="#" role="button">Browse gallery</a></p>
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

Aktuell: [Continuous Lifecycle '14](/git/2014/11/11/continuous-lifecycle-2014/)
------------------------------------------------

Blog
----

<table class="table table-striped">
  {% for post in site.posts %}
    {% assign current_post = post %}
    {% include post_in_a_table_row %}
  {% endfor %}
</table>
