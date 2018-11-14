

# Viele Bytes!


================================================================

## Preisfrage


Dieses hervoragende Buch hat ca. 20.000 Zeilen und 270.000 Byte Quelltext (ohne Bilder).
  
<img src="04/git-buch.png" width="20%" style="border: 0px;"/>

Wieviel Gramm wiegt es?


notes:

Das Buch wiegt (ohne Werbezettel) exakt 615 g


================================================================
<!-- .slide: data-background-image="04/michel.png" -->



|            | Buch-Repo      | Linux Kernel  | Windows Repo  |
|------------|----------------|---------------|---------------|
| Bücher     | 1              | 8.000         | 1,1 Mio.      | 
| Gewicht    | 0,615 kg       | 5.000 kg      | 700.000 kg    | 
| Höhe       | 0,02 m         | 150 m         | 20.000 m      |
| Speicher   | 0,27 MB        | 2,4 GB        | 300 GB        | 


notes:

Linux-Kernel als Bücherstapel: 

Anmerkung: Kernel und Windows Repos enthalten auch Binaries, die wir nicht rausgerechnet haben.


================================================================


## Viele Bytes - Probleme

 * **langsamer Transfer**  
   `clone` langsam  
   Bottleneck ist meist das Netz.  
   Platten sind schnell und billig.

 * **Big Binaries**  
   `fetch`, `checkout` langsam

notes: 

- Typsiches Problem: 
  Build-Server muss lange auf clone warten 
  
- Oft sind es die großen Binärdateien die Ursache
  Dann sind `fetch` und `checkout` auch langsam.

================================================================

#### Viele Bytes - langsamer Transfer

### Abhilfe: Shallow Clone
 
 ```bash
 git clone --depth 1 <linux-url>
 git fetch --deepen 100
 ```
* Weniger Commits holen

<br/>

| Linux-Kernel | `depth=1`   | `depth=100`  | Voll     | 
|--------------|-----------|------------|----------|
|              | 200 MB    | 900 MB     | 2.400 MB |  

notes:

Deepen 100: 885MB (125.000 Commits)

TODO Umgang mit Merge-Parents

================================================================

#### Viele Bytes - langsamer Transfer

### Breaking News: Partial Clone
 
 <br/>
 ```bash
 git -c protocol.version=2 clone --filter=blob:100k <linux-url>
 ```

 <br/>

* Weniger Blobs holen
* __Klappt noch nicht mit GitHub / GitLab__

================================================================


#### Viele Bytes - langsamer Transfer

### Abhilfe: Worktree


 ```bash
 git worktree add ../workspace2 feature-a
 ```

 * Mehrere Workspace auf geteiltem Repo.
 * Nur ein *Object Store* für alle Worktrees
 * Fetch ist nur einmal notwendig.
 

================================================================


#### Viele Bytes - langsamer Transfer

### Abhilfe: Klonen mit Referenz-Repo

  ```bash
 git clone --reference <local-repo-url> <repo-url>
 ```
 
 * Objekt aus dem Referenz-Repo  
   müssen nicht übertragen werden
 * Für Build-Server,  
   der mit frischem Klon anfangen soll


================================================================


#### Viele Bytes - Big Binaries

### Abhilfe: Git LFS (Large File System)

<img src="04/abb-lfs-ueberblick.png" width="40%" style="border: 0px; box-shadow: none;">


notes:

Hilft zwar, ist aber nicht ohne Tücken.

(Mercurial nennt das ein "Feature of last Resort")


================================================================


#### Viele Bytes - Big Binaries

### Abhilfe: Große Dateien ablehnen

```bash
git rev-list --objects ${oldref}..${newref} |
  git cat-file | 
      --batch-check='%(objectname) %(objecttype) %(objectsize) %(rest)' |
  awk -v maxbytes="$maxbytes" '$3 > maxbytes { print $4 }'
 ```
 * [`pre-receive`-Hook](https://github.com/amacneil/git-banish-large-files) lehnt Commits mit großen Dateien ab



================================================================


#### Viele Bytes - Big Binaries

### Abhilfe: Mit BFG Dateien entfernen

 <img src="04/BFG.png" width="50%">
 

```bash
java -jar bfg.jar --strip-blobs-bigger-than 100M repo.git
 ```


notes:
 
Hinweis:

(Fast) Alle Commits werden neu erstellt und bekommen neue Hashes.

Deshalb:

 1. Mit BFG Neues Repo erstellen
 2. Altes Repo deaktivieren (read-only)
 3. Alle Projektmitglieder zum neu Klonen auffordern.


================================================================

<img src="04/ueberblick-viele-bytes.png" width="90%" style="border: 0px; box-shadow: none;">
