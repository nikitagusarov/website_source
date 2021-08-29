---
title: Building a website (part 2)
author: ''
date: '2021-08-29'
slug: []
categories: [Experience]
tags: [Web, Blogdown, R, Rmarkdown]
featured_image: /images/building_website_2.png
description: ''
---



So, this post continues the sequence about building a website with `R` software. 
Today I'll make focus on the building procedure with the help of previously chosen solution: `blogdown`.

## Site generation with `blogdown`

The procedure of building website with `blogdown` may be divided into several steps: 

* Dependencies installation
* Theme choice and file-structure generation
* Building website

### Installation

As it was stated before, the `blogdown` [package](https://bookdown.org/yihui/blogdown/) uses [Hugo](https://gohugo.io/) backend to build websites. 
This means, that to make it work we should install both of them. 
Luckily, the `blogdown` package is able to install *Hugo* on its own, for this we can use the commands: 

```
# Install blogdown
install.packages("blogdown")

# Install Hugo
blogdown::install_hugo()
```

If you remember from the previous post, this build strategy is rather unstable because of the active development and changes happening in *Hugo*, *Hugo themes* and `blogdown` itself. 
This means that one may need to install a particular version of *Hugo* to make everything work correctly. 

```
# Install Hugo of version 0.85.0
blogdown::install_hugo(
    version = "0.85.0"
)
```

This is rather useful to achieve some degree of stability and we will definitely use this command later at the deployment stage as well. 
The running *Hugo* version may be checked with command:

```
# Version verification
blogdown::hugo_version()
```

### Themes and file-structure

The `blogdown` makes it possible to create entire website project folders as well. 
This means, that to create a template for editing the website, it's sufficient to run:

```
# Create website template
blogodwn::new_site()
```

The command above, should be ran in project directory by default, but it's easy to specify any other desired location using `dir` argument. 

However, the file-structure is not the only one thing we need. 
To benefit from all the *Hugo*'s functionality we may desire to configure some predefined theme. 
The list of available theme can be found on [Hugo website](https://themes.gohugo.io/), all of them are deployed over [github](https://github.com) and can be easily installed using `theme` argument. 
This website in particular is based on [ananke theme](https://github.com/theNewDynamic/gohugo-theme-ananke).
The resulting command to generate the project directory may be summarised as following:

```
blogdown::new_site(
    install_hugo = FALSE,
    theme = "theNewDynamic/gohugo-theme-ananke",
    hostname = "/",
    theme_example = FALSE,
    netlify = FALSE,
    serve = FALSE
)
```

Because we've already installed *Hugo*, we do not need to make the check again, but frankly speaking the `install_hugo = FALSE` argument only avoids the verification and is not compulsory. 
The `hostname = "/"` is used only for testing purposes when the website will be built locally for verification. 
While `theme_example = FALSE` saves us some space omitting the example that goes with the chosen theme, the `netlify` and `serve` parameters are used to control the deployment. 
Note, we will not use *netlify* for deployment, but this is the topic for future posts. 
The resulting folder structure will look somewhat like this:

```
.
├── content
├── layouts
├── R
├── static
├── themes
├── config.yaml
├── index.Rmd
└── LICENSE
```

The `content` folder serves to store all the posts and other content by default, except for static elements such as `images` or `documents`. 
For latter, it's advised to use `static` folder. 

Before ending this part, it's crucial to stress that the theme choice is very important process. 
You should be careful while choosing the theme because of the possible incompatibilities. 
To make sure everything works it's better to select a theme which:

* Has many **stars**, demonstrating that it has community approval
* Was recently **updated** and is alive
* Has a **comprehensive documentation** and support:
    - Clear **installation instructions**
    - Working **examples**
* Has low number of open issues

The last criteria may not be really important because a popular theme will obviously have more interactions around: more issues and more comments.

### Build procedure

The final stage is the *build* procedure. 
Building the website with `blogdown` means a transformation of all the source `.md` and `.Rmd` files into `.html` pages. 
The generated files are stored in separate folder to make deployment step easier and to separate the results from source files. 
It is possible to specify the output folder using the `config.yaml` file, which may be found in the project's root directory. 

```
# The files used in building process
resourceDir: resources

# The resulting website
publishDir: public
```

To keep everything in limits of one single project we specify the path inside the projects directory, but depending on the deployment strategy this setting may be changed. 
For example, another common strategy is to place the results in project's parent directory. 
If using git, it may be a good strategy to add these directories to `.gitignore` in order to synchronise only source files with the distant repositories. 

The building process itself is initiated with the command:

```
# Build webste
blogdown::build_site()
```

This command automatically compiles the `.Rmd` files to `.html` and adds all the necessary files to `publishDir: public` directory. 
Note, that without specifying `local = TRUE` argument the already compiled `.Rmd` documents will not be recompiled. 
Another option when building website locally is to run: 

```
# Build and preview site
blogdown::serve_site()
```

This command will start Hugo server, run the build routine and serve the results locally, on given `host` and `port`. 
The locally served website will be recompiled on any changes, unless another behaviour will be defined in associated `.Rprofile` file. 
It is also possible to use any other site generator, such as `jekyll` or `hexo` instead of `hugo`, but we will not use this functionality here.
After the test the server can be stopped with:

```
# Kill server
blogdown::stop_server()
```

Once everything working it is possible to switch to the deployment phase, making the website accessible to everyone. 