<!-- .slide: data-background-image="03/viele-dateien.png" -->

## Viele Dateien!<br/><br/><br/>


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

Filtern, welche Dateien\
in den Workspace geholt werden.

 * `git clone` mit  `--sparse` \
   [aktiviert Sparse Checkout](https://git-scm.com/docs/git-clone#Documentation/git-clone.txt---sparse)
 * `git sparse-checkout add/list/set/...` \
   [bearbeitet](https://git-scm.com/docs/git-sparse-checkout) die [Konfiguration](https://git-scm.com/docs/git-sparse-checkout#_sparse_checkout) in \
   `$GIT_DIR/info/sparse-checkout`.


================================================================


#### Viele Dateien - `checkout` langsam!

### Abhilfe: Sparse Checkout

```bash
# Sparse Checkout einrichten
git clone --sparse repo myclone
cd myclone
git sparse-checkout init --cone
git sparse-checkout add component-a
git checkout

# Sparse Checkout abschalten
git sparse-checkout disable
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


================================================================

### &#8669; Bjørn
