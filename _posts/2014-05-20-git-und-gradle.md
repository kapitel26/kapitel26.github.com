---
layout: post
title: "Git und Gradle - Intro"
category: Git
tags: [Git Gradle]
author: rp
---

Lange Zeit war ich mit Maven und Ant in meinem Werkzeugkoffer zufrieden.

Maven habe ich immer dann genutzt, wenn das Projekt sich an die Standardkonventionen gehalten hat
und nur wenige zusätzliche Plugins benötigt wurden.
Ant war mein Werkzeug, wenn ich mehr Freiheitsgrade brauchte.

[Gradle](http://www.gradle.org/) ermöglicht mir beides und ich frage mich, wie ich es so lange mit den
anderen Werkzeugen ausgehalten habe.

Ich werde in loser Folge ein paar Posts über die Möglichkeiten von Gradle im Zusammenspiel mit Git schreiben.

Los geht es heute mit dem Eintragen des Commit-Hash in die Manifest-Datei.

### Das Gradle-Git-Plugin
Das [Git-Plugin](https://github.com/ajoberstar/gradle-git) wird in der Datei `build.gradle` folgendermassen hinzugefügt:

<pre>
buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath 'org.ajoberstar:gradle-git:0.8.0'
    }
}

import org.ajoberstar.grgit.*
</pre>

Das Plugin basiert auf [JGit](http://www.eclipse.org/jgit/) und ist somit plattformunabhägig.
Es erfordert keine Installation von nativen Programmen auf dem Build-Rechner.

### Den Commit-Hash ermitteln

Das Plugin bringt keine Tasks mit, sondern eine [Groovy-API](http://ajoberstar.org/grgit/docs/groovydoc/index.html) die man in eigenen Tasks benutzen kann.

Um den Hash-Wert des aktuellen Commit zu ermitteln und auszugeben, reicht folgender Code:

<pre>
task printHeadHash << {
  def grgit=Grgit.open(project.file('.'))
  println grgit.head().id
}
</pre>

### Repository auf Änderungen überprüfen

Um zu ermitteln, ob es unversionierte Änderungen gibt, geht man folgendermaßen vor:

<pre>
task printIsClean << {
  def grgit=Grgit.open(project.file('.'))
  if(grgit.status().isClean()) {
    println "Alles versioniert"
  } else {
    println "Unversionierte Änderungen"
  }
}
</pre>

### Commit-Hash in die Manifest-Datei eintragen

Als letztes bringt man alle Teile zusammen und schreibt den Commit-Hash in die Manifest-Datei,
allerdings nur dann wenn es keine unversionierten Änderungen gibt.

<pre>
apply plugin: 'java'

buildscript {
    repositories {
        mavenCentral()
    }
    dependencies {
        classpath 'org.ajoberstar:gradle-git:0.8.0'
    }
}

import org.ajoberstar.grgit.*

jar {
  manifest {
    def grgit=Grgit.open(project.file('.'))
    if(grgit.status().isClean()) {
      attributes("Commit-Id": grgit.head().id)
    } else {
      attributes("Commit-Id": 'unknown')
    }
  }
}
</pre>
