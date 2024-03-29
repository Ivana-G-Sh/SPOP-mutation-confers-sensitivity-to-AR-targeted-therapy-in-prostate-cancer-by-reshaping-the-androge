DESeq2

library(DESeq2)
library("pasilla")

#specify paths to the files
pasCts <- system.file("extdata", "pasilla_gene_counts.tsv", package="pasilla", mustWork=TRUE)
#"/Users/ivana/Library/R/3.6/library/pasilla/extdata/pasilla_gene_counts.tsv"

pasAnno <- system.file("extdata", "pasilla_sample_annotation.csv", package="pasilla", mustWork=TRUE)
#"/Users/ivana/Library/R/3.6/library/pasilla/extdata/pasilla_sample_annotation.csv"

#read in counts file
cts <- as.matrix(read.csv(pasCts,sep="\t",row.names="gene_id"))
View(cts)
str(cts)

#get the aanotation about the experiment and conditions
coldata <- read.csv(pasAnno, row.names=1)
#subset just to ge t the condition and type
coldata <- coldata[,c("condition","type")]
#convert it to factors
coldata$condition <- factor(coldata$condition)
coldata$type <- factor(coldata$type)
View(coldata)

## ----reorderPasila------------------------------------------------------------
#remove fb
rownames(coldata) <- sub("fb", "", rownames(coldata))
all(rownames(coldata) %in% colnames(cts))
#rownames from annotation and column names from matrix match
all(rownames(coldata) == colnames(cts))
cts <- cts[, rownames(coldata)]
all(rownames(coldata) == colnames(cts))

## ----matrixInput--------------------------------------------------------------
library("DESeq2")
dds <- DESeqDataSetFromMatrix(countData = cts,
                              colData = coldata,
                              design = ~ condition)
dds

## ----addFeatureData-----------------------------------------------------------
featureData <- data.frame(gene=rownames(cts))
mcols(dds) <- DataFrame(mcols(dds), featureData)
mcols(dds)

## ----htseqDirI, eval=FALSE----------------------------------------------------
#  directory <- "/path/to/your/files/"

## ----htseqDirII---------------------------------------------------------------
directory <- system.file("extdata", package="pasilla",
                         mustWork=TRUE)

## ----htseqInput---------------------------------------------------------------
sampleFiles <- grep("treated",list.files(directory),value=TRUE)
sampleCondition <- sub("(.*treated).*","\\1",sampleFiles)
sampleTable <- data.frame(sampleName = sampleFiles,
                          fileName = sampleFiles,
                          condition = sampleCondition)
View(sampleTable)
sampleTable$condition <- factor(sampleTable$condition)

## ----hsteqDds-----------------------------------------------------------------
library("DESeq2")
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = directory,
                                       design= ~ condition)
ddsHTSeq

## ----prefilter----------------------------------------------------------------
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

## ----factorlvl----------------------------------------------------------------
dds$condition <- factor(dds$condition, levels = c("untreated","treated"))

## ----relevel------------------------------------------------------------------
#so that everything is in comparison to the untreated sample
dds$condition <- relevel(dds$condition, ref = "untreated")

## ----droplevels---------------------------------------------------------------
dds$condition <- droplevels(dds$condition)

## ----deseq - run the differential expression----------------------------------
#DESEQ function has to be applied to raw data
dds <- DESeq(dds)
res <- results(dds)
res #result of the differential expression
mcols(res, use.names=TRUE) #description, page 16 of the manual

sum( res$padj < 0.01, na.rm=TRUE ) #how many genes have log2FC significant, padj

#We subset the results table to these genes and then sort it by the log2 fold change estimate to get the signicant genes with the strongest down-regulation
resSig <- res[ which(res$padj < 0.1 ), ]
head( resSig[ order( resSig$log2FoldChange ), ] )

#and with the strongest upregulation
tail( resSig[ order( resSig$log2FoldChange ), ] )

#extract the results---------------------------------------------------------------
#  res <- results(dds, name="condition_treated_vs_untreated")
#  res <- results(dds, contrast=c("condition","treated","untreated"))


## ----MA-----------------------------------------------------------------------
plotMA(res, ylim=c(-2,2))

#DESeq2's dispersion estimates
plotDispEsts( dds, ylim = c(1e-6, 1e1) )

#histogram of the p values
hist( res$pvalue, breaks=20, col="grey" )


