---
layout: post
title: "Bloomiges - oder wie funktioniert eigentlich ein Bloom-Filter"
category: Git
tags: [Coding Kata, Java, Bloom-Filter]
author: bst
---

Ich liebe ja Algorithmen. Am liebsten mag ich jene, auf die ich von alleine nie gekommen wäre, die mir dann aber, nachdem ich sie kennengelernt habe, vollkommen logisch und einleuchtend erscheinen. Außerdem programmiere ich gerne Coding-Katas während ich mit der Regionalbahn von der Provinz in die Großstadt  pendle. Die gängigen Standard-Katas finde ich oft öde. In der Regel Suche ich mir eine Problemstellung im Umfeld der Projekte, an denen ich gerade arbeite. Das macht mehr Spass. Beim Arbeiten mit [HBase](https://hbase.apache.org/) (einer Datenbank für Hadoop) bin ich auf eine Option Namens `BLOOMFILTER` gestossen, habe sie eingeschaltet, gemessen und mein Programm lief schneller. Das hat mich neugierig gemacht, so dass ich das mal ergoogelt habe und schon hatte ich eine schöne neue Coding Kata.

Damit es nicht zu abstrakt wird, beginnen wir mit einem Beispiel. Wir haben große Mengen an Web-Server-Logs archiviert. Halt, ich muss korrigieren: ich meinte **GROßE MENGEN**. Gelegentlich wollen wir darin nach Einträgen einzelner User suchen, deren Cookie-ID wir kennen. Es gibt eine Datei für jeden Tag. Insgesamt sind es hunderte von Dateien. Da die meisten User unsere Website nicht jeden Tag besuchen, durchsuchen wir die meisten Dateien ohne etwas zu finden. Es wäre nützlich, für jedes Tagesdatei einen Index zu haben, der uns vorab sagen kann, ob ein gegebenes Cookie dort überhaupt enthalten ist.

Genau so einen Index will ich entwickeln.

Das API kann simpel gehalten werden. Mit `add` fügt man Cookies hinzu. Mit `contains` erfragt man, ob ein Cookie enthalten ist. Ein Test dazu ist schnell geschrieben:

```Java
Index index = new Index();

index.add("a-cookie-added-to-the-index-1");
index.add("a-cookie-added-to-the-index-2");

assertTrue("false negative", index.contains("a-cookie-added-to-the-index-1"));
assertTrue("false negative", index.contains("a-cookie-added-to-the-index-2"));

assertFalse("false positive", index.contains("a-cookie-NOT-added-to-the-index-1"));
assertFalse("false positive", index.contains("a-cookie-NOT-added-to-the-index-2"));
```

Die einfachstmögliche Lösung ist wohl, sich alle Cookies zu merken.

```Java
private HashSet<String> set = ...;

public void add(String string) {
	set.add(string);
}

public boolean contains(String string) {
	return set.contains(string);
}
```

Leider ist das teuer, wenn es um GROSSE MENGEN an Cookies geht. Bei 100 Mio Cookies kommen für die Cookies-Indexe locker mal 5 GB zusammen, wenn jedes Cookie 50 Byte belegt. Weil wir die Cookie-Indexe am liebsten im Hauptspeicher halten würden, hätten die sie gerne etwas kompakter.

Der Trick der Bloom-Filterei ist nun Folgendes: Wir speichern nicht die ganzen Cookied-IDs sondern nur "Fingerabdrücke" davon. Für den Fingerabdruck nutzen wir zunächst die Methode `hashCode()` der Klasse 'String'.

```java
private HashSet<Integer> set;

public Index() {
	set = new HashSet<Integer>();
}

public void add(String string) {
	set.add(fingerprint(string));
}

public boolean contains(String string) {
	return set.contains(fingerprint(string));
}

private Integer fingerprint(String string) {
	return string.hashCode();
}
```

So sparen wir Speicher: Je Cookie nur ein `Integer` statt der langen Cookie ID. In unseren kleinen Beispiel brauchen 10KB statt der 34 KB vorher.

Aber die Sache hat einen Haken, denn es kann Kollisionen geben: `contains(cookie)` kann fälschlicherweise `true` liefern, wenn `cookie` zufällig den selben Fingerprint hat, wie anderes bereits hinzugefügtes Cookie. Wir nennen so etwas ein *"false positive"*.

Das ist aber nicht weiter schlimm, sofern es selten auftritt. Wir lesen dann dann gelegentlich Dateien, in denen gar nichts gefunden wird. Deshalb erlauben wir im Unit-Test bis zu 1% *"false positives"*:

```java
	int falsePositives = 0;
	for (String cookie : sampleCookies("a-cookie-NOT-added-to-the-index-", 100000))
		falsePositives += index.contains(cookie) ? 1 : 0;

	double falsePositivesRatio = falsePositives / (double) 100000;
	assertEquals(0.0, falsePositivesRatio, 0.01);
```

Wie können wir noch mehr Speicher sparen? Wie wäre es, wenn je Cookie nur ein Bit in Bitfeld setzen, statt eine ganze Zahl zu speichern. Das ist schnell implementiert:

```java
private int size;
private BitSet bitSet;

public Index(int size) {
	this.size = size;
	bitSet = new BitSet(size);
}

public void add(String string) {
	bitSet.set(fingerprint(string));
}

public boolean contains(String string) {
	return bitSet.get(fingerprint(string));
}

private Integer fingerprint(String string) {
	return Math.abs(string.hashCode()) % size;
}
```

Gebracht hat es leider nichts. Man muss das Bitfeld sehr groß machen, um die Rate an "false positives" unter ein Prozent zu drücken. Im unserem Beispiel braucht es jetzt sogar etwas mehr Speicher (19K) als vorher (10K).

Geben wir nun gleich auf? Nein! Wir beobachten, dass in dem riesigen Bitfeld nur sehr wenige Bits gesetzt sind. Wie wäre es wenn man zwei Bits als Fingerprint setzt? Gesagt. Getan:

```java
public void add(String string) {
	bitSet.set(fingerprint(string).get(0));
	bitSet.set(fingerprint(string).get(1));
}

public boolean contains(String string) {
	return bitSet.get(fingerprint(string).get(0)) //
			&& bitSet.get(fingerprint(string).get(1));
}

private List<Integer> fingerprint(String string) {
	Random random = new Random(string.hashCode());
	return asList(random.nextInt(size), random.nextInt(size));
}
```

Anmerkung: Wir nutzen jetzt den Pseudozufallsgenerator `Random` um die Positionen für die beiden Fingerprint-Bits zu bestimmen. Das wir diesen mit dem `hashCode()` initialisieren, ist auch dabei garantiert, dass für den selben Cookie immer derselbe Fingerprint entsteht.

Jetzt können wir den Index so klein machen, dass er in unserem Beispiel mit weniger als 3K auskommt, ohne dass die erlaubte Fehlerquoute von einem Prozent überschritten wird. Das ist doch was.

Der Ehrgeiz ist geweckt: Wenn zwei Fingerprint-Bits besser sind als eines, warum dann nicht drei nehmen? Oder noch mehr?

Wir verabeiten die Fingerprint-Bits in Schleifen und machen die Anzahl konfigurierbar:

```java
	public void add(String string) {
		for (int f : fingerprint(string))
			bitSet.set(f);
	}

	public boolean contains(String string) {
		for (int f : fingerprint(string))
			if (!bitSet.get(f))
				return false;

		return true;
	}

	private List<Integer> fingerprint(String string) {
		Random random = new Random(string.hashCode());

		ArrayList<Integer> slots = new ArrayList<>();
		for (int i = 0; i < nrOfSlotsPerFingerprint; i++)
			slots.add(random.nextInt(size));
		return slots;
	}
```

** Et voilà, wir haben einen Bloom-Filter!**

Mit etwas herumprobieren finden wir eine Konstellation (10.000 Bits, 8 Fingerprint-Bits) mit der wir den Index auf 1,4K schrumpfen können. Verglichen mit den 34K der ersten Implementierung kann man das ja schon als Fortschritt betrachten.

## Mehr über Bloom-Filter

Die Datenbank HBase nutzt einen Bloom-Filter für Region-Files.

Chrome nutzt einen Bloom-Filter
