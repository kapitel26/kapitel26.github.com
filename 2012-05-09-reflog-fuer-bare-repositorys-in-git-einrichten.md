---
layout: post
title: "Reflog für Bare Repositorys in Git einrichten"
description: ""
category: 
tags: []
---
{% include JB/setup %}

Bare-Repositorys richtig konfigurieren    <a id="configure-reflog"/>
--------------------------------------

	git clone --bare --config core.logAllRefUpdates=true ~/work/kapitel26/	

Außerdem
--------
 
git config --system receive.denyNonFastForwards true

Sonstiges
---------

core.logAllRefUpdates
           Enable the reflog. Updates to a ref <ref> is logged to the file "$GIT_DIR/logs/<ref>", by appending the new and old SHA1,
           the date/time and the reason of the update, but only when the file exists. If this configuration variable is set to true,
           missing "$GIT_DIR/logs/<ref>" file is automatically created for branch heads (i.e. under refs/heads/), remote refs (i.e.
           under refs/remotes/), note refs (i.e. under refs/notes/), and the symbolic ref HEAD.

           This information can be used to determine what commit was the tip of a branch "2 days ago".

           This value is true by default in a repository that has a working directory associated with it, and false by default in a
           bare repository.


       gc.pruneexpire
           When git gc is run, it will call prune --expire 2.weeks.ago. Override the grace period with this config variable. The value
           "now" may be used to disable this grace period and always prune unreachable objects immediately.
           
           -> ist default

       gc.reflogexpire, gc.<pattern>.reflogexpire

           git reflog expire removes reflog entries older than this time; defaults to 90 days. With "<pattern>" (e.g. "refs/stash") in
           the middle the setting applies only to the refs that match the <pattern>.

       gc.reflogexpireunreachable, gc.<ref>.reflogexpireunreachable

           git reflog expire removes reflog entries older than this time and are not reachable from the current tip; defaults to 30
           days. With "<pattern>" (e.g. "refs/stash") in the middle, the setting applies only to the refs that match the <pattern>.





Links
-----

  [1]: http://stackoverflow.com/questions/3876206/how-do-i-view-a-git-repos-recieve-history
  [2]: http://stackoverflow.com/questions/6140083/how-to-create-reflogs-information-in-an-existing-bare-repository