#RLOG TRANSFORMATION - for other applications
rld <- rlog( dds )
rld
head( assay(rld) ) #rlog counts data are in the assay slot

#RLOG TRANSFORM to measure Euclidean distance between the samples
sampleDists <- dist( t( assay(rld) ) )
sampleDists
#We visualize the distances in a heatmap,
library(gplots)
library( "RColorBrewer" )

sampleDistMatrix <- as.matrix( sampleDists )
rownames(sampleDistMatrix) <- paste( rld$treatment,
                                     rld$patient, sep="-" )
colnames(sampleDistMatrix) <- NULL
colours = colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
heatmap.2( sampleDistMatrix, trace="none", col=colours)

#rlog transwform to do the PCA plot
plotPCA( rld)










## ----MAidentify, eval=FALSE---------------------------------------------------
#  idx <- identify(res$baseMean, res$log2FoldChange)
#  rownames(res)[idx]

## ----warning=FALSE------------------------------------------------------------
resultsNames(dds)
# because we are interested in treated vs untreated, we set 'coef=2'
resNorm <- lfcShrink(dds, coef=2, type="normal")
resAsh <- lfcShrink(dds, coef=2, type="ashr")



## ----plotCounts---------------------------------------------------------------
plotCounts(dds, gene=which.min(res$padj), intgroup="condition")

## ----plotCountsAdv------------------------------------------------------------
d <- plotCounts(dds, gene=which.min(res$padj), intgroup="condition", 
                returnData=TRUE)
library("ggplot2")
ggplot(d, aes(x=condition, y=count)) + 
  geom_point(position=position_jitter(w=0.1,h=0)) + 
  scale_y_log10(breaks=c(25,100,400))

## ----metadata-----------------------------------------------------------------
mcols(res)$description

## ----export, eval=FALSE-------------------------------------------------------
#  write.csv(as.data.frame(resOrdered),
#            file="condition_treated_results.csv")

## ----subset-------------------------------------------------------------------
resSig <- subset(resOrdered, padj < 0.1)
resSig

## ----multifactor--------------------------------------------------------------
colData(dds)

## ----copyMultifactor----------------------------------------------------------
ddsMF <- dds

## ----fixLevels----------------------------------------------------------------
levels(ddsMF$type)
levels(ddsMF$type) <- sub("-.*", "", levels(ddsMF$type))
levels(ddsMF$type)

## ----replaceDesign------------------------------------------------------------
design(ddsMF) <- formula(~ type + condition)
ddsMF <- DESeq(ddsMF)

## ----multiResults-------------------------------------------------------------
resMF <- results(ddsMF)
head(resMF)

## ----multiTypeResults---------------------------------------------------------
resMFType <- results(ddsMF,
                     contrast=c("type", "single", "paired"))
head(resMFType)

## ----rlogAndVST---------------------------------------------------------------
vsd <- vst(dds, blind=FALSE)
rld <- rlog(dds, blind=FALSE)
head(assay(vsd), 3)

## ----meansd-------------------------------------------------------------------
# this gives log2(n + 1)
ntd <- normTransform(dds)
library("vsn")
meanSdPlot(assay(ntd))
meanSdPlot(assay(vsd))
meanSdPlot(assay(rld))

## ----heatmap------------------------------------------------------------------
library("pheatmap")
select <- order(rowMeans(counts(dds,normalized=TRUE)),
                decreasing=TRUE)[1:20]
df <- as.data.frame(colData(dds)[,c("condition","type")])
pheatmap(assay(ntd)[select,], cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df)
pheatmap(assay(vsd)[select,], cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df)
pheatmap(assay(rld)[select,], cluster_rows=FALSE, show_rownames=FALSE,
         cluster_cols=FALSE, annotation_col=df)

## ----sampleClust--------------------------------------------------------------
sampleDists <- dist(t(assay(vsd)))

## ----figHeatmapSamples, fig.height=4, fig.width=6-----------------------------
library("RColorBrewer")
sampleDistMatrix <- as.matrix(sampleDists)
rownames(sampleDistMatrix) <- paste(vsd$condition, vsd$type, sep="-")
colnames(sampleDistMatrix) <- NULL
colors <- colorRampPalette( rev(brewer.pal(9, "Blues")) )(255)
pheatmap(sampleDistMatrix,
         clustering_distance_rows=sampleDists,
         clustering_distance_cols=sampleDists,
         col=colors)

