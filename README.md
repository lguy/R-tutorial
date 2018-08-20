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

In general, *do not copy/paste* from the source code to the console. Use Cmd/Ctrl + Enter to *evaluate* one line or the selection.

### Folders

You separate the original data (raw data) from intermediate datasets that you may create for the need of a particular analysis. For instance, you may want to create a `data/` directory within your working directory that stores the raw data, and have a `data_output/` directory for intermediate datasets and a `figure_output/` directory for the plots you will generate.

Create the following folders in the "Files" tab in the Output area:

* `data/`
* `data_output/`
* `figure_output/`

---

## Creating objects

Let’s start by creating a simple object:

```R
x <- 10
x
```

We assigned to `x` the number 10. `<-` is the assignment operator. Assigns values on the right to objects on the left. Mostly similar to `=` but not always. Learn to use `<-` as it is good programming practice. Using `=` in place of `<-` can lead to issues down the line.

`=` should only be used to specify the values of arguments in functions for instance `read.csv(file="data/some_data.csv")`.

We can now manipulate this value to do things with it. For instance:

```R
x * 2
x + 5
x + x
```

or we can create new objects using `x`:

```R
y <- x + x + 5
```

Let’s try something different:

```R
x <- c(2, 4, 6)
x
```

Two things:

* we overwrote the content of `x`
* `x` now contains 3 elements

Using the `[]`, we can access individual elements of this object:

```R
x[1]
x[2]
x[3]
```

#### Challenge

What is the content of this vector?

```R
q <- c(x, x, 5)
```

We can also use these objects with functions, for instance to compute the mean and the standard deviation:

```R
mean(x)
sd(x)
```

This is useful to print the value of the mean or the standard deviation, but we can also save these values in their own variables:

```R
mean_x <- mean(x)
mean_x
```

### Working with stored data

The function `data()` allows you to load into memory datasets that are provided as examples with R (or some packages). Let’s load the Nile dataset that provides the annual flow of the river Nile between 1871 and 1970.

```R
data(Nile)
```

Using `ls()` shows you that the function `data()` made the variable Nile available to you.

Let’s make an histogram of the values of the flows:

```R
hist(Nile)
```

#### Challenge

The following: `abline(v=100, col="red")` would draw a vertical line on an existing plot at the value 100, colored in red.

How would you add such a line to our histogram to show where the mean falls in this distribution?

We can now save this plot in its own file:

```R
pdf(file="figure_output/nile_flow.pdf")
hist(Nile)
abline(v=mean(Nile), col="red")
dev.off()
```

Note that we saved the figure `nile_flow.pdf` in the `figure_output` folder. 

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

```R
x <- c(5, 10, 15, 20, 25)
class(x)
```

However, there will be cases when we want to create empty vectors that will be later populated with values.

```R
x <- numeric(5)
x
```

Similarly, we can create empty vectors of class `character` using `character(5)`, or of class `logical`: `logical(5)`, etc.

### Naming the elements of a vector

```R
fav_colors <- c("red", "blue", "green", "yellow")
names(fav_colors)
names(fav_colors) <- c("John", "Lucy", "Greg", "Sarah")
fav_colors
names(fav_colors)
unname(fav_colors)
```

### How to access elements of a vector?

They can be accessed by their indices:

```R
fav_colors[2]
fav_colors[2:4]
```

Repetitions are allowed:

```R
fav_colors[c(2,3,2,4,1,2)]
```

or if the vector is named, it can be accessed by the names of the elements:

```R
fav_colors["John"]
```

#### Challenges

* How to access the content of the vector for "Lucy", "Sarah" and "John" (in this order)?
* How to get the name of the second person?

### How to update/replace the value of a vector?

```R 
x[4] <- 22
fav_colors["Sarah"] <- "turquoise"
```

### How to add elements to a vector?

```R
x <- c(5, 10, 15, 20)
x <- c(x, 25) # adding at the end
x <- c(0, x)  # adding at the beginning
x
```

With named vectors:

