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