## ----figPCA-------------------------------------------------------------------
plotPCA(vsd, intgroup=c("condition", "type"))

## ----figPCA2------------------------------------------------------------------
pcaData <- plotPCA(vsd, intgroup=c("condition", "type"), returnData=TRUE)
percentVar <- round(100 * attr(pcaData, "percentVar"))
ggplot(pcaData, aes(PC1, PC2, color=condition, shape=type)) +
  geom_point(size=3) +
  xlab(paste0("PC1: ",percentVar[1],"% variance")) +
  ylab(paste0("PC2: ",percentVar[2],"% variance")) + 
  coord_fixed()

## ----WaldTest, eval=FALSE-----------------------------------------------------
#  dds <- estimateSizeFactors(dds)
#  dds <- estimateDispersions(dds)
#  dds <- nbinomWaldTest(dds)

## ----simpleContrast, eval=FALSE-----------------------------------------------
#  results(dds, contrast=c("condition","C","B"))

## ----combineFactors, eval=FALSE-----------------------------------------------
#  dds$group <- factor(paste0(dds$genotype, dds$condition))
#  design(dds) <- ~ group
#  dds <- DESeq(dds)
#  resultsNames(dds)
#  results(dds, contrast=c("group", "IB", "IA"))

## ----interFig, echo=FALSE, results="hide", fig.height=3-----------------------
npg <- 20
mu <- 2^c(8,10,9,11,10,12)
cond <- rep(rep(c("A","B"),each=npg),3)
geno <- rep(c("I","II","III"),each=2*npg)
table(cond, geno)
counts <- rnbinom(6*npg, mu=rep(mu,each=npg), size=1/.01)
d <- data.frame(log2c=log2(counts+1), cond, geno)
library("ggplot2")
plotit <- function(d, title) {
  ggplot(d, aes(x=cond, y=log2c, group=geno)) + 
    geom_jitter(size=1.5, position = position_jitter(width=.15)) +
    facet_wrap(~ geno) + 
    stat_summary(fun.y=mean, geom="line", colour="red", size=0.8) + 
    xlab("condition") + ylab("log2(counts+1)") + ggtitle(title)
}
plotit(d, "Gene 1") + ylim(7,13)
lm(log2c ~ cond + geno + geno:cond, data=d)

## ----interFig2, echo=FALSE, results="hide", fig.height=3----------------------
mu[4] <- 2^12
mu[6] <- 2^8
counts <- rnbinom(6*npg, mu=rep(mu,each=npg), size=1/.01)
d2 <- data.frame(log2c=log2(counts + 1), cond, geno)
plotit(d2, "Gene 2") + ylim(7,13)
lm(log2c ~ cond + geno + geno:cond, data=d2)

## ----simpleLRT, eval=FALSE----------------------------------------------------
#  dds <- DESeq(dds, test="LRT", reduced=~1)
#  res <- results(dds)

## ----simpleLRT2, eval=FALSE---------------------------------------------------
#  dds <- DESeq(dds, test="LRT", reduced=~batch)
#  res <- results(dds)

## ----apeThresh----------------------------------------------------------------
resApeT <- lfcShrink(dds, coef=2, type="apeglm", lfcThreshold=1)
plotMA(resApeT, ylim=c(-3,3), cex=.8)
abline(h=c(-1,1), col="dodgerblue", lwd=2)

## -----------------------------------------------------------------------------
condition <- factor(rep(c("A","B","C"),each=2))
model.matrix(~ condition)
# to compare C vs B, make B the reference level,
# and select the last coefficient
condition <- relevel(condition, "B")
model.matrix(~ condition)

## -----------------------------------------------------------------------------
grp <- factor(rep(1:3,each=4))
cnd <- factor(rep(rep(c("A","B"),each=2),3))
model.matrix(~ grp + cnd + grp:cnd)
# to compare condition effect in group 3 vs 2,
# make group 2 the reference level,
# and select the last coefficient
grp <- relevel(grp, "2")
model.matrix(~ grp + cnd + grp:cnd)