```R
fav_colors
c(fav_colors, "purple")
fav_colors <- c(fav_colors, "Tracy" = "purple")
```

Notes:

* here is the case where using the = is OK/needed
* pay attention to where the quotes are

#### Challenge

If we add another element to our vector:

```R
fav_color <- c(fav_colors, "black")
```

How to use the function `names()` to assign the name "Ana" to this last element?

### How to remove elements from a vector?

```R
x[-5]
x[-c(1, 3, 5)]
```

but this: `fav_colors[-c("Tracy")]` does not work. We need to use the function match():

```R
fav_colors[-match("Tracy", names(fav_colors))]
```

The function `match()` looks for the position of the first exact match within another vector.

### Sequences

`:` is a special function that creates numeric vectors of integer in increasing or decreasing order, test 1:10 and 10:1 for instance. The function `seq()` (for *seq*uence) can be used to create more complex patterns:

```R
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
```

Repeating:

```R 
x <- rep(8, 4)
x
rep(1:3, 3)
```

Operations on vectors

```R
x <- c(5, 10, 15)
x + 10
x + c(10, 15, 20)
x * 10
x * c(2, 4, 3)
```

Note that operations on vectors are elementwise.

### Recycling

R allows you to do operations on vectors of different lengths. The shorter vector will be "recycled" (~ repeated) to match the length of the longer one:

```R
x <- c(5, 10, 15)
x + c(2, 4, 6, 8, 10, 12)     # no warning when it's a multiple
x + c(2, 4, 6, 8, 10, 12, 14) # warning
```

Boolean operations and Filtering

```R
u <- c(1, 4, 2, 5, 6, 3, 7)
u < 3
u[u < 3]
u[u < 3 | u >= 4]
u[u > 5 & u < 1 ] ## nothing matches this condition
u[u > 5 & u < 8]
```

With character strings:

```R
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

## Importing files

In this section, you’ll learn how to read plain-text rectangular files into R. Here, we’ll only scratch the surface of data import, but many of the principles will translate to other forms of data.

The traditional way to import and manipulate data in R is through `read.table()`. However, in this tutorial, we're here making use of the package `readr`, one of the `tidyverse` collection. Instead of returning `data.frame` objects, `readr` returns `tibble` objects, which are also `data.frames` but few a few added twists. Read more on `tibble` objects in the [R for Data Science book](http://r4ds.had.co.nz/tibbles.html). 

We will first install all packages of the collection, as we'll use more of these later. One only need to run this code once (i.e. it shouldn't figure in your scripts):

```R
install.packages("tidyverse")
```

This command will download and install the required dependencies. It might take a few minutes to complete.

Read more about [tidyverse here](https://www.tidyverse.org/).

We now load the library:

```R
library(tidyverse)
```

### Getting started

Most of `readr`’s functions are concerned with turning flat files into data frames:

* `read_csv()` reads comma delimited files 
* `read_csv2()` reads semicolon separated files (common in countries where `,` is used as the decimal place)
* `read_tsv()` reads tab delimited files
* `read_delim()` reads in files with any delimiter.
* `read_fwf()` reads fixed width files. You can specify fields either by their widths with `fwf_widths()` or their position with `fwf_positions()`. `read_table()` reads a common variation of fixed width files where columns are separated by white space.

These functions all have similar syntax: once you’ve mastered one, you can use the others with ease. For the rest of this chapter we’ll focus on `read_tsv()`. Not only are csv files one of the most common forms of data storage, but once you understand `read_tsv()`, you can easily apply your knowledge to all the other functions in readr.

The first argument to `read_tsv()` is the most important: it’s the path to the file to read.

### First dataset: Legionella samples

We're going to explore a dataset that shows information on water samples, taken from a Spanish hospital, possibly containing different pulsotypes (isolates) of Legionella pneumophila. For each sample (observation) several variables have been recorded: the date, the sampling ID, the temperature, chlorine content and pH of the water.

* Download the [samples.tab file](assets/samples.tab). If your browser shows you the file instead of offering to download it, do File -> Save As and make sure you select "text" or "raw" somewhere.
* Save the file in your `data` subfolder in the folder you've created for this exercise.
* Inspect the data: either open it with Excel or with a text editor (TextEdit or Notepad, for example). What do you see?
* Import the data in R:
```R
df <- read_tsv("data/samples.tab")
```
* The object `df` should now appear in the Environment area in RStudio. Have a look at it.
* For sake of plotting something, let's use the basic `plot` figure from R:
```R
plot(df$Temperature, df$Chlorine)
```

Congratulations, this was your first graph in R. The plots that come with the `graphics` package in R are good, and are really great to explore your data, before starting on more complicated renderings. 

A list and a gallery of the traditional graphs is available in a wikibook [R Programming/Graphics](https://en.wikibooks.org/wiki/R_Programming/Graphics). However, for more complex data and extended possibilities, we'll use the `ggplot2` package.

### In real life

In this example, the data comes already very tidy, but this is rarely the case in real life. To tidy up the data, the best of course is to produce it the right way (see presentation), but whenever working with data produced by others, the `tidyr` package helps a great deal. See more information about tidying data in the corresponding [R for Data Science book](http://r4ds.had.co.nz/tidy-data.html). We'll see an extended example in a later section.

-------

## Plotting with ggplot2

### Data exploration

The principle with ggplot2 is to first set the stage (with `ggplot()`), by stating (i) which dataset will be used (`data =`), and (ii) which variables will be used and how (`mapping = aes()`). 

In our case, we first want to look at the distribution of chlorine:

```R
ggplot(data = df, mapping = aes(x = Chlorine))
```

Notice that this actually sets the stage (axes, plot area) but doesn't plot any real data. Now we need to tell how we want the data to be represented. Let's select an histogram, with bin widths of 0.1. We just "add" that to the `ggplot call`:

```R
ggplot(data = df, mapping = aes(x = Chlorine)) + 
  geom_histogram(binwidth = 0.1)
