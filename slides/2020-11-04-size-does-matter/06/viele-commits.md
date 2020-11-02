<!-- .slide: data-background-image="06/viele-commits.png" -->

## Viele Commits<br/><br/><br/><br/>
================================================================

## Linux Kernel


Der Linux Kernel hat knapp eine Millionen Commits.

Das Logging der letzten 10 Commits dauert 9 Sekunden.

```
time git log --graph --oneline -10
```

notes:

Das Problem ist der Graph, ohne --graph geht es schnell

https://devblogs.microsoft.com/devops/a-deep-dive-into-git-performance-using-trace2/
https://git-scm.com/docs/commit-graph

================================================================

## Langsame Operationen

 * Historie als Graph anzeigen
 * Merge-Base ermitteln
   * Merge, Rebase
   * Status
 * Wo ist das Commit enthalten?

```
git log --graph --oneline -10
git merge feature/42
git branch --contains <hash>
```

notes: 

There are two main costs here:

    1. Decompressing and parsing commits.

    2. Walking the entire graph to satisfy topological order constraints.

================================================================

## Commit-Graph

 * Seperater Index für Commits
   * OID
   * Parents
   * Commit Date
   * Tree OID
   * Generation Number

```
# Nur Pack-Files indizieren
git commit-graph write 
# Alle Commits indizieren
git show-ref -s | git commit-graph write --stdin-commits
# Bei jedem Fetch aktualisieren
git config fetch.writeCommitGraph true
```

notes:

Generation Number ist die Anzahl der Commits/Parents bis zur Wurzel
* Dadurch kann man leicht feststellen ob zwei Commits nicht voreinander liegen
================================================================

## Linux Kernel mit Commit-Graph


Das Logging der letzten 10 Commits des Linux Kernels 
dauert mit Commit-Graph 0,3 Sekunden.

```
time git log --graph --oneline -10
```


================================================================

<img src="06/ueberblick-viele-commits.png" width="90%" style="border: 0px; box-shadow: none;">


================================================================

### &#8669; Bjørn


