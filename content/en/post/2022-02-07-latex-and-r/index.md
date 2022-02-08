---
title: LaTeX and R
author: 'Nikita Gusarov'
date: '2022-02-07'
slug: []
categories: [Programming]
tags: [Programming, R, LaTeX, tinytex]
featured_image: '/images/tinytex-0.png'
description: ''
---



Today I've had to complete one of the course deliverables with some indications about how to compile the `.Rmd` files. 
The courses I'm giving (partially) at Grenoble INP Génie Industriel (GI) are mostly oriented for the first and second year students on the engineering track. 
This means that the level of heterogeneity in the knowledge across the groups is extreme and while some of them are more than capable to use *R* for document compilation, others encounter difficulties with this task. 

The *R* programming language usage is quite widespread in the disciplines I'm teaching (*Statistics* and *Data Analysis*). 
Most of the sessions require students to write (or at least execute) the code for demonstration purposes. 
The decision to switch over to *R* from *Excel* and spreadsheets was done long before me joining the teaching team, for the reasons of enforcing reproducible science principles right from the start. 

What is more, the *R* usage allows us to easily edit interactive documents in `.Rmd` format. 
Preparation of `.html` webpages, `.pdf` supports and presentations becomes extremely easy with `rmarkdown`, facilitating the course preparation part. 
Unfortunately, the `rmarkdown` suite is somewhat difficult to be configured for `.pdf` documents production. 
I'm going to describe the configuration procedure in this post, these contents will be reused as course materials. 



## RMarkdown

Before proceeding further we should understand what features `.Rmd` format brings us. 
The `.Rmd` support is introduced into *R* by the `rmarkdown` package, which can be installed using the command:

```
# Installation
install.packages("rmarkdown")
```