## -----------------------------------------------------------------------------
grp <- factor(rep(1:2,each=4))
ind <- factor(rep(rep(1:2,each=2),2))
cnd <- factor(rep(c("A","B"),4))
model.matrix(~grp + grp:ind + grp:cnd)
# to compare condition effect across group,
# add a main effect for 'cnd',
# and select the last coefficient
model.matrix(~grp + cnd + grp:ind + grp:cnd)

## ----boxplotCooks-------------------------------------------------------------
par(mar=c(8,5,2,2))
boxplot(log10(assays(dds)[["cooks"]]), range=0, las=2)

## ----dispFit------------------------------------------------------------------
plotDispEsts(dds)

## ----dispFitCustom------------------------------------------------------------
ddsCustom <- dds
useForMedian <- mcols(ddsCustom)$dispGeneEst > 1e-7
medianDisp <- median(mcols(ddsCustom)$dispGeneEst[useForMedian],
                     na.rm=TRUE)
dispersionFunction(ddsCustom) <- function(mu) medianDisp
ddsCustom <- estimateDispersionsMAP(ddsCustom)

## ----filtByMean---------------------------------------------------------------
metadata(res)$alpha
metadata(res)$filterThreshold
plot(metadata(res)$filterNumRej, 
     type="b", ylab="number of rejections",
     xlab="quantiles of filter")
lines(metadata(res)$lo.fit, col="red")
abline(v=metadata(res)$filterTheta)

## ----noFilt-------------------------------------------------------------------
resNoFilt <- results(dds, independentFiltering=FALSE)
addmargins(table(filtering=(res$padj < .1),
                 noFiltering=(resNoFilt$padj < .1)))

## ----lfcThresh----------------------------------------------------------------
par(mfrow=c(2,2),mar=c(2,2,1,1))
ylim <- c(-2.5,2.5)
resGA <- results(dds, lfcThreshold=.5, altHypothesis="greaterAbs")
resLA <- results(dds, lfcThreshold=.5, altHypothesis="lessAbs")
resG <- results(dds, lfcThreshold=.5, altHypothesis="greater")
resL <- results(dds, lfcThreshold=.5, altHypothesis="less")
drawLines <- function() abline(h=c(-.5,.5),col="dodgerblue",lwd=2)
plotMA(resGA, ylim=ylim); drawLines()
plotMA(resLA, ylim=ylim); drawLines()
plotMA(resG, ylim=ylim); drawLines()
plotMA(resL, ylim=ylim); drawLines()

## ----mcols--------------------------------------------------------------------
mcols(dds,use.names=TRUE)[1:4,1:4]
substr(names(mcols(dds)),1,10) 
mcols(mcols(dds), use.names=TRUE)[1:4,]

## ----muAndCooks---------------------------------------------------------------
head(assays(dds)[["mu"]])
head(assays(dds)[["cooks"]])

## ----dispersions--------------------------------------------------------------
head(dispersions(dds))
head(mcols(dds)$dispersion)

## ----sizefactors--------------------------------------------------------------
sizeFactors(dds)

## ----coef---------------------------------------------------------------------
head(coef(dds))

## ----betaPriorVar-------------------------------------------------------------
attr(dds, "betaPriorVar")

## ----priorInfo----------------------------------------------------------------
priorInfo(resLFC)
priorInfo(resNorm)
priorInfo(resAsh)

## ----dispPriorVar-------------------------------------------------------------
dispersionFunction(dds)
attr(dispersionFunction(dds), "dispPriorVar")

## ----versionNum---------------------------------------------------------------
metadata(dds)[["version"]]

## ----normFactors, eval=FALSE--------------------------------------------------
#  normFactors <- normFactors / exp(rowMeans(log(normFactors)))
#  normalizationFactors(dds) <- normFactors

## ----offsetTransform, eval=FALSE----------------------------------------------
#  cqnOffset <- cqnObject$glm.offset
#  cqnNormFactors <- exp(cqnOffset)
#  EDASeqNormFactors <- exp(-1 * EDASeqOffset)

## ----lineardep, echo=FALSE----------------------------------------------------
DataFrame(batch=factor(c(1,1,2,2)), condition=factor(c("A","A","B","B")))

## ----lineardep2, echo=FALSE---------------------------------------------------
DataFrame(batch=factor(c(1,1,1,1,2,2)), condition=factor(c("A","A","B","B","C","C")))

## ----lineardep3, echo=FALSE---------------------------------------------------
DataFrame(batch=factor(c(1,1,1,2,2,2)), condition=factor(c("A","B","C","A","B","C")))

