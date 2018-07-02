data("Nile")
install.packages("tidyverse")
library(tidyverse)
df <- read_tsv("data/samples.tab")
df <- read_tsv("assets/samples.tab")

## Colors
cbbPalette <- c("#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#FFFFFF")

## Plot
#pdf(file="figureSamplesPerLocation.pdf", h=4, w=6)
ggplot(df, aes(Date, Location)) +
  geom_path(linetype=3) +
  geom_point(aes(fill=Pulsotype), size=3, colour="black", pch=21) +
  scale_fill_manual(values=cbbPalette) +
  scale_x_date(date_minor_breaks = "1 month",
               limits=c(as.Date("2015-01-01"), NA))
#dev.off()

ggplot

ggplot(df, aes(Temperature, Chlorine)) + 
  geom_point() +
  geom_rug() +
  stat_
ggplot(data = df, mapping = aes(x = Temperature))