```

You can ignore the warnings. There are `NA` (not available) values in our dataset, we know that.

Now if we want to try several representation of the same dataset with the same aesthetics, we can save the ggplot call and keep adding to it:


```R
gg_chlorine <- ggplot(data = df, mapping = aes(x = Chlorine)) 
gg_chlorine + 
  geom_histogram(binwidth = 0.1)
gg_chlorine + 
  geom_density()
  
```

Let's now see if there is a correlation between temperature and chlorine:

```R
ggplot(df, aes(Temperature, Chlorine)) + 
  geom_point() +
  geom_rug()
```

Here, we select `df` as the dataset, and want to plot chlorine as a function of temperature (`aes()`). We also want to plot a simple xy scatterplot (`geom_point()`) and add marginal densities (`geom_rug()`).

But let's see if there is a different pattern for the different pulsotypes of Legionella that were found. We simply tell ggplot that we want different colors for different pulsotypes:

```R
ggplot(df, aes(Temperature, Chlorine, color = Pulsotype)) + 
  geom_point() +
  geom_rug()
```

Now for another type of graphical representation: we want to see whether some pulsotypes have been repeatedly isolated from the same locations over time:

```R
cbbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#FFFFFF")

gg_location <- ggplot(df, aes(Date, Location)) +
  geom_path(linetype = 3) +
  geom_point(aes(fill = Pulsotype), size = 3, colour = "black", pch=21) +
  scale_fill_manual(values=cbbPalette) +
  scale_x_date(date_minor_breaks = "1 month",
               limits=c(as.Date("2015-01-01"), NA))

gg_location

ggsave("figure_output/location_vs_time.pdf", gg_location)

