---
layout: post
title: "Wie findet man den Anfang eines Branches in Git?"
category: Git
tags: [Branches]
author: bst
---

## Antwort 1: Im Allgemeinen gar nicht!

In vielen Fällen lässt sich der Branchanfang nachträglich nicht mehr ermitteln.
[Warum das so ist, können Sie hier lesen](2018-04-14-warum-kann-man-in-git-den-anfang-eines-branches-nicht-bestimmen.md)

In einigen Fällen kann man Git dennoch ein paar nützliche Informationen entlocken:


## Antwort 2: Mit Strukturinformationen!

Falls Sie Branches auf dem `master` immer per `merge` integrieren ohne dabei `fast-forward` zu nutzen, funktioniert Folgendes:

    diff \
      <(git log --oneline --first-parent master) \
      <(git log --oneline --first-parent my-feature) \
      | grep "^>" \
      | tail -1

Ein Beispiel zeigt, wie das funktioniert:

```
     M1-------M2----M3------M4
      \      /  \  /       /
       A1--A2    B1--B2--B3
```

Man nutzt aus,
dass bei Merges der erste Vorgänger immer das Commit vom aktuellen Branches ist.
Man kann also erkennen,
von wo aus der Merge ausgeführt wurde.
Die sogenannte `first-parent`-History ist jene Kette von Vorgängern,
wo man bei Merges immer dem ersten Vorgänger folgt.

Im Beispiel hat der `master` die First-Parent-History `M1, M2, M3, M4`
und der Feature-Branch `M1, M2, B1, B2, B3`.
Beide beginnen mit derselben Vorgeschichte `M1, M2`.
`B1` ist das erste Commit des Feature-Branches.


## Antwort 3: Mit dem Reflog!

Manchmal geht es leicher:
Falls sie den Branch in ihrem lokalen Repository erstellt,
ist es einfach den Branchanfang zu bestimmen.

Denn für lokale Branches speichert Git nämlich ein sogenanntes *Reflog*, in dem alle Änderungen verzeichnet werden.
Die Erstellung eines Branches ist in der Regel der erste Eintrag im Reflog.
Sie können das Reflog mit dem `reflog`-Befehl einsehen:

    $ git reflog add-staticman | tail -1
    9afca6d add-staticman@{8}: branch: Created from HEAD

**Aber Achtung:** Falls der Branch nach seiner Erstellung durch  `rebase` oder `reset` umgesetzt wurde, kann diese Information irreführend sein.
