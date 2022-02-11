---
title: Creating packages with R
author: 'Nikita Gusarov'
date: '2022-02-09'
slug: []
categories: [Programming]
tags: [Programming R, Packages, devtools]
featured_image: '/images/devtools-0.png'
description: ''
---



Some days ago I've started to revise the code of one particular *R* package I'm using in my thesis work. 
This is a particular package developed by our team and implemented by one of my friends - [Antoine Dubois](https://github.com/AntoineDubois/). 
The main idea behind the implemented toolset is the simulation of individual behaviour under the most popular behavioural models. 
The final product should simplify the model pen-testing and performance evaluation tasks for economists and experimentalists. 

All this has lead me to revise the tools that exist in *R* to work with packages: their creation, management, maintenance, etc. 
And consequently, the contents of today's post will be consecrated to the creation of *R* packages. 
I believe this little initiative will result in more than one single post, as I'll continue to explore the topic. 



## The toolset 

I already have one post dedicated to [Git](https://git-scm.com/) and project management, so I'll avoid focusing on this part of package maintenance here. 
What interests us for now is the *R* toolset for package creation, which some may already know: [`devtools`](https://devtools.r-lib.org/). 
Maintained by the same team as the famous `tidyverse`, `devtools` is another meta-package regrouping all the necessary tools for package creation. 
The current version includes:

- `roxygen2`, for automatic documentation management
- `remotes`, enabling package installation from *GitHub*
- `pkgbuild`, for building binary packages
- `usethis`, for automated package setup and testing
- `sessioninfo`, allowing to gather information about running *R* session
- `revdepcheck`, for *R* CMD checks of the dependencies

It brings quite a lot of utilities for testing and deploying packages as well:

- `testthat`, for writing and running tests
- `pkgload`, to simulate package loading and installation
- `rcmdcheck`, allowing to run *R* CMD check and reporting results

As you can see, there is nearly everything one may ever need to deploy a development environment. 
Because the `devtools` suite is developed and maintained by the same team as the [RStudio IDE](https://www.rstudio.com/)^[
Meaning [Hadley Wickham](https://hadley.nz/), [Jim Hester](https://www.jimhester.com/), [Winston Chang](https://github.com/wch) and [Jennifer Bryan](https://jennybryan.org/)
] 
it shines when coupled with this particular IDE. 

Among external tools; I may name:

- `available`, which allows to check the package name validity and availability (it can even generate package names from titles!)
- `lintr`, to analyse the code
- `styler`, to modify the code layout, typesetting and make it more user friendly
- `goodpractice`, which automatically analyses the package and provides advices about syntax, data structures, code complexity, etc.
- `pkgdown`, for easy website setup for your package and distribution simplification

Finally, there are some good practices to adopt before (and while) package creation. 
Usually it starts with consideration of whether the intended package should even exist and ending with [Continuous Integration](https://juliasilge.com/blog/beginners-guide-to-travis/) (CI). 
There exists and [extremely good blogpost](https://juliasilge.com/blog/beginners-guide-to-travis/) about the main considerations to make while creating a package.

## *R* and package creation

First we need to install all the required dependencies. 
As said before, `devtools` is a  meta-package, so it remains to run:

```
# Install devtools from CRAN
install.packages("devtools")
```

One of the most interesting functions at this stage is probably the `package.skeleton()`, which creates a structure for a new package. 
For example: 

```
# Create function
my_function = function() {cat("\nHello world!\n")}

# Create package
package.skeleton(
    name = "mypackage",
    list = "my_function",
    path = "packages",
    encoding = "UTF-8"
)
```

This sequence will create a package architecture under `./packages/package_name` path, containing `my_function()` function. 
The function inside package will print `Hello world!` when called. 
So what includes such "*package structure*"? 
Here is a short list of the most indispensable elements:

- `DESCRIPTION` file, which contains basic information about the package (ex: title, authors, etc.)
- `LICENCE` file, containing the licence agreement (ex: GPL-2, GPL-3, MIT, etc.), one may look [here](https://www.r-project.org/Licenses/) for examples
- `NAMESPACE` 
- `R` subdirectory containing `.R` source files
- `man` directory (even though suggested it may produce some conflicts as described [here](https://cran.r-project.org/doc/manuals/r-release/R-exts.html#Package-subdirectories))

One may want to add some of the following as well:

- `README` (`.md`) in case the package is hosted on *GitHub* or similar structure
- `data` directory for data files
- `src` directory for code files that require compilation (`C`, `C++`, etc.)
- `exec` directory including scripts for interpreted languages (`Python`, `MatLab`, `Perl`, etc.) and shell commands (alternatively an `inst` directory may be used for same purposes)
- `Makevars` file, which is a makefile commonly used to set preprocessor options for compiled languages

And alternative to `package.skeleton()` is the `create()` functions, which performs the same steps with exclusion of automated contents preload. 
In this case, the functions may be added by hand. 
As you can see, the package creation is rather simple, but there remains a huge amount of various tips, tricks and supplementary functionalities one may need to create his / her project. 