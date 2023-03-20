#Diffbind human prostate ATAC seq data from Pomerantz Neture Gen paper 2020
#Date: August 24, 2020
#Ivana


library(DiffBind)
library(dplyr)        


#svi osim 19T

setwd("/Volumes/Seagate/Barbieri_lab/Pomerantz_K27ac/Pomerantz_K27ac/bam")
h3k27 <- dba(sampleSheet="Samples.csv")
h3k27
h3k27  <- dba.count(h3k27)
h3k27
h3k27  <- dba.contrast(h3k27, categories = DBA_CONDITION, minMembers = 7)
h3k27
h3k27 <- dba.analyze(h3k27, method=DBA_EDGER)
h3k27 
plot(h3k27)

h3k27_m <- dba(sampleSheet="Samples2.csv")
h3k27_m
h3k27_m  <- dba.count(h3k27_m)
h3k27_m
h3k27_m  <- dba.contrast(h3k27_m, categories = DBA_CONDITION, minMembers = 7)
h3k27_m
h3k27_m <- dba.analyze(h3k27_m, method=DBA_EDGER)
h3k27_m
plot(h3k27_m)




h3k27_DS <- dba.report(h3k27, method=DBA_EDGER, DataType=DBA_DATA_FRAME, th=.05)
write.table(h3k27_DS, row.names=F, sep="\t", file="H3K27ac_N_vs_T.txt")
sum(h3k27_DS$Fold<0) 
sum(h3k27_DS$Fold>0)
dba.plotMA(h3k27, method=DBA_EDGER, th=.05)
dba.plotVolcano(h3k27, method=DBA_EDGER, th=.05)
corvals <- dba.plotHeatmap(h3k27, contrast=1, correlations=FALSE, method=DBA_EDGER, th=.05)

#to get all the peaks and all the values
res_edger <- dba.report(h3k27, DBA_EDGER, contrast = 1, th=1)
head(res_edger)

# Write to file
out <- as.data.frame(res_edger)
out
write.table(out, file="H3K27_comparison.txt", sep="\t", quote=F, row.names=F)

#create BED files for each set of significant regions 
library(dplyr)
One <- out %>% 
  filter(FDR < 0.05 & Fold > 0) %>% 
  select(seqnames, start, end)
nrow(One)
# Write to file
write.table(One, file="normal.bed", sep="\t", quote=F, row.names=F, col.names=F)

Two <- out %>% 
  filter(FDR < 0.05 & Fold < 0) %>% 
  select(seqnames, start, end)
nrow(Two)
# Write to file
write.table(Two, file="low.Gleason.tumor.bed", sep="\t", quote=F, row.names=F, col.names=F)