```

Here, we:

1. Plot the locations as a function of time (`Date`)
1. Show lines between the locations (`geom_path`)
1. Display points for these locations (`geom_point`). We color these by pulsotype (`aes(fill = Pulsotype)`), but we didn't want lines above to be split by pulsotype, only be locations (try it to see how that works).
1. Use our own palette (which is color-blind friendly) (`scale_fill_manual`)
1. Set the minor breaks on the x axis to be months and the limits for the plot to start on January 1st, 2015 (`scale_x_date()`).

We finally save the plot in pdf format with `ggsave`.

This code, which is about 10 lines long (including importing the data), produced a figure in a manuscript recently accepted.

---

## Tidying data and plotting: A more complex example

In this example, we'll go from a (relatively) given raw output from an instrument and show ways to use for different purposes. An important point here is that the time invested in preparing the data (writing the initial code to tidy up and prepare visualizations is well invested: once you reuse the instrument you can reuse your code and reproducibly and quickly go from raw data to ask questions about your data.

### Import the datasets

It is recommended to start another project, with its own folder structure as before.

You'll need to reload the `tidyverse` library:

```R
library(tidyverse)
```

Here, we use (slightly modified) output from the Tecan Spark to explore the results of one experiment. The experiment was to grow three strains of Legionella: a Legionella pneumophila Paris wild type (WT), and two isogenic mutants of this one, one with a SYFP2 gene and one with a dTomato gene. The bacteria were grown in AYE medium for 42 hours, in three different conditions: in one, IPTG was added in the overnight preculture (withIPTG), in a second the IPTG was added only at the beginning of the experiment (NI for non-induced) and the third one did not receive IPTG. There were several replicates for each of the combinations of strain and treatment. 

The data is spread in three files, that you should download and save in the `data` folder:

* [`OD600.txt`](assets/OD600.txt): optical density at 600 nm
* [`syfp2.txt`](assets/syfp2.txt): fluorescence that corresponds to SYFP2
* [`dtom.txt`](assets/dtom.txt): fluorescence that corresponds to dTomato

Take a moment to see how this data is organized.

In that case, each row corresponds to a well. There are two columns which give the well and a label that represents both the strain and the treatment. Each following column are absorbance/fluorescence values at different time points. 

### Tidy the datasets

This data is not tidy:
1. There are multiple observations per row, as each different measure is a separate observation. We want to have one row per time point and per replicate.
1. The label for the well gives two different variables, the treatment and the strain. We want to split this column into two.
1. The data is spread over three files. 
1. Before using the fluorescence or the absorbance values, we need to subtract the blank values. 

There are many ways to perform that last action, but none "off the shelf" that is really satisfying, since there is no easy way to associate one treatment with the right blank. We thus devise an ad-hoc function:

```R
substract_blank <- function(tb){
  blank_min <- tb %>% filter(type == "Blank-")
  blank_min_mean <- apply(blank_min[,3:ncol(tb)], 2, mean)
  blank_plus <- tb %>% filter(type == "Blank+")
  blank_plus_mean <- apply(blank_plus[,3:ncol(tb)], 2, mean)
  for (i in 1:nrow(tb)){
    if (tb$type[i] %in% c("dTom NI", "dTom+", "SYFP2 NI", "SYFP2+",
                          "WT NI", "WT+")){
      tb[i,3:ncol(tb)] <- tb[i,3:ncol(tb)] - blank_plus_mean
    } else if (tb$type[i] %in% c("dTom-", "SYFP2-", "WT-")){
      tb[i,3:ncol(tb)] <- tb[i,3:ncol(tb)] - blank_min_mean
    }
  }
  tb %>% filter(!(type %in% c("Blank-", "Blank+")))
}
```

Briefly, this function first finds the rows corresponding to the two blanks, averages the values at each time point for each blank replicate, and then uses an `if/else` control to substract the right blank from the right treatment. The blank values are removed from the resulting tibble. 

You will need to copy-paste or evaluate that function in order to perform the next step.

Let's start with the OD600. We first open the file (a simple call to `read_tsv`, since our data is in a tab-separated file). Then we substract the blank values using the function above. Finally, we tidy the data, "piping" (`%>%`) the resulting tibble through several functions:

1. The columns `0` to `42` (containing the values at each time point) are `gather`ed: it means for each variable we produce a new row with all other variables (in that case the well and the well label), and a new variable which is the time.
1. Some columns are cleaned:
  1. The time is converted to numeric values (it was stored as text before)
  1. The signs `+` and `-` (like in WT+ or SYFP2-, indicating the presence or not of IPTG) are replaced by a space and either withIPTG or noIPTG. 
1. The label which contains both the strain and the treatment is `separate`d to two new variables. 

```R
od600 <- 
  read_tsv("data/OD600.txt")
