library(ggplot2)
library(dplyr)

setwd("/Volumes/IVANA.WD/Ivana/Data/ATACseq.RNAseq.connection")

#plotting the KEGG putput from cistrome GO ----------------------------------------------------------------------------------------
dir()
rm(data)
KEGG_SPOP <- read.csv("KEGG_SPOP.csv")
str(KEGG_SPOP)
names(KEGG_SPOP)
##change FDR into -log10(FDR)
data <- KEGG_SPOP %>% mutate(log10 = -log10(FDR))

#keep the order of the category Term
data$Term <- factor(data$Term, levels = data$Term)

#basic horisontal bar plot
plot <- ggplot(data, aes(x=Term, y=log10, fill=Genes2)) + geom_bar(stat = "identity") +  coord_flip()

#playing with colours of the bars
plot + scale_fill_gradient(  low = "#132B43", high = "#56B1F7", space = "Lab", na.value = "grey50", guide = "colourbar", aesthetics = "fill") 
library("colorspace")
hcl_palettes(plot = TRUE)
plot + scale_fill_gradientn(colours = colorspace::heat_hcl(10)) 
plot + scale_fill_gradientn(colours = colorspace::sequential_hcl(5, palette = "Reds"))
plot1 <- plot + scale_fill_gradientn(colours = colorspace::sequential_hcl(5, palette = "YlOrRd"))
#add black line around the bars
View(data)
plot2 <- plot1 + geom_bar(stat = "identity", color = "black") 
#remove the gray background
plot3 <- plot2 + theme_classic()
#specify font
library(extrafont)
plot4 <- plot3 + theme(text = element_text(size=32, family = "Arial", face="bold"))
plot4

#the thing is that the gene number is not exactly the correct one, I think it is the genes that correspnded to the peaks , but not all of them were found to be significant, 
#for the metabpolic pathway there are 250 significant genes
#gradient fill ont he basis of p value
#promjenila estrogen signlaling u hormone signalling
dir()
KEGG_SPOP2 <- read.csv( "KEGG_SPOP_corrected.csv" )
dat <- KEGG_SPOP2 %>% mutate(log10 = -log10(FDR))
dat$Term <- factor(dat$Term, levels = dat$Term)
names(dat)
ggplot(dat, aes(x=Term, y=log10, fill=Erichment)) + 
  geom_bar(stat = "identity", color = "black") +  
  coord_flip() + 
  scale_fill_gradientn(colours = colorspace::sequential_hcl(5, palette = "Peach")) +
  theme_bw() +
  theme(text = element_text(size=18, family = "Arial", face="bold")) #FINAL
#SunsetDark is also OK


#GOING FROM CISTROME GO TO EXPRESSION IN SPOP MUTANT PRAD SAMPELS --------------------------------------------------------------------

#APPROACH NO 1-------------------------------------------------------------------------------------------------------------------------
#search for the metabolic gene s- their expression in cBioportal
patients <- read.csv("/Volumes/IVANA.WD/Ivana/Data/ATACseq.RNAseq.connection/CBIOPORTAL/table.csv")
dir()
metabolic.genes <- read.csv("/Volumes/IVANA.WD/Ivana/Data/ATACseq.RNAseq.connection/CBIOPORTAL/genes.metabolic.pathways.csv")
head(patients)
head(metabolic.genes)
human.genes <- patients %>% filter(Gene %in% metabolic.genes$Symbol_upper) %>% filter(Higher.expression.in == "Altered group")

#Deli- to do the heatmap
write.xlsx2(human.genes, "human.genes.xlsx")
#Deli has performed the DEG analsysi and plotted a heatmap

#APPROACH NO 2 -----------------------------------------------------------------------------------------------------------------------------
#on the basis of RP
#convert mouse genes to human genes with biomart
library(biomaRt)
patients <- read.csv("/Volumes/IVANA.WD/Ivana/Data/ATACseq.RNAseq.connection/CBIOPORTAL/table.csv")
RP.genes <- read.csv("/Volumes/IVANA.WD/Ivana/Data/ATACseq.RNAseq.connection/UP_SPOP/increased.accessibility.and.expression_SPOPmut/RP.csv")

