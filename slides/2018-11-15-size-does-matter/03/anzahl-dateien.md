# Viele Dateien!


================================================================


## Viele Dateien - Probleme


 * `checkout` langsam!
 * IDE glüht!
 * `status` langsam!


notes:

 * Performance des Filesystems beim initialen Auschecken und Branch wechseln
   - `checkout` und andere Befehle, die den Workspace manipulieren.
 * Performance der IDE bei vielen offenen Projekten
 * Performance von Git beim Status-Befehl


================================================================


#### Viele Dateien - `checkout` langsam!

### Abhilfe: Sparse Checkout

Die Steuerdatei (`sparse-checkout`) bestimmt,  
welche Verzeichnise in den Workspace geholt werden.

[siehe `read-tree`, Sparse Checkout](https://git-scm.com/docs/git-read-tree#_sparse_checkout)


================================================================


#### Viele Dateien - `checkout` langsam!

### Abhilfe: Sparse Checkout

Klonen mit Sparse Checkout

```bash
git clone --no-checkout <repo-url>
cd <repo-dir>
git config core.sparseCheckout true
echo "/module-a/" > .git/info/sparse-checkout
git checkout master
```

Verzeichnis einblenden
```bash
echo "/module-a/" >> .git/info/sparse-checkout
git read-tree -mu HEAD
```


notes:


TODO Anmerkungen zu Usage von Sparse-Checkout


================================================================


#### Viele Dateien - IDE glüht!

### Abhilfe

 * *Sparse Checkout* hilft oft auch hier

 * Monorepo `!=` Monolith
   
   Modulverzeichnise können/sollten  
   separate IDE-Projekte sein.


================================================================

#### Viele Dateien - `status` langsam!

### Abhilfe: Watchman

 * [Watchman](https://facebook.github.io/watchman/) von Facebook
   lauscht auf File-System-Events und hält einen Cache.
 * Über [Hook](https://github.com/git/git/blob/master/templates/hooks--fsmonitor-watchman.sample) in Git integrieren 
 * Erster `status`-Aufruf startet Daemon,  
   Nachfolgende nutzen den Watchman-Cache.
 

```bash
git config core.fsmonitor .git/hooks/query-watchman
``` 

================================================================
<img src="03/ueberblick-viele-dateien.png" width="90%" style="border: 0px; box-shadow: none;">