od600_deblanked <- substract_blank(od600)
od600_tidy <- od600_deblanked %>% 
  gather(`0`:`42`, key='time', value='od600') %>%
  mutate(time = as.numeric(time)) %>%
  mutate(type = stringr::str_replace(type, "\\+", " withIPTG")) %>%
  mutate(type = stringr::str_replace(type, '-', ' noIPTG')) %>%
  separate(type, c("strain", "IPTG"), sep = " ")
```

We obtain a new `od600_tidy` object. We repeat the procedure for the other two datasets containing the fluorescence values at the wavelengths corresponding to the emission of SYFTP2 and dTomato:

```R
# SYFP2
syfp2 <- read_tsv("data/syfp2.txt")
syfp2_deblanked <- substract_blank(syfp2)
syfp2_tidy <- syfp2_deblanked %>% 
  gather(`0`:`42`, key='time', value='syfp2_fluo') %>%
  mutate(time = as.numeric(time)) %>%
  mutate(type = stringr::str_replace(type, "\\+", " withIPTG")) %>%
  mutate(type = stringr::str_replace(type, '-', ' noIPTG')) %>%
  separate(type, c("strain", "IPTG"), sep = " ")

# dTom
dtom <- read_tsv("data/dtom.txt")
dtom_deblanked <- substract_blank(dtom)
dtom_tidy <- dtom_deblanked %>% 
  gather(`0`:`42`, key='time', value='dtom_fluo') %>%
  mutate(time = as.numeric(time)) %>%
  mutate(type = stringr::str_replace(type, "\\+", " withIPTG")) %>%
  mutate(type = stringr::str_replace(type, '-', ' noIPTG')) %>%
  separate(type, c("strain", "IPTG"), sep = " ")
```

Now left-join all three datasets in one single aye tibble (AYE is the medium used to grow the bacteria). This operation is possible for tibbles which have the same number of rows, with at least one common variable. The rest is added as new columns. We use two "nested" `left_join` commands to join all three datasets in one go: 

```R
aye <- left_join(left_join(od600_tidy, syfp2_tidy), dtom_tidy)

```

We're good! Now let's explore the data:

### Exploratory plots

These are just a few examples to demonstrate how to answer simple questions about the data.

Since we're going to have several questions about OD600 along time, we first save a generic `ggplot` object, grouping data by strain (color) and treatment (shapes and/or linetypes). 

```R 
gg_od600 <- ggplot(aye, aes(time, od600, color = strain, shape = IPTG, 
                                   linetype=IPTG))
```

#### How to plot OD 600 vs. time

We add lines to the plot, grouping by well to follow the growth in each well separately.

```R
gg_od600 + geom_line(aes(group = well))
```

#### How to average per strain and treatment?

And adding error bars. We want to summarize each group (treatment x strain) by showing the average and also show error bars at each point. We use the function `stat_summary` twice, once for the average lines, and once for the error bars. However, the inbuilt summary functions (argument `fun.data` are limited, and do not do exactly what we want. The closest one is `mean_se` but it displays the standard error of the mean whereas we want standard deviation. We display the function just by typing its name with no parenthesis,  (`mean_sd`). 

```R
mean_se
# function (x, mult = 1) 
# {
#    x <- stats::na.omit(x)
#    se <- mult * sqrt(stats::var(x)/length(x))
#    mean <- mean(x)
#    data.frame(y = mean, ymin = mean - se, ymax = mean + se)
}
```

Based on this, we can design an object that takes similar input and returns a similar object:

```R
mean_sd <- function (x) {
  x <- stats::na.omit(x)
  sd <- stats::sd(x)
  mean <- mean(x)
  data.frame(y = mean, ymin = mean - sd, ymax = mean + sd)
}
```

We can now write our graphical command, recalling the `ggplot` object and add the two `stat_summary` calls. To the section, which displays

```R
gg_od600 + 
  stat_summary(fun.data = mean_sd, geom = "errorbar") +
  stat_summary(fun.data = mean_sd, position = position_dodge(width = 0.5))