#filter the genes on the basis of adjusted RP value
names(RP.genes)
data <- RP.genes %>% filter(adjRPscore >= 0.1)
nrow(data) #1336

#create  a vector with mouse gene names
musGenes <- pull(data, "Symbol")

#convert to human genes
convertMouseGeneList <- function(x){
  require("biomaRt")
  human = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
  mouse = useMart("ensembl", dataset = "mmusculus_gene_ensembl")
  genesV2 = getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = x , mart = mouse, attributesL = c("hgnc_symbol"), martL = human, uniqueRows=T)
  humanx <- unique(genesV2[, 2])
  # Print the first 6 genes found to the screen
  print(head(humanx))
  return(humanx)
}

genes <- convertMouseGeneList(musGenes) #WORKED!
length(genes) #1228
#subset the list of human differentiall expressed genes between SPOP and Ctrl
human.genes.RP <- patients %>% filter(Gene %in% genes) %>% filter(Higher.expression.in == "Altered group")
nrow(human.genes.RP) #178
#send to Deli to make a heatmap
write.xlsx2(human.genes.RP, "human.genes.RP.xlsx")
#he has done it and created a signature out of it


# approach no 2b- plot the counts of RP genes to see how they change in sgAr - Deli corrected --------------------------------------------------------------------------------------------------------
RP.genes <- read.csv("/Volumes/IVANA.WD/Ivana/Data/ATACseq.RNAseq.connection/UP_SPOP/increased.accessibility.and.expression_SPOPmut/RP.csv")
RP.genes.filt <- RP.genes %>% filter(adjRPscore > 0)
nrow(RP.genes.filt) #3607
names(RP.genes.filt)
#read in htseq outoput as matrix
rm(counts)
counts <- read.csv("/Volumes/IVANA.WD/Ivana/Data/RNA-seq/GSE149868_RNA_table.SPOPmut.csv", stringsAsFactors = F)
ncol(counts)
str(counts) #kaze da ima 35997 levels i 35999 vrijednosti - znaci da misli da su 2 reda duplicirana
table(duplicated(counts$Symbol))
counts.unique  <- counts[!duplicated(counts$Symbol), ]
str(counts.unique)
write.csv(counts.unique, "counts.sgAr.SPOP.unique.csv")

counts <- as.matrix(read.csv("counts.sgAr.SPOP.unique.csv", row.names=1))
ncol(counts)
head(counts)
coldata.SPOP.Ar <- read.csv("/Volumes/IVANA.WD/Ivana/Data/RNA-seq/Annotation.SPOP.csv", row.names=1)
coldata.SPOP.Ar$condition <- factor(coldata.SPOP.Ar$condition)
levels(coldata.SPOP.Ar$condition)
library(DESeq2)
dds.SPOP.Ar <- DESeqDataSetFromMatrix(countData = counts,
                                 colData = coldata.SPOP.Ar ,
                                 design = ~ condition)
#normalize
rlog <- rlog(dds.SPOP.Ar, blind=FALSE)
#PCA plot
plotPCA(rlog)
#takeout the normalized counts
#convert to df to be able to subset
rld.df <- as.data.frame(assay(rlog))
rm(rld.df)
names <- rownames(rld.df)
#convert sybmol rowname sinto a columns
rld.df <- cbind(names, data.frame(rld.df, row.names=NULL))
colnames(rld.df)
str(rld.df)
#remove sgAR_rep1 and sgNT, rep2
rld.df <- rld.df[,-c(3, 6)]
#and now subset
#subsetting on the basis of RP >0 ~~~~~~~~~~~~~~~~~~~~~~~~
rld.Ar <- rld.df %>% filter(names  %in% RP.genes.filt$Symbol)
nrow(rld.Ar ) #3436
class(rld.Ar)
head(rld.Ar)
#convert to matrix and keep the names i.e. symbols as rownames
#copy-pasted the function to keep thte rownames from the dataframe and convert the counts into integers in matrix
matrix.please <- function(x) {
  m<-as.matrix(x[,-1])
  rownames(m) <- x[,1]
  m
}
M <- matrix.please(rld.Ar)
head(M)
#heatmap with scaling in rows (z-score)
#filter out just the ones where z score goes from lower to higher
library(gplots)
hm.1 <- heatmap.2(M  , scale = "row", col = bluered(100), trace = "none", density.info = "none")
str(hm.1)
z.sc <- hm.1$carpet
#covert rows to columns with transpose function
z.sc.1 <- as.data.frame(t(z.sc))
genes.z.sc.1 <- rownames(z.sc.1)
z.sc.2 <- z.sc.1 %>% rowwise() %>%  mutate(sgar = sum(sgAR_rep2, sgAR_rep4, sgAR_rep3)/3) %>%  mutate(sgnt = sum(sgNT_rep1, sgNT_rep4, sgNT_rep3)/3)  %>% mutate(diff = ifelse(sgar < sgnt, "YES", "NO"))
z.sc.3 <- cbind(genes.z.sc.1, z.sc.2) %>% filter(diff == "YES")
head(z.sc.3)
nrow(z.sc.3) #2893
z.sc.4 <- z.sc.3[,-c(8:10)]
head(z.sc.4)
nrow(z.sc.4)
m.z.sc.4 <- matrix.please(z.sc.4)
library(gplots)
heatmap.2(m.z.sc.4, scale = "row", col = bluered(100), trace = "none", density.info = "none")
heatmap <- heatmap.2(m.z.sc.4, scale = "row", col = bluered(100), trace = "none", density.info = "none")
library(xlsx)

