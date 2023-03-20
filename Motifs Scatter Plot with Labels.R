library(ggplot2)
library(dplyr)
library(ggrepel)
setwd("/Volumes/IVANA.WD/Ivana/AP1")
dir()
data <- read.csv("Ctrl organoids AP1 motif enrichment.csv")
head(data)

ggplot(data, aes(x = Rank, y = Score)) +
  geom_point() +
  # to add a conecting line geom_line() +
  theme_classic() +
  #add teh labels that do not overlap
  geom_label_repel(aes(label = Motif), size = 3) +
  #modify the x axis
  scale_x_continuous(n.breaks=10)