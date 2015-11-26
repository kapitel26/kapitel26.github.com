---
layout: post
title: "Bloomiges - Eine Coding-Kata über Bloom-Filter"
category: Git
tags: [Coding Kata, Java, Bloom-Filter]
author: bst
---

Ich liebe ja Algorithmen. Am liebsten mag ich jene, auf die ich von alleine nie gekommen wäre, die mir dann aber, nachdem ich sie kennengelernt habe, vollkommen logisch und einleuchtend erscheinen. Außerdem programmiere ich gerne Coding-Katas während ich mit der Regionalbahn von der Provinz in die Großstadt  pendle. Die gängigen Standard-Katas finde ich oft öde. In der Regel Suche ich mir eine Problemstellung im Umfeld der Projekte, an denen ich gerade arbeite. Das macht mehr Spass. Beim Arbeiten mit [HBase](https://hbase.apache.org/) (einer Datenbank für Hadoop) bin ich auf eine Option Namens `BLOOMFILTER` gestossen, habe sie eingeschaltet, gemessen und mein Programm lief schneller. Das hat mich neugierig gemacht, so dass ich das mal ergoogelt habe und schon hatte ich eine schöne neue Coding Kata.

Damit es nicht zu abstrakt wird, beginnen wir mit einem Beispiel. Wir haben große Mengen an Web-Server-Logs archiviert. Halt, ich muss korrigieren: ich meinte **GROßE MENGEN**. Gelegentlich wollen wir darin nach Einträgen einzelner User suchen, deren Cookie-ID wir kennen. Es gibt eine Datei für jeden Monat. Es sind Dutzende von Dateien. Da wir weder wissen, wann, wie oft und wie lange der User auf der Website war, müssen wir alle Dateien durchsuchen. Es wäre nützlich, wenn wir eine Art Index im Hauptspeicher halten könnten, der uns sagen kann, in welchen Dateien wir suchen müssen. So einen Index will ich programmieren.

Das API ist simpel. Mit `add` fügt man Cookies hinzu. Mit `contains` erfragt man, ob ein Cookie enthalten ist. Ein Test dazu ist schnell geschrieben.

```Java
Index index = new Index();

index.add("cookie-1");
index.add("cookie-2");

assertTrue("false negative", index.contains("cookie-1"));
assertTrue("false negative", index.contains("cookie-2"));

assertFalse("false positive", index.contains("not-added-1"));
assertFalse("false positive", index.contains("not-added-2"));
```

Die einfachstmögliche Implementierung merkt sich einfach alle Cookies in einer Collections, z. B. dem `HashSet`.

```Java
	private HashSet<String> set = ...;

	public void add(String string) {
		set.add(string);
	}

	public boolean contains(String string) {
		return set.contains(string);
  }
```

[-> Github](https://github.com/bstachmann/kata-bloomiges/commit/5c388b3b5f6589c533d7eb1e2e64bc32a18a87ee)

Leider ist das teuer, wenn es um GROSSE MENGEN an Cookies geht. 100 Mio. Cookies knabbern dann locker mal 5 GB von unserem schönen Hauptspeicher weg, wenn jedes Cookie mit 50 Byte belegt.

Der Trick der Bloom-Filterei ist nun Folgender: Wir speichern nicht die ganze Cookied-ID sondern nur einen "Fingerabdruck" davon. Das hat mehrere Auswirkungen:

 * Wir brauchen viel weniger Speicher, sofern die Fingerabdrücke schön klein sind.
 * Wir können die originalen Cookied-IDs nicht mehr aus dem Index herausholen. Wollen wir aber nicht.
 * Es kann Kollisionen geben, bei denen zwei Cookies den selben Fingerprint haben.

Durch Kollisionen, kommt es zu "False Positives", denn `contains(c) == true` bedeutet jetzt: `c` hat den selben Fingerabdruck wie ein bereits hinzugefügtes Cookie. Dieser könnte aber für ein anderes Cookies gesetzt worden sein. Wenn das selten auftritt, ist es für unseren Fall nicht schlimm. Die Folge wären, dass wir in seltenen Fällen Monatsdateien lesen, u, am Ende feststellen, dass das gesuchte Cookie doch nicht enthalten ist.

Wir passen also den Test an, indem