genes.list <- as.data.frame(heatmap$carpet)
class(genes.list)
write.xlsx(genes.list, "2.8k_RP_genes.xlsx")

#YESSSS
#convert mouse gene names to human gene names
#create  a vector with mouse gene names
musGenes.RP.sgAR.SPOP.down <- pull(z.sc.4, "genes.z.sc.1")
write(musGenes.RP.sgAR.SPOP.down, "musGenes.RP.sgAR.SPOP.down.txt")
length(musGenes.RP.sgAR.SPOP.down)
#convert to human genes
convertMouseGeneList <- function(x){
  require("biomaRt")
  human = useMart("ensembl", dataset = "hsapiens_gene_ensembl")
  mouse = useMart("ensembl", dataset = "mmusculus_gene_ensembl")
  genesV2 = getLDS(attributes = c("mgi_symbol"), filters = "mgi_symbol", values = x , mart = mouse, attributesL = c("hgnc_symbol"), martL = human, uniqueRows=T)
  humanx <- unique(genesV2[, 2])
  # Print the first 6 genes found to the screen
  print(head(humanx))
  return(humanx)
}

hsGenes.RP.sgAR.SPOP.down <- convertMouseGeneList(musGenes.RP.sgAR.SPOP.down )
length(hsGenes.RP.sgAR.SPOP.down ) #2043

write(hsGenes.RP.sgAR.SPOP.down, "hsGenes.RP.sgAR.SPOP.down.txt")

#test these mouse genes in Carver dataset
dir()
Carver <- read.csv("Carver.csv")
head(Carver)
str(Carver)
head(z.sc.4)
class(z.sc.4)
z.sc.4.Carver <- z.sc.4 %>% filter( genes.z.sc.1  %in% Carver$Symbol)
str(z.sc.4.Carver)
matrix.z.sc.4.Carver <- matrix.please(z.sc.4.Carver)
heatmap.2(matrix.z.sc.4.Carver, scale = "row", col = bluered(100), trace = "none", density.info = "none")

#test this genes among theresult sof DESEQ
dir()
sgAR.SPOP_sgNT.SPOP <- read.csv("DEGmouse.csv")  
head(sgAR.SPOP_sgNT.SPOP)
signif <- sgAR.SPOP_sgNT.SPOP %>% filter(padj <= 0.05)
str(signif)
z.sc.4.sgAR.SPOP_sgNT.SPOP <- z.sc.4 %>% filter( genes.z.sc.1  %in% signif$Symbol)
nrow(z.sc.4.sgAR.SPOP_sgNT.SPOP )
matrix.z.sc.4.sgAR.SPOP_sgNT.SPOP <- matrix.please(z.sc.4.sgAR.SPOP_sgNT.SPOP)
heatmap.2(matrix.z.sc.4.sgAR.SPOP_sgNT.SPOP , scale = "row", col = bluered(100), trace = "none", density.info = "none")
#RP full downregul is sgAR SPOPmut
