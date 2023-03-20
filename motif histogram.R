library(ggplot2)
library(dplyr)
library(viridis)

setwd("/Volumes/IVANA.WD/Ivana/AP1/Control.DHT.vs.EtOH")

#my data - just the common peaks with and without Ar binding
dir()
d <- read.csv("Fra1.common.csv")
head(d)

#rename columns
d.1 <- d %>% rename("Distance from center" = "Distance.from.Center..cmd.annotatePeaks.pl.AR.sorted.common.bed.mm10..size.1000..hist.5..m..Volumes.IVANA.WD.Ivana.Data.Control.organoids.integrative.analysis.peakAnalysis_sorted.enr.EtOH.FOXA1.bed.homerResults.motif1.motif.",
                    "Yes" = "Common.sites.with.AR",
                    "No" = "Common.sites.without.AR")
head(d.1)

#gather 
d.2 <- d.1 %>% gather( key = "sites", value = "signal", 2:3)
head(d.2)
str(d.2)

#make sites as factors
d.2$sites <- as.factor(d.2$sites)
str(d.2)

#plot as scatter plot
ggplot(data=d.2, aes(x=`Distance from center`, y=`signal`, color=`sites`)) +
  geom_point(size=2, aes(colour = factor(sites))) +
  scale_color_viridis(discrete=TRUE) +
  theme_classic()


ggplot(data=d.2, aes(x=`Distance from center`, y=`signal`, color=`sites`)) +
  geom_point(size=2, aes(colour = factor(sites))) +
  theme_classic()

#just the peaks - enriched ones
dir()
d.3 <- read.csv("Fra1.enriched.csv")
head(d.3)
#rename
d.4 <- d.3 %>% rename("Distance" = "Distance.from.Center..cmd.annotatePeaks.pl.sorted.enr.EtOH.bed.mm10..size.1000..hist.5..m..Volumes.IVANA.WD.Ivana.Data.Control.organoids.integrative.analysis.peakAnalysis_sorted.enr.EtOH.FOXA1.bed.homerResults.motif1.motif.",
                      "EtOH" = "enr.EtOH", "DHT" = "enr.DHT")
d.5 <- d.4 %>% gather( key = "sites", value = "signal", 2:3)
head(d.5)
ggplot(data=d.5, aes(x=`Distance`, y=`signal`, color=`sites`)) +
  geom_point(size=2, aes(colour = factor(sites))) +
  theme_classic()

#all together
dir()
d.6 <- read.csv('Fra1_all.csv')
d.7 <- d.6 %>% rename("Distance" = "Distance.from.Center..cmd.annotatePeaks.pl.AR.sorted.common.bed.mm10..size.1000..hist.5..m..Volumes.IVANA.WD.Ivana.Data.Control.organoids.integrative.analysis.peakAnalysis_sorted.enr.EtOH.FOXA1.bed.homerResults.motif1.motif.")
head(d.7)
d.8 <- d.7 %>% gather(key = "sites", value = "signal", 2:5)
head(d.8)

p1 <- ggplot(data=d.8, aes(x=`Distance`, y=`signal`, color=`sites`)) +
  geom_point(size=1, aes(colour = factor(sites))) +
  theme_classic()

#adjust the breaks on y axis
p1 + scale_y_continuous(breaks=seq(0, 0.0137, by = 0.0025))


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Junb
dir()
Jun <- read.csv("Junb.csv")
head(Jun)
Jun.1 <- Jun %>% gather(key = "sites", value = "signal", 2:5)
p2 <- ggplot(data=Jun.1, aes(x=`Distance`, y=`signal`, color=`sites`)) +
  geom_point(size=1, aes(colour = factor(sites))) +
  theme_classic()

p2 + scale_y_continuous(breaks=seq(0, 0.013516645, by = 0.0025))
