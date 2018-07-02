## Library
library(tidyverse)

## Help functions

# To substract the blank from each time point. This is done before 
# tidying up the data, as it is simpler to remove from the right time point
# The blank is also removed from the data set.
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

# Calculates mean and standard dev (as an alternative to mean_se which
# is built in ggplot2)
mean_sd <- function (x) {
  x <- stats::na.omit(x)
  sd <- stats::sd(x)
  mean <- mean(x)
  data.frame(y = mean, ymin = mean - sd, ymax = mean + sd)
}

## Read data, and remove blank

# od 600
od600 <- read_tsv("assets/OD600.txt")
od600_deblanked <- substract_blank(od600)
od600_tidy <- od600_deblanked %>% 
  gather(`0`:`42`, key='time', value='od600') %>%
  mutate(time = as.numeric(time)) %>%
  mutate(type = stringr::str_replace(type, "\\+", " withIPTG")) %>%
  mutate(type = stringr::str_replace(type, '-', ' noIPTG')) %>%
  separate(type, c("strain", "IPTG"), sep = " ")

# SYFP2
syfp2 <- read_tsv("assets/syfp2.txt")
syfp2_deblanked <- substract_blank(syfp2)
syfp2_tidy <- syfp2_deblanked %>% 
  gather(`0`:`42`, key='time', value='syfp2_fluo') %>%
  mutate(time = as.numeric(time)) %>%
  mutate(type = stringr::str_replace(type, "\\+", " withIPTG")) %>%
  mutate(type = stringr::str_replace(type, '-', ' noIPTG')) %>%
  separate(type, c("strain", "IPTG"), sep = " ")

# dTom
dtom <- read_tsv("assets/dtom.txt")
dtom_deblanked <- substract_blank(dtom)
dtom_tidy <- dtom_deblanked %>% 
  gather(`0`:`42`, key='time', value='dtom_fluo') %>%
  mutate(time = as.numeric(time)) %>%
  mutate(type = stringr::str_replace(type, "\\+", " withIPTG")) %>%
  mutate(type = stringr::str_replace(type, '-', ' noIPTG')) %>%
  separate(type, c("strain", "IPTG"), sep = " ")

# Now left-join all three datasets in one single aye tibble
aye <- left_join(left_join(od600_tidy, syfp2_tidy), dtom_tidy)

### Now plot
## OD 600
# Prepare "backbone", setting aesthetics (time vs. od600, grouping by 
# strain and shape)
gg_od600 <- ggplot(aye, aes(time, od600, color = strain, shape = IPTG, 
                                   linetype=IPTG))

# Plot each well for itself, no average
gg_od600 + geom_line(aes(group = well))
# Averaging per strain and treatment, adding error bars
gg_od600 + 
  stat_summary(fun.data = mean_sd, position = position_dodge(width = 0.2)) +
  stat_summary(fun.data = mean_sd, geom = "errorbar")
# OK, it grows OK-ish

# Now that's a busy graph Let's make several plots instead
gg_od600 + 
  stat_summary(fun.data = mean_sd, position = position_dodge(width = 0.2)) +
  stat_summary(fun.data = mean_sd, geom = "errorbar") +
  facet_wrap(~strain+IPTG)


# Cross-excitation?
ggplot(aye, aes(syfp2_fluo, dtom_fluo, color = strain)) + 
  geom_point(size = 0.1)
# A bit: dTomato leaks and shines when excited with SYFP2 settings
# Dynamic range is higher for syfp2 than dtomato

# Leaking?
ggplot(aye %>% filter(IPTG == "noIPTG"), aes(syfp2_fluo, dtom_fluo, color = strain)) + 
  geom_point(size = 0.1)
# A tad, much more for SYFP2 than from dTomato
# Why negative values??

# Correlation with OD?
gg_fluo <- ggplot(aye, aes(od600, syfp2_fluo, color = strain))
gg_fluo +
  geom_line(aes(group = well, linetype=IPTG))


                     