## ----groupeffect--------------------------------------------------------------
coldata <- DataFrame(grp=factor(rep(c("X","Y"),each=6)),
                     ind=factor(rep(1:6,each=2)),
                     cnd=factor(rep(c("A","B"),6)))
coldata

## -----------------------------------------------------------------------------
as.data.frame(coldata)

## ----groupeffect2-------------------------------------------------------------
coldata$ind.n <- factor(rep(rep(1:3,each=2),2))
as.data.frame(coldata)

## ----groupeffect3-------------------------------------------------------------
model.matrix(~ grp + grp:ind.n + grp:cnd, coldata)

## ----groupeffect4, eval=FALSE-------------------------------------------------
#  results(dds, contrast=list("grpY.cndB","grpX.cndB"))

## ----missingcombo-------------------------------------------------------------
group <- factor(rep(1:3,each=6))
condition <- factor(rep(rep(c("A","B","C"),each=2),3))
d <- DataFrame(group, condition)[-c(17,18),]
as.data.frame(d)

## ----missingcombo2------------------------------------------------------------
m1 <- model.matrix(~ condition*group, d)
colnames(m1)
unname(m1)
all.zero <- apply(m1, 2, function(x) all(x==0))
all.zero

## ----missingcombo3------------------------------------------------------------
idx <- which(all.zero)
m1 <- m1[,-idx]
unname(m1)

## ----cooksPlot----------------------------------------------------------------
W <- res$stat
maxCooks <- apply(assays(dds)[["cooks"]],1,max)
idx <- !is.na(W)
plot(rank(W[idx]), maxCooks[idx], xlab="rank of Wald statistic", 
     ylab="maximum Cook's distance per gene",
     ylim=c(0,5), cex=.4, col=rgb(0,0,0,.3))
m <- ncol(dds)
p <- 3
abline(h=qf(.99, p, m - p))

## ----indFilt------------------------------------------------------------------
plot(res$baseMean+1, -log10(res$pvalue),
     log="x", xlab="mean of normalized counts",
     ylab=expression(-log[10](pvalue)),
     ylim=c(0,30),
     cex=.4, col=rgb(0,0,0,.3))

## ----histindepfilt------------------------------------------------------------
use <- res$baseMean > metadata(res)$filterThreshold
h1 <- hist(res$pvalue[!use], breaks=0:50/50, plot=FALSE)
h2 <- hist(res$pvalue[use], breaks=0:50/50, plot=FALSE)
colori <- c(`do not pass`="khaki", `pass`="powderblue")

## ----fighistindepfilt---------------------------------------------------------
barplot(height = rbind(h1$counts, h2$counts), beside = FALSE,
        col = colori, space = 0, main = "", ylab="frequency")
text(x = c(0, length(h1$counts)), y = 0, label = paste(c(0,1)),
     adj = c(0.5,1.7), xpd=NA)
legend("topright", fill=rev(colori), legend=rev(names(colori)))

## ----vanillaDESeq, eval=FALSE-------------------------------------------------
#  dds <- DESeq(dds, minReplicatesForReplace=Inf)
#  res <- results(dds, cooksCutoff=FALSE, independentFiltering=FALSE)

## ---- eval=FALSE--------------------------------------------------------------
#  mat <- assay(vsd)
#  mat <- limma::removeBatchEffect(mat, vsd$batch)
#  assay(vsd) <- mat
#  plotPCA(vsd)

## ----varGroup, echo=FALSE-----------------------------------------------------
set.seed(3)
dds1 <- makeExampleDESeqDataSet(n=1000,m=12,betaSD=.3,dispMeanRel=function(x) 0.01)
dds2 <- makeExampleDESeqDataSet(n=1000,m=12,
                                betaSD=.3,
                                interceptMean=mcols(dds1)$trueIntercept,
                                interceptSD=0,
                                dispMeanRel=function(x) 0.2)
dds2 <- dds2[,7:12]
dds2$condition <- rep("C",6)
mcols(dds2) <- NULL
dds12 <- cbind(dds1, dds2)
rld <- rlog(dds12, blind=FALSE, fitType="mean")
plotPCA(rld)

## ----convertNA, eval=FALSE----------------------------------------------------
#  res$padj <- ifelse(is.na(res$padj), 1, res$padj)
