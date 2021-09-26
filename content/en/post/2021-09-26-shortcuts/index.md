---
title: Shortcuts in Vim style
author: 'Nikita Gusarov'
date: '2021-09-26'
slug: []
categories: [Experience]
tags: [Information, Workflow, Tips]
featured_image: /images/shortcuts.png
description: ''
---



Some whhile ago I had an interesting discussion concerning the different approaches to workflow organisation and learning. 
It happened around at the same time, that I've discovered the [*Vimium*](https://vimium.github.io/) browser extension. 
This coinsidence lead me to write this blogpost about the workflow organisation and usage of shortcuts in everyday life. 
To keep the content simple, I'll start with some general ideas on using shortcuts and then present some advantages of using their *Vim-style* version. 



## Workflow organisation and shortcuts

I believe that anyone reading this post uses the shortcuts in his/her daily tasks. 
Just imagine leaving without the sacred `Ctrl + C` and `Ctrl + V` key combinations, it would be a total nightmare! 
But what's about something less common? 

In the times when visual oriented workflow is nearly omnipresent and more and more applications use pointing devices for interactions, casual users don't even imagine that there might be some comfortable ways to interact with the machine. 
What might be more simple than clicking with your mouse or fancy glass touchpad? 
But there is one sing: the **keyboard**. 
Just give a though about why you still use such combinations as `Ctrl + C` and `Ctrl + V` if the mouse is so comfortable? 
The main reason is the time saving and efficiency of such input method: 

- No need to aim the pointing device at multiple targets
- No need to switch between input devices

Consequently, the more proficient shortcut user may not even need to move the hands away from the keyboard. 
Using a laptop with trackpad or a keyboard with integrated ultranav device (ex: a *trackpoint*) makes it even easier to avoid unnessessary movements. 

However, there are some drawbacks in using shortcuts: 

1. Different language layouts assume different key mapping, and consequently a different shortcut mapping. 
For example, using russian layout alongside french one is rather confusing because of the `w` and `z` keys placement. 

2. Differences in keyboard design may play their role as well. 
Switching between full-sized and laptop keyboards may already be difficult, more so when the laptop has a proprietary layout like Apple's *MacBooks* or Lenovo's *ThinkPads*.

3. Although some established shortcut conventions exist, there are always some minor differences in default shortcuts between the operation systems and software.

It's on this point that we switch our attention to *Vim*



## What is Vim?

Because my blog is not oriented at some particular audithory, I believe some of you may never have heard about [Vi](http://ex-vi.sourceforge.net/) or [Vim](https://www.vim.org/) (which stands for *Vi IMproved*). 
There exist some other forks and reimplementations of *Vim* like [Neovim](https://neovim.io/), for example, but this is not that important. 
The key idea here is that *Vim* is tiny, simple and yet very powerfull text editor, with a very specific workflow. 

Nowadays, a vast majority of software focuses on visual mode functionnality and most of the shortcuts must be called by a specific control key (usually `Ctrl`, `Win` or `Alt`). 
This greatly limits the usability of some patterns, making it impossible to call some of the commands with single hand. 

But *Vim* completely bypasses such limitations through introduction of various *modes* (command and insert modes, in original *Vim* text editor).
The main idea of proposing several functionnal modes, among which one may navigate with single-key commands makes it astounishingly handy to use. 
Consequently, this approach allows to use character keys to input commands and remap some of the inconvenient combinations: for example, remapping directional arrows to `h`, `j`, `k` and `l` keys. 
Just imagine, navigation without moving your hand away from printing position! 
For some more insight into *vi* editing one may see the '[Why, oh WHY, do those #?@! nutheads use vi?](http://www.viemu.com/a-why-vi-vim.html)' post. 



## And what's about casual users?

I strongly doubt that anyone, who's use to working with *Word* and *Notepad* will switch to using *Vim* for everyday tasks. 
So what's the point of introducing this *strange* text editing software? 
Every community attempts to expand its ideas and *Vim* is not an exception. 
There exist *vim* modules introducing *vim-style* navigation to many software and here is a short list of examples: 

- [VibreOffice](https://github.com/seanyeh/vibreoffice) a LibreOffice and OpenOffice extension
- [Vimium](https://vimium.github.io/) for [Chromium based](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb) or [Firefox](https://addons.mozilla.org/en-US/firefox/addon/vimium-ff/), effectively there exist many other similar extensions
- [VSCodeVim](https://github.com/VSCodeVim/Vim) Vim emulator for Visual Studio Code (or VS Codium)
- [RStudio](https://www.rstudio.com/) has inbuilt support for *Vim* mode

Speaking about the non-free software, we may list:

- [Docs-Vim](https://github.com/matthewsot/docs-vim) bringing *vim-like* editing mode to *Google docs*
- [ViEmu](http://www.viemu.com/viemu-vi-vim-word-outlook.html) bringing *vi-vim* for MS Office

Evidently, I'm unable to list every solution for every use-case possible, but there definitely exists one for every software popular enough. 