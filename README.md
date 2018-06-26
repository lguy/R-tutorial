# R workshop

D7:3 retreat, Noors slott, 2018-08-30

## Rationale

Data acquisition is getting faster. Amount of data is increasing. You still have only two eyes and one brain. Ergo, we need better tools to represent complex data.

R is a tool of choice to ensure stable, reproducible, understandable, easily modifiable data representation.

## Goal 

R comes with a relatively high initial threshold. The goal of this three-hour workshop is to get over this initial workshop, and learn how to set it up, get it running, understand the basic concepts, and know where to look for help. 

As an example, you'll load your own data into R and produce a beautiful figure with it.

## Steps

1. Install R & Rstudio
1. First steps into R
1. Loading your own data
1. Your first figure

## Installing software

To start programming with R on your computer, you need two things: R and RStudio (actually only R, but RStudio makes the experience more enjoyable).

For your convenience, the required files are available on a USB stick during the workshop.

### Install R

To download R, go to [CRAN](https://cloud.r-project.org/) (the comprehensive R archive network). Choose your system and select the latest version to install.

### Install RStudio

You also can use a hefty tool to write and compile R codes. And RStudio is the most robust and popular IDE (integrated development environment) for R programming. [Download from RStudio](http://www.rstudio.com/download) (open source and for free).

---

## First RStudio session

### New RStudio project

* Start RStudio.
* Under the File menu, click on New project, choose New directory, then New project.
* Enter a name for this new folder, and choose a convenient location for it. This will be your working directory for the rest of the day (e.g., `~/RWorkshop`)
* Click on “Create project”
* Create a new R script (File > New File > R script) and save it in your working directory (e.g. introR.R)

### RStudio environment

Your RStudio environment is divided in several areas:
![rstudio_areas](assets/rstudio_areas.png)

* *Script*: this is your source code, all the commands that allow you to produce the figures. Code should be mainly evaluated from here.
* *Console*: this is where you can try commands before storing them in the script, show values, debug functions, etc.
* *Environment*: this is where your files are stored in your file system.
* *Output*: where figures or files produced by the script/console are shown.

### Folders

You separate the original data (raw data) from intermediate datasets that you may create for the need of a particular analysis. For instance, you may want to create a `data/` directory within your working directory that stores the raw data, and have a `data_output/` directory for intermediate datasets and a `figure_output/` directory for the plots you will generate.

Create the following folders in the "Files" tab in the Output area:

* `data/`
* `data_output/`
* `figure_output/`

---

## Creating objects

Creating objects
Let’s start by creating a simple object:

```
x <- 10
x
```

We assigned to `x` the number 10. `<-` is the assignment operator. Assigns values on the right to objects on the left. Mostly similar to `=` but not always. Learn to use `<-` as it is good programming practice. Using `=` in place of `<-` can lead to issues down the line.

`=` should only be used to specify the values of arguments in functions for instance `read.csv(file="data/some_data.csv")`.

We can now manipulate this value to do things with it. For instance:

```
x * 2
x + 5
x + x
```

or we can create new objects using `x`:

```
y <- x + x + 5
```

Let’s try something different:

```
x <- c(2, 4, 6)
x
```

Two things:

* we overwrote the content of `x`
* `x` now contains 3 elements

Using the `[]`, we can access individual elements of this object:

```
x[1]
x[2]
x[3]
```

#### Challenge

What is the content of this vector?

```
q <- c(x, x, 5)
```

We can also use these objects with functions, for instance to compute the mean and the standard deviation:

```
mean(x)
sd(d)
```

This is useful to print the value of the mean or the standard deviation, but we can also save these values in their own variables:

```
mean_x <- mean(x)
mean_x
```

### Working with stored data

The function `data()` allows you to load into memory datasets that are provided as examples with R (or some packages). Let’s load the Nile dataset that provides the annual flow of the river Nile between 1871 and 1970.

```
data(Nile)
```

Using ls() shows you that the function `data()` made the variable Nile available to you.

Let’s make an histogram of the values of the flows:

```
hist(Nile)
```

#### Challenge

The following: `abline(v=100, col="red")` would draw a vertical line on an existing plot at the value 100, colored in red.

How would you add such a line to our histogram to show where the mean falls in this distribution?

We can now save this plot in its own file:

```
pdf(file="figure_output/nile_flow.pdf")
hist(Nile)
abline(v=mean(Nile), col="red")
dev.off()
```

Note that we saved the figure `nile_flow.pdf` in the `figure_output` folder. We 

---

## Vectors

Vectors are at the heart of how data are stored into R’s memory. Almost everything in R is stored as a vector. When we typed `x <- 10` we created a vector of length 1. When we typed `x <- c(2, 4, 6)` we created a vector of length 3. These vectors are of class `numeric`. Vectors can be of 6 different classes (we’ll mostly work with 4).

### The different "classes" of vector

* "`numeric`" is the general class for vectors that hold numbers (e.g., `c(1, 5, 10)`)
* "`integer`" is the class for vectors for integers. To differentiate them from numeric we must add an L afterwards (e.g., `c(1L, 2L, 5L)`)
* "`character`" is the general class for vectors that hold text strings (e.g., `c("blue", "red", "black")`)
* "`logical`" for holding `TRUE` and `FALSE` (boolean data type)

The other types of vectors are "complex" (for complex numbers) and "raw" a special internal type that is not of use for the majority of users.

### How to create vectors?

The easiest way is to create them directly as we have done before:

```
x <- c(5, 10, 15, 20, 25)
class(x)
``

However, there will be cases when we want to create empty vectors that will be later populated with values.

``
x <- numeric(5)
x
```

Similarly, we can create empty vectors of class `character` using `character(5)`, or of class `logical`: `logical(5)`, etc.

### Naming the elements of a vector

```
fav_colors <- c("red", "blue", "green", "yellow")
names(fav_colors)
names(fav_colors) <- c("John", "Lucy", "Greg", "Sarah")
fav_colors
names(fav_colors)
unname(fav_colors)
```

### How to access elements of a vector?

They can be accessed by their indices:

```
fav_colors[2]
fav_colors[2:4]
```

Repetitions are allowed:

```
fav_colors[c(2,3,2,4,1,2)]
```

or if the vector is named, it can be accessed by the names of the elements:

```
fav_colors["John"]
```

#### Challenges

* How to access the content of the vector for "Lucy", "Sarah" and "John" (in this order)?
* How to get the name of the second person?

### How to update/replace the value of a vector?

``` 
x[4] <- 22
fav_colors["Sarah"] <- "turquoise"
```

### How to add elements to a vector?

```
x <- c(5, 10, 15, 20)
x <- c(x, 25) # adding at the end
x <- c(0, x)  # adding at the beginning
x
```

With named vectors:

```
fav_colors
c(fav_colors, "purple")
fav_colors <- c(fav_colors, "Tracy" = "purple")
```

Notes:

* here is the case where using the = is OK/needed
* pay attention to where the quotes are

#### Challenge

If we add another element to our vector:

```
fav_color <- c(fav_colors, "black")
```

How to use the function `names()` to assign the name "Ana" to this last element?

### How to remove elements from a vector?

```
x[-5]
x[-c(1, 3, 5)]
```

but this: `fav_colors[-c("Tracy")]` does not work. We need to use the function match():

```
fav_colors[-match("Tracy", names(fav_colors))]
```

The function `match()` looks for the position of the first exact match within another vector.

### Sequences

`:` is a special function that creates numeric vectors of integer in increasing or decreasing order, test 1:10 and 10:1 for instance. The function `seq()` (for *seq*uence) can be used to create more complex patterns:

```
seq(1, 10, by=2)
## [1] 1 3 5 7 9
seq(5, 10, length.out=3)
## [1]  5.0  7.5 10.0
seq(50, by=5, length.out=10)
##  [1] 50 55 60 65 70 75 80 85 90 95
seq(1, 8, by=3) # sequence stops to stay below upper limit
## [1] 1 4 7
seq(1.1, 2, length.out=10)
##  [1] 1.1 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0
Repeating
x <- rep(8, 4)
x
rep(1:3, 3)
```

Operations on vectors

```
x <- c(5, 10, 15)
x + 10
x + c(10, 15, 20)
x * 10
x * c(2, 4, 3)
```

Note that operations on vectors are elementwise.

### Recycling

R allows you to do operations on vectors of different lengths. The shorter vector will be "recycled" (~ repeated) to match the length of the longer one:

```
x <- c(5, 10, 15)
x + c(2, 4, 6, 8, 10, 12)     # no warning when it's a multiple
x + c(2, 4, 6, 8, 10, 12, 14) # warning
```

Boolean operations and Filtering

```
u <- c(1, 4, 2, 5, 6, 3, 7)
u < 3
u[u < 3]
u[u < 3 | u >= 4]
u[u > 5 & u < 1 ] ## nothing matches this condition
u[u > 5 & u < 8]
```

With character strings:

```
fav_colors <- c("John" = "red", "Lucy" = "blue", "Greg" = "green",
                "Sarah" = "yellow", "Tracy" = "purple")
fav_colors == "blue"
fav_colors[fav_colors == "blue"]
which(fav_colors == "blue")
names(fav_colors)[which(fav_colors == "blue")]
fav_colors == "green" | fav_colors == "blue" | fav_colors == "yellow"
fav_colors %in% c("green", "blue", "yellow")
fav_colors[fav_colors %in% c("green", "blue", "yellow")]
```

---

## Sources / further reading

This tutorial is based on many great resources, but in particular:

* [R for data science](http://r4ds.had.co.nz/)
* Cecilia Lee's [Introduction to R Programming](https://cecilialee.github.io/blog/2017/12/05/intro-to-r-programming.html)
* François Michonneau's [R-class](http://r-bio.github.io/)

In addition to these, there are many, many resources out there:

* Selva Prabhakaran's  [Top 50 ggplot2 Visualizations](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html) to give you an overview of ggplot2's possibilities
* Online courses on  [DataCamp](https://www.datacamp.com) on [R in general](https://www.datacamp.com/courses/free-introduction-to-r) and on [ggplot2](https://www.datacamp.com/courses/data-visualization-with-ggplot2-1).

#### Markdown

- Bulleted
- List

Another list 

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

Commented area