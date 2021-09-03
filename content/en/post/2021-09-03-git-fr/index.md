---
title: Guide des outils
author: 'Nikita Gusarov'
date: '2021-09-03'
slug: []
categories: [Guide, Workflow]
tags: [Git, LaTeX, Markdown, Rmarkdown, French]
featured_image: /images/gricad_gitlab.png
description: ''
---



Cette publication est orienté vers les étudiants qui vont suivre des cours ou faire de *Projets* / mener des *TER* avec moi cette année. 
Elle vise à proposer un aperçu des outils essentiels pour faciliter et simplifier le travail. 
Particulièrement :

- Git
- GitHub/GitLab/BitBucket (ici nous parlerons du GitLab hebergé par [GRICAD](ttps://gricad.univ-grenoble-alpes.fr))
- LaTeX
- Markdown
- RMarkdown

Ce sont des outils principaux pour bien organiser son travail de la recherche et pouvoir l'accompagner par des supports numeriques. 

## Git

[**Git**](https://git-scm.com/) est un des outils de contrôle des versions ([SVN](https://subversion.apache.org/), [Mercurial-SCM](https://www.mercurial-scm.org/)), lequel permet de facilement contrôler les changements et modifications dans des documents textes. 
Il faut noter, que cet outil n'est pas pratique que pour le travail avec les documents texte simples: il reste absolument impratique pour le travail avec les documents office (Word, Excel, etc). 
Plusieurs éditeurs de texte pour les développeurs ([RStudio](https://rstudio.com/), [VSCode](https://code.visualstudio.com/), [Atom](https://atom.io/), etc.) offrent des possibilités pour intégrer *git* directement dans l'éditeur.
Cela permet d'interagir avec *git* avec beaucoup plus d'aise que à travers la ligne de commande ou un client *git* à part.

Après installation il est obligatoire à créer son identifiant (sa signature pour les *commits*).
Cette signature comprend l'identifiant d'utilisateur (*user.name*) et son email (il vaut mieux qu'ils correspondent au identifiants utilisés sur *GitHub*).
Les commandes sont suivantes :

```
git config --global user.name "Name"
git config --global user.email "mail@mail.com"
```

Sans cela il sera impossible d'utiliser la fonctionnalité du *git*.

Pour initier *git* dans un dossier de travail il suffit d'utiliser la ligne de commande (quand même il existent des méthodes plus simples avec les fonctionnalités de *GitHub* et les outils intégrés des éditeurs) :

```
cd "PATH_to_project"
git init
```

## GitLab (Gricad-GitLab)

[**GitLab**](https://gitlab.com/) à son tour est une plateforme coopérative proposée comme une alternative à plateforme [**GitHub**](https://github.com/) développée par [**Microsoft**](https://news.microsoft.com/announcement/microsoft-acquires-github/) facilitant le travail avec le service de contrôle des versions *git*. 

Nous allons utiliser sa version offerte par le centre de calcul universitaire [GRICAD](https://gricad.univ-grenoble-alpes.fr) - [**Gricad-GitLab**](https://gricad-gitlab.univ-grenoble-alpes.fr)
Cette plateforme offre à la fois :

- Un espace cloud pour héberger les dossiers de travail et publier les résultats
- Un interface web (et desktop, si besoin) pour interagir avec *git* 
- Une plateforme facilitant la collaboration avec les autres utilisateurs
- Une système de gestion des projets intégrée

En ce qui concerne les alternatives de *git* il existent également des plateformes similaires ([Google Code](https://code.google.com/) pour *SVN*).

Pour utiliser *Gricad-GitLab* il faut [se connecter à la plateforme en utilisant ses identifiants AGALAN](https://gricad-gitlab.univ-grenoble-alpes.fr).
On peut ensuite lier les *repos* distantes à des projets locales.
La façon la plus simple à le faire est de créer (ou trouver un *repo* existant) et le *cloner* ensuite sur une machine locale avec *git clone* (il suffit de connaitre l'adresse *url* du *repo*).
Dans le cas d'utilisation du *git* à partir de la ligne de commande :

```
git clone [url]
git clone https://gricad-gitlab.univ-grenoble-alpes.fr/name/repo.git
```

Autres actions étant au cœur du *git* sont :

1. *Pull* permet de synchroniser le dossier de travail avec le *repo* distant :

```
git pull [url]
```

2. *Commit* qui sert d'enregistrer les différences entre l'état actuel du dossier de travail et le dernier état sauvegardé (commande exécuté dans le dossier de travail avec *.git*) :

```
git commit -m "[Commentaire]"
```

3. *Push* permet d'envoyer les changements dans le dossier de travail vers le *repo* distant :

```
git push [source] [branche]
git push origin master
```

Toutes ces commandes d'habitude sont intégré dans l'éditeur, ce qui évite l'interaction avec la ligne des commandes.
Pour plus d'information sur la fonctionnalité du *git* on peut voir [ici](https://git-scm.com/docs/gittutorial) et [ici](https://guides.github.com/) pour *GitHub* ou [ici](https://docs.gricad-pages.univ-grenoble-alpes.fr/help/) pour *Gricad-GitLab*.

En ce qui concerne l'intégration du *git* dans les GUI des différents éditeurs voici les guides :

- [RStudio](https://support.rstudio.com/hc/en-us/articles/200532077-Version-Control-with-Git-and-SVN)
- [VSCode](https://code.visualstudio.com/docs/editor/versioncontrol)
- [Atom](https://flight-manual.atom.io/using-atom/sections/version-control-in-atom/)

## LaTeX

[**LaTeX**](https://www.latex-project.org/) est un langage de markup complet.
Il existe plusieurs distributions de LaTeX, une des versions vérifiées à bien s'intégrer avec [R](https://cran.r-project.org/) est [MikTeX](https://miktex.org/).
Pour profiter de la fonctionnalité complète de *LaTeX* il faut également installer une distribution de [Perl](https://www.perl.org/get.html) (*Strawberry Perl* est la plus compacte pour *Windows*).

## Markdown

[**Markdown**](https://www.markdownguide.org/) est un langage de markup simplifié, permettant de transformer des documents avec un syntaxe simple vers des documents PDF, HTML et Word à laide du convertisseur [pandoc](https://pandoc.org/).
Il faudra donc installer *pandoc* séparément (sauf si on n'utilise le *RStudio*).

Les essentiels du syntaxe de *Markdown* se trouvent [ici](https://www.markdownguide.org/basic-syntax/) ou [ici](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet).

## RMarkdown 

[**RMarkdown**](https://rmarkdown.rstudio.com/) est une extension pour *Markdown*, laquelle y intègre la langue *R*.
Il existent des outils similaires pour des autres langues: [PMarkdown](https://python-markdown.github.io/) pour [Python](https://www.python.org/) ou [JMarkdonw](https://docs.julialang.org/en/v1/stdlib/Markdown/) pour [Julia](https://docs.julialang.org/en/v1/).

Afin de pouvoir compiler les rapports il existent des dépendances :

- HTML exige *pandoc* (lequel vient préinstallé avec *RStudio*)
- PDF exige *pandoc* et *LaTeX* (le plus simple à intégrer est le *MikTeX*)
- Word exige *pandoc* et *LaTeX* (*à vérifier*)

De plus, en fonction du format de sortie on peut utiliser les éléments spécifiques.
Par exemple, si on génère un document PDF, on peut utiliser les commandes *LaTeX* (également, pour créer un document HTML on peut intégrer les éléments *html* dans le texte).
