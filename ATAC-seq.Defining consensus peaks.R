#ATAC-seq
#Defining the consensus peaks between all the replicas in R with DiffBind package

library(DiffBind)
library(tidyverse)

setwd("/Volumes/IVANA.WD/Ivana/Data/ATACseq/Ctrl.SPOPmut.10nM.DHT")
dir()

dir()
#read in the peaksets
atac.Ctrl <- dba(sampleSheet = "Sampels.Control.csv")

#count the reads for every sample
atac.Ctrl <- dba.count(atac.Ctrl)
atac.Ctrl

#how well do the replicates agree (Venn diagram)?
names(atac.Ctrl$masks)
dba.plotVenn(atac.Ctrl, atac.Ctrl$masks$Control) #sad je vise peakova 52,053

#retrieve the concensus peakset just for the Control
atac_consensus_Ctrl <- dba.overlap(atac.Ctrl, atac.Ctrl$masks$Control)
atac_consensus_Ctrl$inAll #52043 regions
GRanges object with 52043 ranges and 4 metadata columns:
        seqnames            ranges strand |           scoreA           scoreB           scoreC           scoreD
           <Rle>         <IRanges>  <Rle> |        <numeric>        <numeric>        <numeric>        <numeric>
      1     chr1   4785292-4786073      * |  210.55582400037 275.609625974863 257.595400469652 247.831985308843
      2     chr1   4798320-4798716      * | 193.095097132046 196.311417799639 152.575737201256 153.614866926969
      3     chr1   4807446-4808333      * | 285.534239376111 338.467961723516 284.345692056885 324.639418772328
      4     chr1   4857314-4858747      * | 961.367079338273 1027.97555232028 973.908764083339 950.363976721515
      5     chr1   5015198-5015925      * | 577.231088235159 642.122075955471 637.053240392255 603.194377466565
    ...      ...               ...    ... .              ...              ...              ...              ...
  60940     chrY 90800281-90800850      * | 295.805255181007 338.467961723516 348.744542174298 316.446625869556
  60941     chrY 90803012-90803724      * |  287.58844253709 326.863345892996 335.864772150816 273.434463130005
  60942     chrY 90804724-90805286      * | 229.043652449182  212.75129022621 260.567655090456 255.000679098768
  60943     chrY 90807314-90807863      * | 295.805255181007 320.093986658525 365.587318358853  298.01284183832
  60944     chrY 90835509-90835817      * | 22.5962347707714 6.76935923447032   18.82427926509 30.7229733853938
  -------
  seqinfo: 21 sequences from an unspecified genome; no seqlengths

#write the result as the data table
output <- as.data.frame(atac_consensus_Ctrl$inAll)

#save as a txt object that can be opened with Excell
write.table(output, file="Consensus ATAC peaks in the Control treated with 10 nM DHT.txt", sep="\t", quote =F, row.names=F)