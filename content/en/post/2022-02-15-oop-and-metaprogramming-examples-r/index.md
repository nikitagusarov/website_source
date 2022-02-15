---
title: OOP and Metaprogramming examples (R)
author: 'Nikita Gusarov'
date: '2022-02-15'
slug: []
categories: [Programming]
tags: [Programming, Metaprogramming, OOP, R, Packages]
featured_image: '/images/oop-meta-0.png'
description: ''
---



Today there'll be no big theoretical posts about the advanced *R*. 
However, as I don't want to drop my new habit to write a post per day, I'll publish at least something. 

Here I'll gather some useful tricks I've discovered while rebuilding the simulation package. 



## A short introduction to my current work

From my previous posts you probably already know that now I'm revising the custom simulation package, which is used in my thesis. 
The intermediate objective is to have a toolset for *Discrete Choice Experiments* (DCE) simulation. 
Then, this tool will be used for DCE pentesting, performance evaluation and model selection tasks in DCE context. 
But here we'll focus on the *R* programming and the simulation package architecture. 
The two previous revisions had their drawbacks. 

The first one was extremely use-case specific and was restricted by the inbuilt presents. 
It worked perfectly well for the experience we were building at the moment. 
However, the functional programming paradigm lying at its base made it absolutely non-extensible. 

The other one was more general, but still lacked some of the expected modularity. 
It implemented the OOP based approach (built around *R5* programming system), putting the concept of *experiment* at the centre. 
This feature made it more convenient to use, offering at least some flexibility. 
Some of the limitations were removed, although it brought forward some new conceptual flaws. 

## Some interesting features

The decision was made to rework some of the package's parts and extend the OOP system over to the smallest elements. 
Among them: reinterpret *individuals* as objects to simplify further modifications. 

As you may know, if you work with the *Discrete Choice Modelling* (DCM), the choice situations typically involve two counterparts:
(1) individuals, defined through their characteristics and 
(2) a set of available alternatives defined by their attributes. 
Consequently, the idea in creation of *individual* class is to make a modifiable object containing the characteristics description. 
The characteristics should be defined by some sort of label, giving intuition about their interpretation. 
At the same time they should contain information about their distributions - the laws to generate the values later. 

Here we approach the most interesting part. 
We would like to have syntax similar to:

```{r}
# Desired behaviour
individual$add_characteristic(
    Age = rnorm(mean = 35, sd = 5)
)
```

This means, that we should be able to store this information *on the fly*. 
Putting it in other terms: we should dynamically create internal elements for our object.
This can be achieved through using the following function (available in `base` *R*):

```{r}
match.call()
```

It returns a `call` object in which all of the specified arguments are specified by their full names.
The results could be parsed into a list with:

```{r}
as.list()
```

Here is a simplified code, where we create a new `R6` object:

```{r}
individual = R6::R6Class(
    # Class name
    "individual",
    # Architecture
    list(
        # Values
        characteristics = NULL,

        # Methods
        add_characteristics = function(...) {
            # Convert to call to avoid interpretation in place
            self$characteristics = c(
                self$characteristics,
                as.list(match.call())[-1]
            )
            invisible(self)
        }
    )
)
```