The package's features are described in the [project's website](https://rmarkdown.rstudio.com/):

> R Markdown documents are fully reproducible. 
> Use a productive notebook interface to weave together narrative text and code to produce elegantly formatted output. 
> Use multiple languages including R, Python, and SQL.
> R Markdown supports dozens of static and dynamic output formats including 
> HTML, PDF, MS Word, Beamer, HTML5 slides, Tufte-style handouts, books, dashboards, shiny applications, scientific articles, websites, and more. 

As we can see, the accent is made on: 
(1) the *reproducibility*; 
(2) the *possibility to combine code and text* and
(3) the *wide range of supported output formats*. 
All these features make such document superior to most of the alternatives. 

The reproducibility of `.Rmd` files is greater than of simple `.xlsx` sheets or a number of instructions in a text file, because there is nearly no place for the human error. 
The usage of *pseudo-random number generator* in *R* brings this reproducibility to even higher level, ensuring that even simulation tasks can be perfectly replicated on different systems. 

The combination of *code and text* in one single document is superior to direct competitors as well. 
One of the alternatives which immediately comes to mind is the `.ipynb` format of [Jupyter Notebooks](https://jupyter.org/), although it has far more limitations. 
The features are inferior: 
(1) in `.ipynb` it's impossible to use inline code in default configuration; 
(2) the *Jupyter* requires additional *Python* dependencies, which make configuration more difficult and 
(3) the supported default output formats are far more reach with `rmarkdown`. 
The last one, the `markdown` format is extremely simple to use, all the text fields in `.Rmd` files are actually `markdown` field. 
For more information about `markdown` syntax one can look at [Markdown Guide](https://www.markdownguide.org/). 
It is important to say, that depending on the desired format of the output document it is equally possible to incorporate blocks of text formatted according to the outputs standards. 
For example, if you expect to produce `.html` file, you may embed `.html` code directly into the document (the same applies to `.pdf` and LaTeX chunks).

Speaking about the *supported formats* we see the huge number of available output documents. 
PDF, HTML, MS Word, Shiny applications and many more, none of the alternatives offers so reach export options. 
But for now we'll focus on a single one of them - the `.pdf`.

## PDF

PDF or the [Portable Document Format](https://opensource.adobe.com/dc-acrobat-sdk-docs/index.html) was developed by [Adobe](https://www.adobe.com) in 1992 to present text documents in a universal manner. 
This format, based on [PostScript](https://www.adobe.com/products/postscript.html) was intended to produce identical output on any system and any hardware configuration. 
As we discover in [format's description](https://en.wikipedia.org/wiki/PDF) it has quite a number of features, which explain it's popularity:

> ... each PDF file encapsulates a complete description of a fixed-layout flat document, including the text, fonts, vector graphics, raster images and other information needed to display it. 
> ... PDF specification also provides for encryption and digital signatures, file attachments, and metadata to enable workflows requiring these features.

*Adobe* made the format available for everyone free of charge, which greatly impacted it's propagation. 
One of the first early solutions for `.pdf` generation on Linux was `groff` (`GNU troff`), which allowed to read plain text mixed with formatting commands and produces formatted output (`.pdf` or `.html`).
Another option was the well known [LaTeX](https://www.latex-project.org/) (LaTeX2e, 1994) designed for production of medium-to-large size technical or scientific documents and almost any form of publishing.

## From RMarkdown to PDF

Speaking about the conversion of `.Rmd` files to `.pdf` the procedure appears to be quite complicated. 
First of all, *R* has no means to directly compile `.Rmd` into `.pdf`. 
To support all of the different output formats *R* compiles the `.Rmd` contents into a plain markdown (`.md`) document. 
Then, using `pandoc` software the conversion towards `.tex`, `.hmtl` or `.docx` is performed. 
This means, that before anything else we should install the `pandoc` software. 
Linux users may use their package manager as `pandoc` is available in most of the repositories, for example:

```
# Debian based systems
sudo apt install pandoc
```

On Windows one will have to install the software from the [project's website](https://pandoc.org/):

```
https://github.com/jgm/pandoc/releases/latest
```

For those who use [RStudio IDE](https://www.rstudio.com/), the `pandoc` version is installed automatically alongside the IDE itself. 
One can verify it's presence with a command: 

```
# Find pandoc version and location
rmarkdown::find_pandoc()
```

What is more, it is important to understand, that `pandoc` allows only to convert `.md` to `.tex` files. 
The next step is to compile from the resulting `.tex` a final `.pdf` file. 
Obviously, in order to do so one will need a working *LaTeX* installation. 
What are the options? 
Either one can install a standalone *LaTeX* bundle, such as:  

- [MiKTeX](https://miktex.org/), oriented at Windows users mostly
- [TeX Live](https://tug.org/texlive/), one the best maintained *LeTeX* distributions
- [MacTeX](https://www.tug.org/mactex/), *MacOS* oriented distribution

Or use a dedicated *R* oriented *LaTeX* distribution. 
This one goes under the name of [TinyTeX](https://tug.org/TUGboat/Contents/contents40-1.html), provided by `tinytex` package. 
For installation one should install `tinytex` package first, and then run bundled installer:

```
# Install package
install.packages("tinytex")

# Install LaTeX distribution
tinytex::install_tinytex()
```

Then it remains to ensure the runtime is in `PATH`. 
There are several advantages to this second option, as described in [documentation](https://bookdown.org/yihui/rmarkdown-cookbook/install-latex.html): 

- TinyTeX is lightweight (compared to other LaTeX distributions), cross-platform, and portable
- If certain LaTeX packages are required but not installed, `tinytex` will try to automatically install them for you

The next step is the creation of an `.Rmd` document itself. 
Such document is divided into two main parts: 
(1) the `yaml` header, where rendering parameters and session info is declared, and 
(2) the main body of the document, where the text and code blocks are stored. 
An example of `yaml` specification to produce a `.pdf` document is:

```
---
title: "Test document"
output: 
  pdf_document
---
```

Supplementary parameters may be declared in the header and may be divided into two groups: 
(1) those unique for all documents classes, and 
(2) those that are specific for particular document types. 
For example:

```
---
title: "Test document"
author: "Tester"
output: 
  pdf_document:
    fig_width: 6
    fig_height: 3
    keep_tex: false
---
```

Then we may add some text in `markdown` format:

```
---
title: "Test document"
author: "Tester"
output: 
  pdf_document:
    fig_width: 6
    fig_height: 3
    keep_tex: false
---

# Header 1

Some text of the first paragraph.
```

And a chunk of *R* code to be calculated:

````
---
title: "Test document"
author: "Tester"
output: 
  pdf_document:
    fig_width: 6
    fig_height: 3
    keep_tex: false
---

# Header 1

Some text of the first paragraph.

```{r}
x = 10 + 1
```
````

Finally, to compile a document one will have to run the following command in *R*:

```
# Render document from R session
rmarkdown::render("path/to/document.Rmd")
```

It's equally possible to render a document directly from a terminal, without starting a new *R* session. 
This may be extremely useful, if you are writing a new `.Rmd`, which does not need testing:

```
# Render document from command line
Rscript -e 'rmarkdown::render("path/to/document.Rmd")'
```

Alternatively, you can simply use `knit` button available in *RStudio IDE*. 