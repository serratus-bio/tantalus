# Tantalus

An R package for exploration of [Serratus](https://github.com/ababaian/serratus) data.

![Tantalus Mountain in Squamish, BC. Canada](img/tantalus.png)

## Installation
To install directly from the repo:

```
install.packages("devtools")
library(devtools)

install_github("serratus-bio/tantalus")
```

Note, if you install tantalus with R version <3.6.0, then you first need to install older version of pbkrtest:

```
packageurl <- "http://cran.r-project.org/src/contrib/Archive/pbkrtest/pbkrtest_0.4-7.tar.gz"
install.packages(packageurl, repos=NULL, type="source")
```