ATAC-seq analysis (from reads to peaks)
#only for one sample (SPOP mutant organoids treated with DHT)
#performed on the cluster maintained by Scientific Computing Unit (Weill Cornell Medicine)

#fastq files from Read 1 and Read 2 belonging to the same sampple were merged

$ cat X_S15_L003_R1_001.fastq.gz X_S15_L004_R1_001.fastq.gz X_S20_L001_R1_001.fastq.gz > X_R1.fastq.gz 

$ cat X_S15_L003_R2_001.fastq.gz X_S15_L004_R2_001.fastq.gz X_S20_L001_R2_001.fastq.gz > X_R2.fastq.gz

#FASTQC
fastqc X_R1.fastq.gz X_R2.fastq.gz -o ../FASTQC


#Alignment (performed on WCM SCU sluster)

spack load bowtie2@2.3.4.1


bowtie2 index: in in the  /home/ivg2005/barbierilab_store_ivg2005/1605_cells/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index

bowtie2  --very-sensitive  -k 10  -x /home/ivg2005/barbierilab_store_ivg2005/1605_cells/Mus_musculus/UCSC/mm10/Sequence/Bowtie2Index/genome  -1 X_R1.fastq.gz   -2 X_R2.fastq.gz  -p 8  \
  |  samtools view  -u  -  \
  |  samtools sort  -n  -o X.bam  -



#Sorting and indexing with SAMtools
spack load samtools@1.8 

samtools sort -o X.bam.sorted.bam X.bam 
samtools index -b X.bam.sorted.bam X.bam.sorted.bam.bai   ###u biti sam indeksiranje trebala sacuvati za nakon removala svih mitohondrial reads, non-unique reads and duplicates. OVako trebam ponovno

# Remove multi-mapped reads (i.e. those with MAPQ < 30, using -q in SAMtools)
samtools view -h -q 30 X.bam.sorted.bam > X.bam.sorted.bam.Unq.bam


#ploting Fragment/Insert size

samtools view  X.bam.sorted.bam.Unq.bam  | awk '$9>0' | cut -f 9 | sort | uniq -c | sort -b -k2,2n | sed -e 's/^[ \t]*//' > X.bam.sorted.bam.Unq.bam_fragment_length_count.txt

#In the output, the 2nd column is the fragment length, and the 1st column is the counts. Open “fragment_length_count.txt” with Excel, and simply plot the 2nd column against the 1st column

#Removal of the PCR duplicates with SAMtools

samtools view -h -b -F 1024 X.bam.sorted.bam.Unq.bam   > X.bam.sorted.bam.Unq.bam.rmDup.bam

#calculating the percentage of the mitochondrial reads

mtReads=$(samtools idxstats X.bam.sorted.bam  | grep 'chrM' | cut -f 3)
totalReads=$(samtools idxstats X.bam.sorted.bam  | awk '{SUM += $3} END {print SUM}')
echo '==> mtDNA Content:' $(bc <<< "scale=2;100*$mtReads/$totalReads")'%'
==> mtDNA Content: 12.45%

#removal of the mitochondrial reads

samtools view -h X.bam.sorted.bam.Unq.bam.rmDup.bam | grep -v chrM | samtools sort  -O bam > X.bam.sorted.bam.Unq.bam.rmDup.bam.rmChrM.bam

#create an index
samtools index -b X.bam.sorted.bam.Unq.bam.rmDup.bam > X.bam.sorted.bam.Unq.bam.rmDup.bam.bai


#create bigwig files with Deeptools

bamCoverage \
--bam X.bam.sorted.bam.Unq.bam.rmDup.bam  -o SPOP_DHT_rep3.bw \
--outFileFormat bigwig \
--binSize 10 \
--normalizeUsing RPGC \
--effectiveGenomeSize 2652783500 \
--ignoreDuplicates \
--minMappingQuality 10

#calculate the coverage at the Transcription start sites


computeMatrix reference-point \
-S  SPOP_DHT/SPOP_DHT_rep3.bw \
-R /home/ivg2005/barbierilab_store_ivg2005/mm10_RefSEq_TSS.bed.txt \
--referencePoint center \
-a 1000 -b 1000 \
-out matrix_TSS.tab.gz \
--verbose


 plotHeatmap \
 -m matrix_TSS.tab.gz \
 -out ATAC_TSS.png \
 --heatmapHeight 15  \
 --refPointLabel TSS \
 --regionsLabel TSS \
 --plotTitle 'Accessibility_TSS'


#peak calling with Genrich
#bam file needs to be sorted with samtools sort -n


/home/ivg2005/barbierilab_store_ivg2005/Genrich-master/Genrich -t X.bam  -o SPOP_DHT_rep3_peaks  -j  -y  -r  -e chrM  -v 
Peaks identified: 66532


#calculating the fraction of reads in peaks score (FRiP)
spack load samtools@1.8 
samtools view -c X.bam.sorted.bam.Unq.bam.rmDup.bam.rmChrM.bam > `basename $f`.total_reads


spack load bedtools2@2.27
# reads in peaks
bedtools sort -i X_peaks | bedtools merge -i stdin | bedtools intersect -u -nonamecheck -a X.bam.sorted.bam.Unq.bam.rmDup.bam.rmChrM.bam -b stdin -ubam | samtools view -c > X_reads_in_peaks


#Vizualisation of the bigwigs in Genome Browser
#bigwigs are uploaded to Amazon S3 and made public
https://aws.amazon.com/s3/

#added to Genome Browser session
track color=0,0,255 name="ATAC_SPOPmut(DHT).rep3" description="mouse prostate organoids_ATAC" type=bigWig visibility=full bigDataUrl=https://androgenreceptorchip.s3.us-east-2.amazonaws.com/SPOPmut_DHT_rep3.bw