# OK, it grows OK-ish
```

#### How to spread the information on several panels

That was quite a lot of curves on the same plot. Let's use `facet_wrap` to separate them. We could separate by treatment or by strain, but let's do both:

```R
gg_od600 + 
  stat_summary(fun.data = mean_sd, position = position_dodge(width = 0.2)) +
  stat_summary(fun.data = mean_sd, geom = "errorbar") +
  facet_wrap(~strain+IPTG)
```

#### How to plot cross-excitation?

We want to see if the dTomato strain reacts to SYFP2 excitation and vice-versa. We need to change the basic aesthetics. We do a simple dot-plot.

```R
ggplot(aye, aes(syfp2_fluo, dtom_fluo, color = strain)) + 
  geom_point(size = 0.1)
# A bit: dTomato leaks and shines when excited with SYFP2 settings
# Dynamic range is higher for syfp2 than dtomato
```

#### Is there any leaking from the lac promoter?

We want to see if there is any fluorescence whenever we don't add IPTG. We filter out the data by using a `%>%` from the dataset to a `filter` function, and we select only the rows where the variable "IPTG" has "noIPTG" as value. A simple dot-plot then. 


```R
# Leaking?
ggplot(aye %>% filter(IPTG == "noIPTG"), aes(syfp2_fluo, dtom_fluo, color = strain)) + 
  geom_point(size = 0.1)
# A tad, much more for SYFP2 than from dTomato
# Why negative values??
```

#### Is fluorescence correlated with OD?

This time we want syfp2 fluorescence as a function of OD600. We want lines this time:

```R
# Correlation with OD?
gg_fluo <- ggplot(aye, aes(od600, syfp2_fluo, color = strain))
gg_fluo +
  geom_line(aes(group = well, linetype=IPTG))
# Not linear everywhere but we have a reference curve
```

And so on and so forth. Ask your own questions about the dataset if you want and try to answer then using R.

---

## Your own figure

Now use your own data. Think:

* What should the figure say? What is the message?
* Is my data well organized? (observations in rows, variables in columns, values in the cells)
* Start small, and build upon what you already have
* Limitations by the graphical packages are often there to discourage you to misrepresent data. Think twice.

---

## Getting help

I know the name of the function I want to use, but I’m not sure how to use it
If you need help with a specific function, let’s say `barplot()`, you can type:

```R
?barplot
```

If you just need to remind yourself of the names of the arguments, you can use:

```R 
args(barplot)
```

To see what a function is able to do, use `example()`

```R
example(barplot)
```

For more ways to get help, [read this page](http://r-bio.github.io/seeking-help/)

---

## Sources / further reading

This tutorial is based on many great resources, but in particular:

* Garrett Grolemund and Hadley Wickham's [R for data science](http://r4ds.had.co.nz/)
* Cecilia Lee's [Introduction to R Programming](https://cecilialee.github.io/blog/2017/12/05/intro-to-r-programming.html)
* François Michonneau's [R-class](http://r-bio.github.io/)

In addition to these, there are many, many resources out there:

* [RStudio's cheatsheets](https://www.rstudio.com/resources/cheatsheets/) on many of the topics covered here.
* Selva Prabhakaran's  [Top 50 ggplot2 Visualizations](http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html) to give you an overview of ggplot2's possibilities
* Online courses on  [DataCamp](https://www.datacamp.com) on [R in general](https://www.datacamp.com/courses/free-introduction-to-r) and on [ggplot2](https://www.datacamp.com/courses/data-visualization-with-ggplot2-1).
* A wikibook on [R Programming/Graphics](https://en.wikibooks.org/wiki/R_Programming/Graphics)
