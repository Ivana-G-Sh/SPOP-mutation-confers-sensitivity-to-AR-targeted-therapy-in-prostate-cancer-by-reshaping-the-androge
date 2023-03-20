FOXA1_ChIP_Seq

#1) pascal
#2) curie - samo sa curie mozes submitati sa #slurm
#3) sa curie na panda - taj node je jedini slobodan za nas



ssh ivg2005@pascal.med.cornell.edu
IvanaGrbesa1981@

ssh ivg2005@curie.pbtech
IvanaGrbesa1981@

Starting an interactive session:
srun -n1 --pty --partition=panda --mem=100G bash -i

make a new dir:

directory:
cd barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/

ivg2005@node102 ~/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2
$ mkdir FOXA1

ivg2005@node102 ~/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2
$ cd FOXA1

Transfer fastq files to that directory:
server ip: gc-sftp.med.cornell.edu (sftp connection )
username: Guest1
password: Wjr9HZ

Ivanna7411_2019_06_03

ivg2005@node102 ~/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1
$ sftp Guest1@gc-sftp.med.cornell.edu
Password: 
Connected to gc-sftp.med.cornell.edu.
sftp> ls
data  
sftp> cd data
sftp> ls
Ivanna7411_2019_06_03  
sftp> cd Ivanna7411_2019_06_03
sftp> ls
10_S7_R1_001.fastq.gz      12_S8_R1_001.fastq.gz      13_S9_R1_001.fastq.gz      14_S10_R1_001.fastq.gz     15_S11_R1_001.fastq.gz     16_S12_R1_001.fastq.gz     18_S13_R1_001.fastq.gz     
19_S14_R1_001.fastq.gz     1_S1_R1_001.fastq.gz       21_S15_R1_001.fastq.gz     22_S16_R1_001.fastq.gz     25_S17_R1_001.fastq.gz     27_S18_R1_001.fastq.gz     3_S2_R1_001.fastq.gz       
4_S3_R1_001.fastq.gz       6_S4_R1_001.fastq.gz       7_S5_R1_001.fastq.gz       9_S6_R1_001.fastq.gz       Summary                    
sftp> sftp> mget *.fastq.gz
Invalid command.
sftp>  mget *.fastq.gz
Fetching /data/Ivanna7411_2019_06_03/10_S7_R1_001.fastq.gz to 10_S7_R1_001.fastq.gz
...
exit

ivg2005@node102 ~/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1
$ ls
10_S7_R1_001.fastq.gz  14_S10_R1_001.fastq.gz  18_S13_R1_001.fastq.gz  21_S15_R1_001.fastq.gz  27_S18_R1_001.fastq.gz  6_S4_R1_001.fastq.gz
12_S8_R1_001.fastq.gz  15_S11_R1_001.fastq.gz  19_S14_R1_001.fastq.gz  22_S16_R1_001.fastq.gz  3_S2_R1_001.fastq.gz    7_S5_R1_001.fastq.gz
13_S9_R1_001.fastq.gz  16_S12_R1_001.fastq.gz  1_S1_R1_001.fastq.gz    25_S17_R1_001.fastq.gz  4_S3_R1_001.fastq.gz    9_S6_R1_001.fastq.gz

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Summary~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#lokalni komp: /Volumes/Seagate/FOXA1_2019
#downloadala direkto sa emaila

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Encode pipeline~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
~~~~~~~~~~~~~~~~~JSON file
#lokalno
#zato cu napraviti sve u sublime text i sejvati - modificirala 

#FOXA1_Control_EtOH.json
#IP: 4, 6
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/4_S3_R1_001.fastq.gz
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/6_S4_R1_001.fastq.gz

#input: 1, 3
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/1_S1_R1_001.fastq.gz 
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/3_S2_R1_001.fastq.gz

{
    "chip.pipeline_type" : "tf",
    "chip.genome_tsv" : "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/genome_data_mm10/mm10.tsv",

    "chip.fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/4_S3_R1_001.fastq.gz" ],
    "chip.fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/6_S4_R1_001.fastq.gz" ],

    "chip.ctl_fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/1_S1_R1_001.fastq.gz" ],
    "chip.ctl_fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/3_S2_R1_001.fastq.gz" ],

    "chip.paired_end" : false,

    "chip.always_use_pooled_ctl" : true,
    "chip.title" : "FOXA1_Control_EtOH_2019",
    "chip.description" : "FOXA1_Control_EtOH",
    "chip.peak_caller" : "macs2",
    "chip.pval_tresh" : 0.05
}

#FOXA1_Control_DHT.json
#IP: 10, 12
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/10_S7_R1_001.fastq.gz
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/12_S8_R1_001.fastq.gz

#input: 7, 9
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/7_S5_R1_001.fastq.gz
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/9_S6_R1_001.fastq.gz

{
    "chip.pipeline_type" : "tf",
    "chip.genome_tsv" : "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/genome_data_mm10/mm10.tsv",

    "chip.fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/10_S7_R1_001.fastq.gz" ],
    "chip.fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/12_S8_R1_001.fastq.gz" ],

    "chip.ctl_fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/7_S5_R1_001.fastq.gz" ],
    "chip.ctl_fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/9_S6_R1_001.fastq.gz" ],

    "chip.paired_end" : false,

    "chip.always_use_pooled_ctl" : true,
    "chip.title" : "FOXA1_Control_DHT_2019",
    "chip.description" : "FOXA1_Control_DHT",
    "chip.peak_caller" : "macs2",
    "chip.pval_tresh" : 0.05
}

#FOXA1_SPOPmut_EtOH.json
#IP: 16, 18, 19
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/16_S12_R1_001.fastq.gz
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/18_S13_R1_001.fastq.gz
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/19_S14_R1_001.fastq.gz

#input: 13, 14, 15
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/13_S9_R1_001.fastq.gz
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/14_S10_R1_001.fastq.gz
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/15_S11_R1_001.fastq.gz

{
    "chip.pipeline_type" : "tf",
    "chip.genome_tsv" : "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/genome_data_mm10/mm10.tsv",

    "chip.fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/16_S12_R1_001.fastq.gz" ],
    "chip.fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/18_S13_R1_001.fastq.gz" ],
    "chip.fastqs_rep3_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/19_S14_R1_001.fastq.gz" ],

    "chip.ctl_fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/13_S9_R1_001.fastq.gz" ],
    "chip.ctl_fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/14_S10_R1_001.fastq.gz" ], 
    "chip.ctl_fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/15_S11_R1_001.fastq.gz" ],   #tu sam pogrijesila jer nisam stavila da je rep3

    "chip.paired_end" : false,

    "chip.always_use_pooled_ctl" : true,
    "chip.title" : "FOXA1_SPOPmut_EtOH.json",
    "chip.description" : "FOXA1_SPOPmut_EtOH",
    "chip.peak_caller" : "macs2",
    "chip.pval_tresh" : 0.05
}


#FOXA1_SPOPmut_DHT.json
#IP: 21, 22
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/21_S15_R1_001.fastq.gz
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/22_S16_R1_001.fastq.gz

#INPUT: 25, 27
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/25_S17_R1_001.fastq.gz
/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/27_S18_R1_001.fastq.gz

{
    "chip.pipeline_type" : "tf",
    "chip.genome_tsv" : "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/genome_data_mm10/mm10.tsv",

    "chip.fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/21_S15_R1_001.fastq.gz" ],
    "chip.fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/22_S16_R1_001.fastq.gz" ],

    "chip.ctl_fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/25_S17_R1_001.fastq.gz" ],
    "chip.ctl_fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/27_S18_R1_001.fastq.gz" ],

    "chip.paired_end" : false,

    "chip.always_use_pooled_ctl" : true,
    "chip.title" : "FOXA1_SPOPmut_DHT.json",
    "chip.description" : "FOXA1_SPOPmut_DHT",
    "chip.peak_caller" : "macs2",
    "chip.pval_tresh" : 0.05
}
##KRIVO - zamjena input i IP samples

{
    "chip.pipeline_type" : "tf",
    "chip.genome_tsv" : "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/genome_data_mm10/mm10.tsv",

    "chip.fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/25_S17_R1_001.fastq.gz" ],
    "chip.fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/27_S18_R1_001.fastq.gz" ],

    "chip.ctl_fastqs_rep1_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/21_S15_R1_001.fastq.gz" ],
    "chip.ctl_fastqs_rep2_R1" : [ "/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/FOXA1/22_S16_R1_001.fastq.gz" ],

    "chip.paired_end" : false,

    "chip.always_use_pooled_ctl" : true,
    "chip.title" : "FOXA1_SPOPmut_DHT.json",
    "chip.description" : "FOXA1_SPOPmut_DHT",
    "chip.peak_caller" : "macs2",
    "chip.pval_tresh" : 0.05
}


#u terminalu
(base) MAC202969:~ ivana$ cd /Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE

(base) MAC202969:ENCODE_PIPELINE ivana$ ls
FOXA1_Control_DHT.json	FOXA1_Control_EtOH.json	FOXA1_SPOPmut_DHT.json	FOXA1_SPOPmut_EtOH.json

scp *.json ivg2005@pascal.med.cornell.edu:/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/examples/local

IvanaGrbesa1981@
scp FOXA1_SPOPmut_DHT.json ivg2005@pascal.med.cornell.edu:/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/examples/local


#Na clusteru:

#allocate 100G of space:

ssh ivg2005@pascal.med.cornell.edu
IvanaGrbesa1981@

ssh ivg2005@curie.pbtech

Starting an interactive session:
srun -n1 --pty --partition=panda --mem=100G bash -i

source activate encode-chip-seq-pipeline 

cd /home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2

INPUT=examples/local/FOXA1_Control_DHT.json
java -jar -Dconfig.file=backends/backend.conf cromwell-34.jar run chip.wdl -i ${INPUT}

INPUT=examples/local/FOXA1_Control_EtOH.json
java -jar -Dconfig.file=backends/backend.conf cromwell-34.jar run chip.wdl -i ${INPUT}

INPUT=examples/local/FOXA1_SPOPmut_EtOH.json
java -jar -Dconfig.file=backends/backend.conf cromwell-34.jar run chip.wdl -i ${INPUT}

INPUT=examples/local/FOXA1_SPOPmut_DHT.json
java -jar -Dconfig.file=backends/backend.conf cromwell-34.jar run chip.wdl -i ${INPUT}

###
#FOXA1_Control_DHT
#"id": "9432f488-206f-4cc0-8a4b-0bfd615970da"

#FOXA1_SPOPmut_EtOH
#"id": "61f3ae3c-a94a-4d92-a173-74f6c9af10d9"

#FOXA1_Control_EtOH
#"id": "f2e5a9e4-67f0-4520-b814-bfe068011dca"

#FOXA1_SPOPmut_DHT
#"id": "39c7b93e-ff4b-4fbd-b8a6-5c102a865d27"

#Download data /odi na lokalni terminal
cd /Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE
mkdir FOXA1_Control_DHT 
scp -r ivg2005@pascal.med.cornell.edu:/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/cromwell-executions/chip/9432f488-206f-4cc0-8a4b-0bfd615970da .
IvanaGrbesa1981@

#New Terminal Window
cd /Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE
mkdir FOXA1_SPOPmut_EtOH 
scp -r ivg2005@pascal.med.cornell.edu:/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/cromwell-executions/chip/61f3ae3c-a94a-4d92-a173-74f6c9af10d9 .
IvanaGrbesa1981@

#New Terminal Window
cd /Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE
mkdir FOXA1_Control_EtOH
scp -r ivg2005@pascal.med.cornell.edu:/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/cromwell-executions/chip/f2e5a9e4-67f0-4520-b814-bfe068011dca . 
IvanaGrbesa1981@

#nesto ne valja sa SPOPmut_DHT
scp -r ivg2005@pascal.med.cornell.edu:/home/ivg2005/barbierilab_store_ivg2005/encode-chip-seq-pipeline2/chip-seq-pipeline2/cromwell-executions/chip/39c7b93e-ff4b-4fbd-b8a6-5c102a865d27 . 
IvanaGrbesa1981@

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Replicate concordance~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vidi QC 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~DeepTools~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
source activate bioinfo

dir: /Volumes/Seagate/FOXA1_2019/DeepTools

#nikako nije mogao prepoznati fajlove tako da sam sve bam preimenovala i prebacilau depptools direktorij

#odi u call filter za svaki IP uzorak - mislim da inputi nisu toliko bitni
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_EtOH/call-filter/shard-0/execution/4_S3_R1_001.merged.nodup.bam 
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_EtOH/call-filter/shard-1/execution/6_S4_R1_001.merged.nodup.bam 
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_DHT/Ctrl_DHT/call-filter/shard-0/execution/10_S7_R1_001.merged.nodup.bam 
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_DHT/Ctrl_DHT/call-filter/shard-1/execution/12_S8_R1_001.merged.nodup.bam 
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_EtOH/call-filter/shard-0/execution/16_S12_R1_001.merged.nodup.bam
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_EtOH/call-filter/shard-2/execution/19_S14_R1_001.merged.nodup.bam 
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_DHT/SPOPmut_DHT/call-filter/shard-0/execution/25_S17_R1_001.merged.nodup.bam
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_DHT/SPOPmut_DHT/call-filter/shard-1/execution/27_S18_R1_001.merged.nodup.bam

(bioinfo) MAC202969:DeepTools ivana$ ls
10.bam  12.bam  16.bam  19.bam  25.bam  27.bam  4.bam   6.bam

#takodjer trebas prebaciti njihove indeks bai

multiBamSummary bins \
--bamfiles  4.bam 6.bam 10.bam 12.bam 16.bam 19.bam 25.bam 27.bam \
--minMappingQuality 30 \
--ignoreDuplicates \
--labels Control.EtOH.rep1 Control.EtOH.rep2 Control.DHT.rep1 Control.DHT.rep2 SPOPmutant.EtOH.rep1 SPOPmutant.EtOH.rep2 SPOPmutant.DHT.rep1 SPOPmutant.DHT.rep2 \
--verbose \
-o multiBamSummary_results.npz --outRawCounts readCounts.tab

##dakle ostavila sam bin 10kb ipak to je misji genom, specificirala sam bam fajlove koji imaju u istom folderu i indeksirane bam fajlove tj bai, zatim min maping quality da je 30, da ignorira duplikate ako ih ima, da specificira oznake - kasnije bitno kad izradjujes heatmaps i PCA plots, zatim verbose da mi kaze sto radi i outpute

#davao je error: The index file is older than the data file: 4.bam.bai no nastavio e raditi



##heatmap

#"/Users/Ivana/miniconda3/envs/bioinfo/bin/plotCorrelation

#sejvala kao eps jer ga kasnije mogu otvoriti u illustratoru

plotCorrelation \
-in multiBamSummary_results.npz \
--corMethod spearman --skipZeros \
--plotTitle "Spearman correlation of read counts_FOXA1_ChIP" \
--whatToPlot heatmap --colorMap RdYlBu --plotNumbers \
-o heatmap_Sperman_readCounts.eps \
--outFileCorMatrix SpearmanCorr_readCounts.tab

#ok uzorci nisu zamijenjeni, sve je kao po spagi
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Genome Browser session~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#Bigwig: fold over control for each replica

#fajlovi:
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_EtOH/call-macs2/shard-0/execution/4_S3_R1_001.merged.nodup_x_ctl_for_rep1.fc.signal.bigwig
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_EtOH/call-macs2/shard-1/execution/6_S4_R1_001.merged.nodup_x_ctl_for_rep2.fc.signal.bigwig
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_DHT/Ctrl_DHT/call-macs2/shard-0/execution/10_S7_R1_001.merged.nodup_x_ctl_for_rep1.fc.signal.bigwig
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_DHT/Ctrl_DHT/call-macs2/shard-1/execution/12_S8_R1_001.merged.nodup_x_ctl_for_rep2.fc.signal.bigwig
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_DHT/SPOPmut_DHT/call-macs2/shard-0/execution/25_S17_R1_001.merged.nodup_x_ctl_for_rep1.fc.signal.bigwig
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_DHT/SPOPmut_DHT/call-macs2/shard-1/execution/27_S18_R1_001.merged.nodup_x_ctl_for_rep2.fc.signal.bigwig 
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_EtOH/call-macs2/shard-0/execution/16_S12_R1_001.merged.nodup_x_ctl_for_rep1.fc.signal.bigwig
/Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_EtOH/call-macs2/shard-2/execution/19_S14_R1_001.merged.nodup_x_ctl_for_rep3.fc.signal.bigwig

#uploadaj na Amazon server:
https://aws.amazon.com/s3/

#zasebno replike:
track color=255,0,0 name="Control(EtOH).rep1" description="mouse prostate organoids FOXA1_Control(EtOH).rep1" type=bigWig visibility=full bigDataUrl=https://androgenreceptorchip.s3.us-east-2.amazonaws.com/4.bigwig
track color=255,0,0 name="Control(EtOH).rep2" description="mouse prostate organoids FOXA1_Control(EtOH).rep2" type=bigWig visibility=full bigDataUrl=https://androgenreceptorchip.s3.us-east-2.amazonaws.com/6.bigwig

track color=255,0,0 name="FOXA1_Control(DHT).rep1" description="mouse prostate organoids FOXA1_Control(DHT).rep1" type=bigWig visibility=full bigDataUrl=https://androgenreceptorchip.s3.us-east-2.amazonaws.com/10.bigwig
track color=255,0,0 name="FOXA1_Control(DHT).rep2" description="mouse prostate organoids FOXA1_Control(DHT).rep2" type=bigWig visibility=full bigDataUrl=https://androgenreceptorchip.s3.us-east-2.amazonaws.com/12.bigwig

track color=255,0,0 name="FOXA1_SPOPmut(EtOH).rep1" description="mouse prostate organoids FOXA1_SPOPmut(EtOH).rep1" type=bigWig visibility=full bigDataUrl=https://androgenreceptorchip.s3.us-east-2.amazonaws.com/16.bigwig
track color=255,0,0 name="FOXA1_SPOPmut(EtOH).rep2" description="mouse prostate organoids FOXA1_SPOPmut(EtOH).rep2" type=bigWig visibility=full bigDataUrl=https://androgenreceptorchip.s3.us-east-2.amazonaws.com/19.bigwig

track color=255,0,0 name="FOXA1_SPOPmut(DHT).rep1" description="mouse prostate organoids FOXA1_SPOPmut(DHT).rep1" type=bigWig visibility=full bigDataUrl=https://androgenreceptorchip.s3.us-east-2.amazonaws.com/25.bigwig
track color=255,0,0 name="FOXA1_SPOPmut(DHT).rep2" description="mouse prostate organoids FOXA1_SPOPmut(DHT).rep2" type=bigWig visibility=full bigDataUrl=https://androgenreceptorchip.s3.us-east-2.amazonaws.com/27.bigwig

#link:
https://genome.ucsc.edu/cgi-bin/hgTracks?db=mm10&lastVirtModeType=default&lastVirtModeExtraState=&virtModeType=default&virtMode=0&nonVirtPosition=&position=chr17%3A26247560-26873109&hgsid=730044835_vaCflzXEFrKsd4kndxM2ru03j0WP

mm10


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~IDR peaks~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Preskocila i uzela IDR peaks

#Nemoj gledati sve peaks called by MACS nego optimal IDR peaks
#na qc_html report: Reproducibility QC and peak detection statistics: 
#Nt: True Replicate consisten overlapping peaks (comparing true replicates Rep1 vs Rep2 

# /Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_EtOH/call-idr/shard-0/execution/rep1-rep2.idr0.05.bfilt.narrowPeak 
# /Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_Control_DHT/Ctrl_DHT/call-idr/shard-0/execution/rep1-rep2.idr0.05.bfilt.narrowPeak
# /Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_DHT/SPOPmut_DHT/call-idr/shard-0/execution/rep1-rep2.idr0.05.bfilt.narrowPeak

#Problem je sto u SPOPmut_EtOH imamo tri replike tako da sam imam tri opcje za IDR peaks - kad apogledam na QC rezultate: na fingerprint and Jensen-Shannon distance - kad pogledam na graf onda je narancasta linija tj replika 2 malo drukcija tako da ju izbacujem tako da cu koristiti replika 1- replika 3
# /Volumes/Seagate/FOXA1_2019/ENCODE_PIPELINE/FOXA1_SPOPmut_EtOH/call-idr/shard-1.rep1_rep3/execution/rep1-rep3.idr0.05.bfilt.narrowPeak 


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Genomic Region annotation~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
source activate bioinfo

# mkdir Genomic_annotation
# /Volumes/Seagate/FOXA1_2019/Genomic_annotation

#copied here IDR  peaks from all the samples and renamed them
mv rep1-rep2.idr0.05.bfilt.narrowPeak /Volumes/Seagate/FOXA1_2019/Genomic_annotation
#rename
(bioinfo) MAC202969:execution ivana$ cd /Volumes/Seagate/FOXA1_2019/Genomic_annotation
(bioinfo) MAC202969:Genomic_annotation ivana$ ls
rep1-rep2.idr0.05.bfilt.narrowPeak
(bioinfo) MAC202969:Genomic_annotation ivana$ mv rep1-rep2.idr0.05.bfilt.narrowPeak FOXA1_Control_EtOH_IDR.narrowPeak

(bioinfo) MAC202969:Genomic_annotation ivana$ ls
FOXA1_Control_DHT_IDR.narrowPeak    FOXA1_Control_EtOH_IDR.narrowPeak   FOXA1_SPOPmut_DHT.narrowPeak        FOXA1_SPOPmut_EtOH.narrowPeak

PATH=$PATH:/Users/Ivana/bin/

annotatePeaks.pl FOXA1_Control_DHT_IDR.narrowPeak  mm10 -go GO_Control_DHT -genomeOntology genome_Control_DHT -annStats Stats_Control_DHT > Annotated_Control_DHT.txt

    Peak file = FOXA1_Control_DHT_IDR.narrowPeak
    Genome = mm10
    Organism = mouse
    Will perform Gene Ontology analysis - output to directory = GO_Control_DHT
    Will perform Genome Ontology analysis - output to directory = genome_Control_DHT
        Warning - might want to set the genome size with -gsize (currently 2000000000)
    Peak/BED file conversion summary:
        BED/Header formatted lines: 32749
        peakfile formatted lines: 0
        Duplicated Peak IDs: 32748

    Peak File Statistics:
        Total Peaks: 32749
        Redundant Peak IDs: 0
        Peaks lacking information: 0 (need at least 5 columns per peak)
        Peaks with misformatted coordinates: 0 (should be integer)
        Peaks with misformatted strand: 0 (should be either +/- or 0/1)

    Peak file looks good!


annotatePeaks.pl FOXA1_Control_EtOH_IDR.narrowPeak  mm10 -go GO_Control_EtOH -genomeOntology genome_Control_EtOH -annStats Stats_Control_EtOH > Annotated_Control_EtOH.txt

    Peak file = FOXA1_Control_EtOH_IDR.narrowPeak
    Genome = mm10
    Organism = mouse
    Will perform Gene Ontology analysis - output to directory = GO_Control_EtOH
    Will perform Genome Ontology analysis - output to directory = genome_Control_EtOH
        Warning - might want to set the genome size with -gsize (currently 2000000000)
    Peak/BED file conversion summary:
        BED/Header formatted lines: 21858
        peakfile formatted lines: 0
        Duplicated Peak IDs: 21857

    Peak File Statistics:
        Total Peaks: 21858
        Redundant Peak IDs: 0
        Peaks lacking information: 0 (need at least 5 columns per peak)
        Peaks with misformatted coordinates: 0 (should be integer)
        Peaks with misformatted strand: 0 (should be either +/- or 0/1)

    Peak file looks good!

cd /Volumes/Seagate/FOXA1_2019/Genomic_annotation
annotatePeaks.pl FOXA1_SPOPmut_DHT.narrowPeak   mm10 -go GO_SPOPmut_DHT -genomeOntology genome_SPOPmut_DHT -annStats Stats_SPOPmut_DHT > Annotated_SPOPmut_DHT.txt

annotatePeaks.pl FOXA1_SPOPmut_EtOH.narrowPeak   mm10 -go GO_SPOPmut_EtOH -genomeOntology genome_SPOPmut_EtOH -annStats Stats_SPOPmut_EtOH > Annotated_SPOPmut_EtOH.txt

#treba u Rmd fajlu prikazati - prvo sumariziral au excellu i onda u R sa ggplot stacked barplot

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Motif analysis~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
cd /Volumes/Seagate/FOXA1_2019/Homer_motifs

(bioinfo) MAC202969:Homer_motifs ivana$ ls
Control_DHT Control_EtOH    SPOPmut_DHT SPOPmut_EtOH

cd Control_DHT

findMotifsGenome.pl Control_consensus.bed.txt mm10r peakAnalysis -size 200 

(bioinfo) MAC202969:Control_DHT ivana$ ls
FOXA1_Control_DHT_IDR.narrowPeak

PATH=$PATH:/Users/Ivana/bin/
findMotifsGenome.pl FOXA1_Control_DHT_IDR.narrowPeak mm10r peakAnalysis -size 200 

PATH=$PATH:/Users/Ivana/bin/
findMotifsGenome.pl FOXA1_Control_EtOH_IDR.narrowPeak mm10r peakAnalysis -size 200 

(bioinfo) MAC202969:SPOPmut_DHT ivana$ ls
FOXA1_SPOPmut_DHT.narrowPeak
PATH=$PATH:/Users/Ivana/bin/
findMotifsGenome.pl FOXA1_SPOPmut_DHT.narrowPeak mm10r peakAnalysis -size 200 

(bioinfo) MAC202969:SPOPmut_EtOH ivana$ ls
FOXA1_SPOPmut_EtOH.narrowPeak
findMotifsGenome.pl FOXA1_SPOPmut_EtOH.narrowPeak mm10r peakAnalysis -size 200 

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Incidence of FOXA1 motif in samples~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

cd /Volumes/Seagate/FOXA1_2019/FOXA1_MOTIF_INCIDENCE

(bioinfo) MAC202969:FOXA1_MOTIF_INCIDENCE ivana$ ls
FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed     FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed    FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed     FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed

motifs for FoxA1 (no 1):  /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known1.motif


PATH=$PATH:/Users/Ivana/bin/

annotatepeaks.pl FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed  mm10 -size 1000 -hist 5 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known1.motif > FOXA1_Control_DHT.bed 
annotatepeaks.pl FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed  mm10 -size 1000 -hist 5 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known1.motif > FOXA1_Control_EtOH.bed 
annotatepeaks.pl FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed  mm10 -size 1000 -hist 5 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known1.motif > FOXA1_SPOPmut_DHT.bed 
annotatepeaks.pl FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed  mm10 -size 1000 -hist 5 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known1.motif > FOXA1_SPOPmut_EtOH.bed 


#sve skup au jedan excell file pa u Prism


Mozda bi trebala intersect sa AR peaks koje sam izanalizirala prije i onda napraviti istu analizu - napravila u DeepTools




~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Intervene: heatmap~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#overlap between H3K4me2, Ar and FOXA1?
#so put all the bed files in the common directory

cd /Volumes/Seagate/FOXA1_2019/Intervene

FOXA1_Control_DHT_IDR.narrowPeak
FOXA1_Control_EtOH_IDR.narrowPeak
FOXA1_SPOPmut_DHT.narrowPeak
FOXA1_SPOPmut_EtOH.narrowPeak

(bioinfo) MAC202969:Intervene ivana$ head FOXA1_Control_DHT_IDR.narrowPeak
chr5    143544551   143546650   .   1000    .   82.74684    675.25415   666.59680   1570
chr4    120515822   120518092   .   1000    .   84.40601    673.98511   665.59100   824
chr19   29474900    29475996    .   1000    .   58.90865    661.16833   653.53900   598
chr14   26510422    26511294    .   1000    .   95.63671    659.76489   652.15546   403
chr5    93296091    93297634    .   1000    .   72.59811    658.65771   651.08551   891
chr11   49190882    49192052    .   1000    .   82.97880    657.82794   650.26166   572
chr19   45483265    45484396    .   1000    .   68.06390    656.75385   649.28680   547
chr1    168597593   168599390   .   1000    .   82.40791    653.79907   646.51282   789
chr12   32464897    32466302    .   1000    .   64.36778    652.67065   645.43103   701
chr11   101699748   101701358   .   1000    .   60.71447    651.62598   644.43353   861
(bioinfo) MAC202969:Intervene ivana$ for f in *.narrowPeak

for f in *.narrowPeak
 do
     cut -f1,2,3 $f | sed 1d >`basename $f`.bed
 done

for f in *.narrowPeak.bed
 do 
     sort -k1,1 -k2,2n $f > `basename $f`.sorted.bed
 done

(bioinfo) MAC202969:Intervene ivana$ ls
Control_consensus.txt                   FOXA1_Control_EtOH_IDR.narrowPeak           FOXA1_SPOPmut_DHT.narrowPeak.bed            FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed
FOXA1_Control_DHT_IDR.narrowPeak            FOXA1_Control_EtOH_IDR.narrowPeak.bed           FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed     SPOPmut_consensus.txt
FOXA1_Control_DHT_IDR.narrowPeak.bed            FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed    FOXA1_SPOPmut_EtOH.narrowPeak
FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed     FOXA1_SPOPmut_DHT.narrowPeak                FOXA1_SPOPmut_EtOH.narrowPeak.bed
(bioinfo) MAC202969:Intervene ivana$ 

(bioinfo) MAC202969:Intervene ivana$ head Control_consensus.txt
"CHR"   "START" "END"   "ALL"
"chr1"  4798309 4798767 0.176
"chr1"  4857482 4857724 0.0435
"chr1"  5015339 5015847 0.446
"chr1"  5083059 5083438 0.0425
"chr1"  5710941 5711173 0.051
"chr1"  5909786 5910473 0.232
"chr1"  6102739 6103175 0.062
"chr1"  6188274 6189487 0.5005
"chr1"  6190646 6191016 0.2055



FOR AR - also IDR peaks
/Volumes/Seagate/AR_2019/ENCODE_PIPELINE/AR_Control_2019/call-idr/shard-2/execution/rep2-rep3.idr0.05.bfilt.narrowPeak preimenovala u AR_Control

For SPOPmut: 
 /Volumes/Seagate/AR_2019/ENCODE_PIPELINE/AR_SPOPmut_2019/call-idr/shard-0/execution/rep1-rep2.idr0.05.bfilt.narrowPeak

(bioinfo) MAC202969:Intervene ivana$ ls
AR_Control.narrowPeak.bed.sorted.bed            FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed     FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed
AR_SPOPmut.narrowPeak.bed.sorted.bed            FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed    FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed


ForH3K4me2 - isto IDR peaks

#IDR peaks: oliko imam je u  QC-reportu

H3K4me2_Control_DHT: 72402 
H3K4me2_Control_EtOH: 71228
H3K4me2_SPOPmut_DHT: 71784
H3K4me2_SPOPmut_EtOH: 76680

#Gdje su actual files: u call-reproducibility_overlap

#Gdje su fajlovi? : /Volumes/Seagate/H3K4me2_mouse_organoids_Nov2018/Encode_pipeline_mm10/H3K4me2_Control_DHT/output/call-reproducibility_overlap/execution/optimal_peak.narrowPeak

#Fajlove sam preimenovala i kopirala u Intervene folder:
(bioinfo) MAC202969:Intervene ivana$ ls
AR_Control.narrowPeak.bed.sorted.bed            FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed    H3K4me2_Control_DHT_IDR.narrowPeak          H3K4me2_SPOPmut_EtOH_IDR.narrowPeak
AR_SPOPmut.narrowPeak.bed.sorted.bed            FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed     H3K4me2_Control_EtOH_IDR.narrowPeak
FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed     FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed        H3K4me2_SPOPmut_DHT_IDR.narrowPeak


(bioinfo) MAC202969:Intervene ivana$ head H3K4me2_Control_DHT_IDR.narrowPeak
chr1    100150465   100150737   Peak_55407  66  .   4.50343 6.68330 5.01304 166
chr1    100170849   100172662   Peak_25758  299 .   12.07561    29.94133    27.82988    1040
chr1    100172747   100173804   Peak_30320  218 .   9.50754 21.89293    19.89706    525
chr1    100185030   100186470   Peak_23948  336 .   12.55894    33.60210    31.43615    317
chr1    100223648   100223877   Peak_61638  54  .   4.12531 5.46016 3.83145 161
chr1    100262393   100262715   Peak_64520  53  .   4.03949 5.32898 3.71515 100
chr1    10036079    10039709    Peak_4201   1000    .   20.84196    105.11885   101.60769   3037
chr1    10039917    10041181    Peak_11817  732 .   22.75704    73.23557    70.43964    377
chr1    100452689   100452975   Peak_59315  58  .   4.08642 5.86499 4.22145 128
chr1    100850768   100851067   Peak_68199  46  .   3.68169 4.67207 3.07955 50

#Kozmetika:
for f in *.narrowPeak
 do
     cut -f1,2,3 $f | sed 1d >`basename $f`.bed
 done

for f in *.narrowPeak.bed
 do 
     sort -k1,1 -k2,2n $f > `basename $f`.sorted.bed
 done

removed original files: rm *.narrowPeak *.narrowPeak.bed

(bioinfo) MAC202969:Intervene ivana$ ls -qaltr
total 22296
-rw-r--r--  1 ivana  staff  1045449 Jun 17 14:29 FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed
-rw-r--r--  1 ivana  staff   837018 Jun 17 14:29 FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed
-rw-r--r--  1 ivana  staff   522995 Jun 17 14:29 FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed
-rw-r--r--  1 ivana  staff   783913 Jun 17 14:29 FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed
-rw-r--r--  1 ivana  staff   527544 Jun 17 14:50 AR_SPOPmut.narrowPeak.bed.sorted.bed
-rw-r--r--  1 ivana  staff   468277 Jun 17 14:50 AR_Control.narrowPeak.bed.sorted.bed
-rw-r--r--  1 ivana  staff  1706982 Jun 19 10:05 H3K4me2_Control_EtOH_IDR.narrowPeak.bed.sorted.bed
-rw-r--r--  1 ivana  staff  1735566 Jun 19 10:05 H3K4me2_Control_DHT_IDR.narrowPeak.bed.sorted.bed
-rw-r--r--  1 ivana  staff  1837916 Jun 19 10:05 H3K4me2_SPOPmut_EtOH_IDR.narrowPeak.bed.sorted.bed
-rw-r--r--  1 ivana  staff  1720326 Jun 19 10:05 H3K4me2_SPOPmut_DHT_IDR.narrowPeak.bed.sorted.bed

intervene pairwise -i *.bed --filenames --compute frac --htype color

#...dao mi je nekakve poruke i erore no na kraju je upalilo

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Venns circles~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#Overlap AR peaks in Contrl DHT with FOXA1 peaks in Control in EtOH and DHT
#in pybed tools

cd /Volumes/Seagate/FOXA1_2019/Intervene

###COntrol

pybedtools venn_gchart

AR_Control.narrowPeak.bed.sorted.bed                

FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed  
FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed

  -h, --help       show this help message and exit
  -a A             File to use for the left-most circle
  -b B             File to use for the right-most circle
  -c C             File to use for the bottom circle
  --colors COLORS  Optional comma-separated list of hex colors for circles a,
                   b, and c. E.g. 00FF00,FF0000,0000FF
  --labels LABELS  Optional comma-separated list of labels for a, b, and c
  --size SIZE      Optional size of PNG, in pixels. Default is "300x300"
  -o O             Output file to save as, in PNG format
  --test           run test, overriding all other options.

pybedtools venn_gchart -a AR_Control.narrowPeak.bed.sorted.bed -b FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed -c FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed -o AR_FOXA1_Control.png #it is in png in the working folder


pybedtools venn_mpl
optional arguments:
  -h, --help       show this help message and exit
  -a A             File to use for the left-most circle
  -b B             File to use for the right-most circle
  -c C             File to use for the bottom circle
  --labels LABELS  Optional comma-separated list of labels for a, b, and c
  --colors COLORS  Comma-separated list of matplotlib-valid colors for circles
                   a, b, and c. E.g., --colors=r,b,k
  -o O             Output file to save as. Extension is meaningful, e.g.,
                   out.pdf, out.png, out.svg. Default is "out.png"
  --test           run test, overriding all other options.

pybedtools venn_mpl -a AR_Control.narrowPeak.bed.sorted.bed -b FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed -c FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed -o AR_FOXA1_Control.svg #this one is in the working folder, it is svggives you the nubers but is not proportional
(bioinfo) MAC202969:Intervene ivana$ WC -l AR_Control.narrowPeak.bed.sorted.bed
   19556 AR_Control.narrowPeak.bed.sorted.bed
(bioinfo) MAC202969:Intervene ivana$ wc -l FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed
   21857 FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed
(bioinfo) MAC202969:Intervene ivana$ wc -l FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed
   32748 FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed


####SPOPmut
AR_SPOPmut.narrowPeak.bed.sorted.bed 

FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed
FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed


#Onda u ilustratoru kombiniras oba grafa 
pybedtools venn_gchart -a AR_SPOPmut.narrowPeak.bed.sorted.bed  -b FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed -c FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed -o AR_FOXA1_SPOPmut.png

pybedtools venn_mpl -a AR_SPOPmut.narrowPeak.bed.sorted.bed  -b FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed -c FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed -o AR_FOXA1_SPOPmut.svg

(bioinfo) MAC202969:Intervene ivana$ wc -l AR_SPOPmut.narrowPeak.bed.sorted.bed
   22039 AR_SPOPmut.narrowPeak.bed.sorted.bed
(bioinfo) MAC202969:Intervene ivana$ wc -l FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed
   43652 FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed
(bioinfo) MAC202969:Intervene ivana$ wc -l FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed
   34969 FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed


~~~~~~~~~~~~~~~~~~~~~~CREATE A HEATMAP - CENTERED PEAKS NA FOXA1 MOTIF~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#with DeepTools

cd /Volumes/Seagate/FOXA1_2019/Heatmap

motifs for FoxA1 (no 1):  /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known1.motif

PATH=$PATH:/Users/Ivana/bin/
scanMotifGenomeWide.pl /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known1.motif mm10 -bed > FOXA1.sites.mm10.bed 

-create a heatmap of all peaks centered on FOXA1 motif

Prebacila ove fajlove: 
4_S3_R1_001.merged.nodup.pooled_x_1_S1_R1_001.merged.nodup.pooled.fc.signal.bigwig
10_S7_R1_001.merged.nodup.pooled_x_7_S5_R1_001.merged.nodup.pooled.fc.signal.bigwig
16_S12_R1_001.merged.nodup.pooled_x_13_S9_R1_001.merged.nodup.pooled.fc.signal.bigwig
25_S17_R1_001.merged.nodup.pooled_x_21_S15_R1_001.merged.nodup.pooled.fc.signal.bigwig

#i preimenovala

computeMatrix reference-point \
-S  Ctrl_DHT.bigwig Ctrl_EtOH.bigwig SPOPmut_DHT.bigwig  SPOPmut_EtOH.bigwig \
-R FOXA1.sites.mm10.bed \
--referencePoint center \
-a 500 -b 500 \
-out matrix_Peaks.FOXA1.motif.tab.gz

 plotHeatmap \
 -m matrix_Peaks.FOXA1.motif.tab.gz \
 -out Peaks.FOXA1.motif.png \
 --heatmapHeight 15  \
 --refPointLabel FOXA1 motif \
 --regionsLabel FOXA1 peaks \
 --plotTitle 'FOXA1 ChIP Signal'




~~~~~~~~~~~~~~~~~~~~~~~~~~~~FOXA1 signla na AR peaks
 #2 plots: 
regije su: AR specific peaks u kontroli: UP_Control.txt (nisam centrirala peakove na FOXA1 motif no mozda bi trebala)

bw files su: Ctrl_DHT.bigwig Ctrl_EtOH.bigwig

#zelim da od oba ref scale bude slicna pa trebam specificirati zmax i za plot koji su iznad heatmap trebam specificirati ymax da bude veci - htjela sam da za sve grup ebude jednako skalirano

computeMatrix reference-point \
-S Ctrl_DHT.bigwig Ctrl_EtOH.bigwig \
-R UP_Control.txt \
--referencePoint center \
-a 500 -b 500 \
-out AR_UP_Control_FOXA1_Control.tab.gz

 plotHeatmap \
 -m AR_UP_Control_FOXA1_Control.tab.gz \
 -out AR_Control_UP_FOXA1_peaks2.eps \
 --heatmapHeight 15  \
 --zMax 35 \
 --yMax 17 \
 --refPointLabel Control.AR.peaks \
 --regionsLabel FOXA1.peaks \
 --plotTitle 'FOXA1 ChIP Signal'

regije su: AR specific peaks u SPOPmut: UP_SPOPmut.txt
bw files su: SPOPmut_DHT.bigwig  SPOPmut_EtOH.bigwig

computeMatrix reference-point \
-S SPOPmut_DHT.bigwig  SPOPmut_EtOH.bigwig \
-R UP_SPOPmut.txt \
--referencePoint center \
-a 500 -b 500 \
-out AR_UP_SPOPmut_FOXA1_SPOPmut.tab.gz


 plotHeatmap \
 -m AR_UP_SPOPmut_FOXA1_SPOPmut.tab.gz \
 -out AR_SPOPmut_UP_FOXA1_peaks2.eps \
 --heatmapHeight 15  \
 --zMax 35 \
 --yMax 17 \
 --refPointLabel SPOPmut.AR.peaks \
 --regionsLabel FOXA1.peaks \
 --plotTitle 'FOXA1 ChIP Signal'

#u biti bi se trebale razlikovati - i razlikuju se - jeej!!!!


Opcija B - ne samo Contro specific or mutant specific but all control AR peaks and all SPOPmut AR peaks

computeMatrix reference-point \
-S Ctrl_DHT.bigwig Ctrl_EtOH.bigwig \
-R Control_consensus.bed \
--referencePoint center \
-a 500 -b 500 \
-out AR_concensus_Control_FOXA1_Control.tab.gz


SPOPmut_consensus.bed
computeMatrix reference-point \
-S SPOPmut_DHT.bigwig  SPOPmut_EtOH.bigwig \
-R SPOPmut_consensus.bed \
--referencePoint center \
-a 500 -b 500 \
-out AR_concensus_SPOPmut_FOXA1_SPOPmut.tab.gz


 plotHeatmap \
 -m AR_concensus_Control_FOXA1_Control.tab.gz \
 -out AR_Control_concensus_FOXA1_peaks2.eps \
 --heatmapHeight 15  \
 --zMax 35 \
 --yMax 17 \
 --refPointLabel Control.AR.peaks \
 --regionsLabel FOXA1.peaks \
 --plotTitle 'FOXA1 ChIP Signal'


 plotHeatmap \
 -m AR_concensus_SPOPmut_FOXA1_SPOPmut.tab.gz \
 -out AR_SPOP_concensus_FOXA1_peaks2.eps \
 --heatmapHeight 15  \
 --zMax 35 \
 --yMax 17 \
 --refPointLabel Control.AR.peaks \
 --regionsLabel FOXA1 \
 --plotTitle 'FOXA1 signal'

 #Looks like there is no difference between mut and ctrl





~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Intersection of FOXA1 peaks with AR specific peaks~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~``
cd /Volumes/Seagate/FOXA1_2019/Intervene


1) in control


cd /Volumes/Seagate/FOXA1_2019/Intervene

(bioinfo) MAC202969:Intervene ivana$ ls
AR_Control.narrowPeak.bed.sorted.bed            FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed     H3K4me2_SPOPmut_EtOH_IDR.narrowPeak.bed.sorted.bed
AR_SPOPmut.narrowPeak.bed.sorted.bed            FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed        Intervene_results
Diagrams                        H3K4me2_Control_DHT_IDR.narrowPeak.bed.sorted.bed   UP_Control.txt
FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed     H3K4me2_Control_EtOH_IDR.narrowPeak.bed.sorted.bed  UP_SPOPmut.txt
FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed    H3K4me2_SPOPmut_DHT_IDR.narrowPeak.bed.sorted.bed

1) Control - sva tri odjednom

pybedtools venn_gchart -a UP_Control.txt -b FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed -c FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed -o AR_Control_UP_FOXA1_.png #it is in png in the working folder, and then import to illustrator and draw
pybedtools venn_mpl -a UP_Control.txt  -b FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed -c FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed -o AR_Control_UP_FOXA1_.svg

Onda na jednom imas proporcionalno nacrtano no bez brojeva a na drugom samo brojeve. pa skombiniras u ilustratoru

-rw-r--r--  1 ivana  staff    10K Jul 26 15:00 AR_Control_UP_FOXA1_.png
-rw-r--r--  1 ivana  staff    15K Jul 26 15:00 AR_Control_UP_FOXA1_.svg

ili zasebno
ETOH
pybedtools venn_gchart -a UP_Control.txt -b FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed -o EtOH_AR_Control_UP_FOXA1_.png
intervene venn -i UP_Control.txt FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed -o EtOH_AR_Control_UP_FOXA1_.jpeg

DHT
pybedtools venn_gchart -a UP_Control.txt -b FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed -o DHT_AR_Control_UP_FOXA1_.png
intervene venn -i UP_Control.txt FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed -o DHT_AR_Control_UP_FOXA1_.jpeg



2) SPOPmut
pybedtools venn_gchart -a UP_SPOPmut.txt -b FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed -c FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed -o AR_SPOPmut_UP_FOXA1_.png #it is in png in the working folder, and then import to illustrator and draw
pybedtools venn_mpl -a UP_SPOPmut.txt  -b FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed -c FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed -o AR_SPOPmut_UP_FOXA1_.svg

EtOH
pybedtools venn_gchart -a UP_SPOPmut.txt -b FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed -o EtOH_AR_SPOPmut_UP_FOXA1_.png
intervene venn -i UP_SPOPmut.txt FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed -o EtOH_AR_SPOPmut_UP_FOXA1_.jpeg


DHT
pybedtools venn_gchart -a UP_SPOPmut.txt -b FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed -o DHT_AR_SPOPmut_UP_FOXA1_.png
intervene venn -i UP_SPOPmut.txt FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed -o DHT_AR_SPOPmut_UP_FOXA1_.jpeg



~~~~~~~~~~~~~~~~~~~~~Differential peak analysis-IDR peaks_EdgeR~~~~~~~~~~~~~~~~~~~
Control:

First do it for the control (comaprison EtOH vs DHT) and then do it for the SPOPmut (comparison EtOH vs DHT)

I will use IDR peaks and bams - bams are from bwa folder for IPS and bwa-ctl for 

cd /Volumes/Seagate/FOXA1_2019/Differential_peaks/Control

(bioinfo) MAC202969:Control ivana$ ls
10_S7_R1_001.merged.bam                 3_S2_R1_001.merged.bam                  7_S5_R1_001.merged.bam                  FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed
12_S8_R1_001.merged.bam                 4_S3_R1_001.merged.bam                  9_S6_R1_001.merged.bam                  
1_S1_R1_001.merged.bam                  6_S4_R1_001.merged.bam                  FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed

Moras sve fajlove prebaciti. isti folder i da je Rmd file u tom folderu i da je taj folder radni direktorij

sum(chip_DS$Fold<0) 7770: upregulated after DHT  treatment
sum(chip_DS$Fold>0) 6817: downregulated after DHT treatment

Diffbind output: 
-filtrirala u Excellu i copy paste i sejvala kao MsDOS formatted text: UP_FOXA1_Control_DHT i onda sortirala u linuxu: 

sort -k1,1 -k2,2n UP_FOXA1_Control_DHT.txt > UP_FOXA1_Control_DHT.txt.sorted.bed
sort -k1,1 -k2,2n UP_FOXA1_Control_EtOH.txt > UP_FOXA1_Control_EtOH.txt.sorted.bed


SPOPmut:
cd /Volumes/Seagate/FOXA1_2019/Differential_peaks/SPOPmut

(bioinfo) MAC202969:SPOPmut ivana$ ls
13_S9_R1_001.merged.bam             22_S16_R1_001.merged.bam
15_S11_R1_001.merged.bam            25_S17_R1_001.merged.bam
16_S12_R1_001.merged.bam            27_S18_R1_001.merged.bam
19_S14_R1_001.merged.bam            FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed
21_S15_R1_001.merged.bam            FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed

sum(chip_DS$Fold<0)
sum(chip_DS$Fold>0)
[1] 12350: upregulated after DHT  treatment, negative fold change (na grafu dolje), FDR less than 1%
[1] 8218: downregulated after DHT treatment

sort -k1,1 -k2,2n UP_FOXA1_SPOPmut_EtOH.txt > UP_FOXA1_SPOPmut_EtOH.txt.sorted.bed
sort -k1,1 -k2,2n UP_FOXA1_SPOPmut_DHT.txt > UP_FOXA1_SPOPmut_DHT.txt.sorted.bed


~~~~~~~~~~~~~~~~~~~~~Differential peak analysis- MACS2 peaks_EdgeR~~~~~~~~~~~~~~~~~~~

#What would happen if I would use MACS replicas peaks instead o IDR - would it look better?
# these are narowPeak files - convert them to bed

for f in *.narrowPeak
 do
     cut -f1,2,3 $f | sed 1d >`basename $f`.bed
 done

for f in *.narrowPeak.bed
 do 
     sort -k1,1 -k2,2n $f > `basename $f`.sorted.bed
 done

10474: upregulated after DHT  treatment, negative fold change, FDR less than 1%
8393: downregulated after DHT treatment


~~~~~~~~~~~~~~~~~~~~~Differential peak analysis - motifs~~~~~~~~~~~~~~~~~~~
cd /Volumes/Seagate/FOXA1_2019/Differential_peaks/Control

source activate bioinfo

#Compare one against each other:
mkdir DHT_vs_ETOH
#move here the bed files
PATH=$PATH:/Users/Ivana/bin/
findMotifsGenome.pl UP_FOXA1_Control_DHT.txt.sorted.bed mm10 peakAnalysis -size 200 -bg UP_FOXA1_Control_EtOH.txt.sorted.bed -h
- so it is obvious that in the DHT treatment there is an enrichment for AR TF

cd /Volumes/Seagate/FOXA1_2019/Differential_peaks/SPOPmut

#Compare one against each other:
mkdir /Volumes/Seagate/FOXA1_2019/Differential_peaks/SPOPmut/DHT_vs_ETOH
(bioinfo) MAC202969:~ ivana$ mkdir /Volumes/Seagate/FOXA1_2019/Differential_peaks/SPOPmut/DHT_vs_ETOH
(bioinfo) MAC202969:~ ivana$ cd /Volumes/Seagate/FOXA1_2019/Differential_peaks/SPOPmut/DHT_vs_ETOH

#move here the bed files
findMotifsGenome.pl UP_FOXA1_SPOPmut_DHT.txt.sorted.bed mm10 peakAnalysis -size 200 -bg UP_FOXA1_SPOPmut_EtOH.txt.sorted.bed -h


lijepo prikazi

~~~~~~~~~~~~~~~~~~~~~count the motifs: ARE and ARE:FOXA1 in the peaks~~~~~~~~~~~~~~~~~~~

/Volumes/Seagate/FOXA1_2019/ARE_motif_incidence


motifs for FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer :  /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known1.motif
motifs for FOXA1:AR(Forkhead,NR)/LNCAP-AR-ChIP-Seq(GSE27824)/Homer:  /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known24.motif
MOTIFS FOR ARE: /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known32.motif 


IDR PEAKS
1) with foxa1
Results are summarized in excell, didnt plot it in Prism

2) IDR peaks with FOXA1:AR
PATH=$PATH:/Users/Ivana/bin/
annotatepeaks.pl FOXA1_Control_DHT_IDR.narrowPeak.bed.sorted.bed mm10 -size 1000 -hist 5 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known24.motif > FOXA1.AR_incidence_Control_DHT.bed 
annotatepeaks.pl FOXA1_Control_EtOH_IDR.narrowPeak.bed.sorted.bed mm10 -size 1000 -hist 5 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known24.motif > FOXA1.AR_incidence_Control_EtOH.bed 
annotatepeaks.pl FOXA1_SPOPmut_DHT.narrowPeak.bed.sorted.bed mm10 -size 1000 -hist 5 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known24.motif > FOXA1.AR_incidence_SPOPmut_DHT.bed 
annotatepeaks.pl FOXA1_SPOPmut_EtOH.narrowPeak.bed.sorted.bed mm10 -size 1000 -hist 5 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known24.motif > FOXA1.AR_incidence_SSPOPmut_EtOH.bed 

Results are summarized in Excell FOXA1.AR


3) Differential peaks from the comparison of FOXA1 SPOPmut_DHT and FOXA1 Control_DHT
/Volumes/Seagate/FOXA1_2019/ARE_motif_incidence/Differential_peaks

Common.bed      Control_enriched.bed    SPOPmut_enriched.bed

they are not sorted so:
sort -V -k1,1 -k2,2 Common.bed > tmp
(bioinfo) MAC202969:Differential_peaks ivana$ head tmp
chr1    3493710 3493974
chr1    3603477 3603782
chr1    4361755 4362234
chr1    5082664 5083110
chr1    6094080 6094488
chr1    6179844 6180933
chr1    6188172 6189601
chr1    6190211 6191579
chr1    6271929 6272366
chr1    6287181 6288260
mv tmp sorted_Common.bed

sort -V -k1,1 -k2,2 Control_enriched.bed  > sorted_Control_enriched.bed 
sort -V -k1,1 -k2,2 SPOPmut_enriched.bed  > sorted_SPOPmut_enriched.bed 

1) with with foxa1 but 10 bp Window
PATH=$PATH:/Users/Ivana/bin/

2) FOXA1.AR but 10 bp Window
annotatepeaks.pl sorted_Control_enriched.bed  mm10 -size 1000 -hist 10 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known24.motif > 10bp_FOXA1.ARE_incidence_Control_emriched_DHT.bed 
annotatepeaks.pl sorted_SPOPmut_enriched.bed mm10 -size 1000 -hist 10 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known24.motif > 10bp_FOXA1.ARE_incidence_SPOPmut_enriched.bed 
annotatepeaks.pl sorted_Common.bed mm10 -size 1000 -hist 10 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known24.motif > 10bp_FOXA1.ARE_incidence_common.bed 

3)  with ARE
annotatepeaks.pl sorted_Control_enriched.bed  mm10 -size 1000 -hist 10 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known32.motif > 10_ARE_incidence_Control_emriched_DHT.bed 
annotatepeaks.pl sorted_SPOPmut_enriched.bed mm10 -size 1000 -hist 10 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known32.motif > 10_ARE_incidence_SPOPmut_enriched.bed 
annotatepeaks.pl sorted_Common.bed mm10 -size 1000 -hist 10 -m /Volumes/Seagate/FOXA1_2019/Homer_motifs/SPOPmut_DHT/peakAnalysis/knownResults/known32.motif > 10_ARE_incidence_common.bed 


Each ones have their corresponding Excell

Sve rezultate iz zasebnih excell tablica i.e. Homer total sites prebaci u zajednicki excell
Podijeli bp sa 1000 da dobijes kb
Plotaj u excellu da vidis kako izgleda - u scatterplotu

Plotat cu ove na 10 bp histogram density, koji su iz diferencijanih peakova i.e 10_ARE i 10_FOXA1:AR

Plot it in GraphPad Prism as Mike showed me: with smoothed line

Mike - import data as xy scatterplot
onda dok si na originalnim rezultatima klinkni na ikonu analyze - analyse xy - normalize-smooth
Leave the original data and a line on top of it

Line: red, thinkness 1, data: filled dots, 1 - samo kliknes na tocku i format entire dataset...
Nafitaj si x os da je -.5 kb i 0.5 kbnafitaj y os da je na minimum 0.00004 tako da krakovi ne vise sa strane


~~~~~~~~~~~~~~~~~~~~~Differential peak analysis - genomic regions~~~~~~~~~~~~~~~~~~~








~~~~~~~~~~~~~~~~~~~~~~~~~Combined analysis with H3K4me2 ChIP-seq~~~~~~~~~~~~~~~~~~~
#Trebat cu H3K4me2 bigwig files
#za bed files: svi IDR PEAKS from FOXA1, AR, interescted?
#How the chromatin is being remodelled? 
#izbaci promotore i ostavi samo enhancere

#prebacilaanotirane fajlove

#1) I have to remove the promoter regions

cd /Volumes/Seagate/FOXA1_2019/H3K4me2_signal

for f in *.txt
 do 
     awk 'BEGIN {FS="\t"; OFS="\t"} {if ($8!~"promoter-TSS" && $8!~"^5") {print $0}}' $f > `basename $f`.noUTR.txt
 done

(base) MAC202969:H3K4me2_signal ivana$ ls *.noUTR.txt
Annotated_Control_DHT.txt.noUTR.txt Annotated_Control_EtOH.txt.noUTR.txt    Annotated_SPOPmut_DHT.txt.noUTR.txt Annotated_SPOPmut_EtOH.txt.noUTR.txt

cut -f 2,3,4,5  Annotated_Control_DHT.txt.noUTR.txt > tmp
sed 1d tmp | sort -k1,1 -k2,2n > FOXA1_Control_DHT_enhancers.txt
rm tmp

cut -f 2,3,4,5  Annotated_Control_EtOH.txt.noUTR.txt > tmp
sed 1d tmp | sort -k1,1 -k2,2n > FOXA1_Control_EtOH_enhancers.txt
rm tmp

cut -f 2,3,4,5  Annotated_SPOPmut_DHT.txt.noUTR.txt  > tmp
sed 1d tmp | sort -k1,1 -k2,2n > FOXA1_SPOPmut_DHT_enhancers.txt
rm tmp

cut -f 2,3,4,5  Annotated_SPOPmut_EtOH.txt.noUTR.txt  > tmp
sed 1d tmp | sort -k1,1 -k2,2n > FOXA1_SPOPmut_EtOH_enhancers.txt
rm tmp

(base) MAC202969:H3K4me2_signal ivana$ ls *enhancers.txt
FOXA1_Control_DHT_enhancers.txt     FOXA1_Control_EtOH_enhancers.txt    FOXA1_SPOPmut_DHT_enhancers.txt     FOXA1_SPOPmut_EtOH_enhancers.txt

(base) MAC202969:H3K4me2_signal ivana$ ls *.bigwig
H3K4me2_Control_DHT.bigwig  H3K4me2_Control_EtOH.bigwig H3K4me2_SPOPmut_DHT.bigwig  H3K4me2_SPOPmut_EtOH.bigwig


Prebaci bigwigs od H3K4me2
#File name or names, in BED or GTF format, containing the regions to plot. If multiple bed files are given, each one is considered a group that can be plotted separately.

#Odvojeno za kontrole i odvojeno za SPOP mutantu

za Kontrolu

computeMatrix reference-point \
-S  H3K4me2_Control_DHT.bigwig \
-R FOXA1_Control_DHT_enhancers.txt \
--referencePoint center \
-a 2500 -b 2500 \
-out matrix_H3K4me2_FOXA1_Control_DHT_enhancers.tab.gz

 plotHeatmap \
 -m matrix_H3K4me2_FOXA1_Control_DHT_enhancers.tab.gz \
 -out H3K4me2signal_FOXA1_Control_DHT_enhancers.eps \
 --heatmapHeight 15  \
 --zMax 30 \
 --yMax 8 \
 --refPointLabel peaks \
--regionsLabel FOXA1.peaks \
 --plotTitle 'H3K4me2 ChIP Signal on FOXA1 enhancers in Control_DHT'


computeMatrix reference-point \
-S H3K4me2_Control_EtOH.bigwig \
-R FOXA1_Control_EtOH_enhancers.txt \
--referencePoint center \
-a 2500 -b 2500 \
-out matrix_H3K4me2Peaks.FOXA1_Control_EtOH_enhancers.tab.gz

 plotHeatmap \
 -m matrix_H3K4me2Peaks.FOXA1_Control_EtOH_enhancers.tab.gz \
 -out H3K4me2signal_FOXA1_Control_EtOH_enhancers.eps \
 --heatmapHeight 15  \
 --zMax 30 \
 --yMax 8 \
 --refPointLabel peaks \
 --plotTitle 'H3K4me2 ChIP Signal on FOXA1 enhancers in Control_EtOH'


computeMatrix reference-point \
-S  H3K4me2_SPOPmut_DHT.bigwig \
-R FOXA1_SPOPmut_DHT_enhancers.txt \
--referencePoint center \
-a 2500 -b 2500 \
-out matrix_H3K4me2signal.FOXA1_SPOPmut_DHT_enhancers.tab.gz

 plotHeatmap \
 -m matrix_H3K4me2signal.FOXA1_SPOPmut_DHT_enhancers.tab.gz \
 -out H3K4me2signal_DHT_on_FOXA1_SPOPmut_DHT_enhancers.eps \
 --heatmapHeight 15  \
 --zMax 30 \
 --yMax 8 \
 --refPointLabel peaks \
 --regionsLabel FOXA1.peaks \
 --plotTitle 'H3K4me2 ChIP Signal on FOXA1 enhancers in SPOPmut_DHT'

####
computeMatrix reference-point \
-S H3K4me2_SPOPmut_EtOH.bigwig \
-R FOXA1_SPOPmut_EtOH_enhancers.txt \
--referencePoint center \
-a 2500 -b 2500 \
-out matrix_H3K4me2_signal_FOXA1_EtOH.tab.gz

 plotHeatmap \
 -m matrix_H3K4me2_signal_FOXA1_EtOH.tab.gz \
 -out H3K4me2signal_on_FOXA1_SPOPmut_EtOH_enhancers.eps \
 --heatmapHeight 15  \
 --zMax 30 \
 --yMax 8 \
 --refPointLabel peaks \
 --regionsLabel FOXA1.peaks \
 --plotTitle 'H3K4me2 ChIP Signal on FOXA1 enhancers in SPOPmut_EtOH'


~~~~~~~~~~~~~~~~~~AR signal at FOXA1 regions (only in DHT treated organoids)~~~~~~~~~~~~~~~~~~~~~~

#plot  average signal of AR on FOXA1 regions 
# I can use common sites (common in FOXA1 ChIP seq control and mutant), mutant specific FOXA1 sites and control specific FOXA1 sites

#lets first do Diff Bind to get those peaks

cd /Volumes/Seagate/FOXA1_2019/AR_signal_FOXA1

#For the Control enriched ones: there is a bed file, criteria is FDR < 0.01. fold change > 0 for Control. For the SPOPmutant enriched ones there is also a bed file, criteria is fold change < 0.
#For the peaks that do not change I have chosen FDR > 0.05 (they have various fold change so you cannot select on them on the basis of that)



FOXA1 bigwig files are: 
6_fc.signal.bigwig  #FOXA1 bigwig file in the control
9_fc.signal.bigwig  #FOXA1 bigwig file in the SPOPmut


BEd files are:
SPOPmut_enriched.bed
Control_enriched.bed            
consensus.bed

   11566 Control_enriched.bed
   15602 SPOPmut_enriched.bed
   34986 consensus.bed

#Try1: All FOXA1 peaks (so no genomic annotation, no motif annotation)
#prvo cu napraviti analizu na referentnom uzorku a to je #FOXA1 bigwig file in the SPOPmut. 
#Iza njega cu sortirati signal za sve tri razlicite regije na descending way to jest za svaki bed file ne zapocinje od kromosoma 1 nego od najnizeg signala

computeMatrix reference-point \
-S 9_fc.signal.bigwig \
-R SPOPmut_enriched.bed consensus.bed Control_enriched.bed \
--sortRegions descend \
--referencePoint center \
-a 500 -b 500 \
--missingDataAsZero \
-out Mikes_way.v4.gz \
--verbose  

plotHeatmap \
 -m Mikes_way.v4.gz \
 --outFileSortedRegions SPOPmut.regions.input \
 -out FOXA1_SPOPmut.eps \
 --heatmapHeight 15  \
 --whatToShow 'heatmap and colorbar' \
 --colorMap RdBu \
 --sortRegions no \
 --verbose    

 ##skipZeros didnt help but flag missingDataAsZero did help, vidi se na heatmap da imamo specificnu regiju sa missing data

computeMatrix reference-point \
-S 9_fc.signal.bigwig 6_fc.signal.bigwig \
-R SPOPmut.regions.input \
--referencePoint center \
--missingDataAsZero \
-a 500 -b 500 \
-out refPoint.try.tab.gz \
--verbose 

#colour scheme: 
#Blue range: black slateblue cyan white
#Red range: black red orange yellow white

plotHeatmap \
 -m refPoint.try.tab.gz \
 -out Mikes_way.v4.eps \
 --heatmapHeight 15  \
 --whatToShow 'heatmap and colorbar' \
 --colorList black,red,orange,yellow,white black,slateblue,cyan,white \
 --sortRegions no 


plotHeatmap \
 -m refPoint.try.tab.gz \
 -out Mikes_way.v5.eps \
 --heatmapHeight 15  \
 --whatToShow 'heatmap and colorbar' \
 --colorList black,red,orange black,slateblue,cyan \
 --sortRegions no 


 plotHeatmap \
 -m refPoint.try.tab.gz \
 -out Mikes_way.v6.eps \
 --whatToShow 'heatmap and colorbar' \
 --colorList black,red,orange,yellow,white black,slateblue,cyan,white \
 --sortRegions no 


 plotHeatmap \
 -m refPoint.try.tab.gz \
 -out Mikes_way.v7.eps \
 --whatToShow 'heatmap and colorbar' \
 --colorList black,red,white black,slateblue,cyan,white \
 --sortRegions no 


 plotHeatmap \
 -m refPoint.try.tab.gz \
 -out Mikes_way.v8.eps \
 --heatmapHeight 20  \
 --whatToShow 'heatmap and colorbar' \
 --colorList black,red,white black,slateblue,cyan,white \
 --sortRegions no 


 #but it just doesnt look right - it looks like in the control there is a stronger AR binding
 #Maybe I need to do Homer, annotate the peaks and take out the ones with FOXA1 motif

cd /Volumes/Seagate/FOXA1_2019/AR_signal_FOXA1/motifs

PATH=$PATH:/Users/Ivana/bin/
findMotifsGenome.pl SPOPmut_enriched.bed mm10 peakAnalysis_SPOPmut.vs.Control -size 200 -bg Control_enriched.bed -h

#top5 in known motifs are FOXA1

PATH=$PATH:/Users/Ivana/bin/
findMotifsGenome.pl Control_enriched.bed mm10 peakAnalysis_Control.vs.SPOP -size 200 -bg SPOPmut_enriched.bed -h

#top5 are again AP1 and Jun

 
#anotiraj bed fileove  za  FOXA1 motif:
PATH=$PATH:/Users/Ivana/bin/
annotatepeaks.pl SPOPmut_enriched.bed  mm10 -m /Volumes/Seagate/FOXA1_2019/AR_signal_FOXA1/motifs/peakAnalysis_SPOPmut.vs.Control/knownResults/known2.motif -mbed FOXA1_SPOPmut_enriched.bed

(bioinfo) MAC202969:AR_signal_FOXA1 ivana$ wc -l FOXA1_SPOPmut_enriched.bed
   27700 FOXA1_SPOPmut_enriched.bed

track name="SPOPmut_enriched.bed motifs" description="SPOPmut_enriched.bed motifs" visibility="pack" useScore="1"
chrX    170011448   170011458   FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer    7.278750    -
chrX    170011444   170011454   FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer    9.507352    -
chrX    169960245   169960255   FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer    10.182273   +
chrX    169961274   169961284   FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer    7.570699    +
chrX    169961457   169961467   FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer    9.100750    -
chrX    169933429   169933439   FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer    9.830329    +
chrX    169933932   169933942   FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer    6.413756    -
chrX    169932211   169932221   FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer    10.436755   -
chrX    169931152   169931162   FOXA1(Forkhead)/LNCAP-FOXA1-ChIP-Seq(GSE27824)/Homer    6.960123    +


PATH=$PATH:/Users/Ivana/bin/
annotatepeaks.pl Control_enriched.bed  mm10 -m /Volumes/Seagate/FOXA1_2019/AR_signal_FOXA1/motifs/peakAnalysis_SPOPmut.vs.Control/knownResults/known2.motif -mbed FOXA1_Control_enriched.bed

(bioinfo) MAC202969:AR_signal_FOXA1 ivana$ wc -l FOXA1_Control_enriched.bed
   10148 FOXA1_Control_enriched.bed

cut -f1,2,3 FOXA1_SPOPmut_enriched.bed > tmp1
sort -k1,1 -k2,2n tmp1 > tmp2
mv tmp2 FOXA1_SPOPmut_enriched_sorted.bed


cut -f1,2,3 FOXA1_Control_enriched.bed > tmp1
sort -k1,1 -k2,2n tmp1 > FOXA1_Control_enriched_sorted.bed

- no u zadnjem redu je ostao jos neki line pa sam i to trebala izbrisati...mislim da sam prvo trebala izbrisati header a tek onda sortirati

cd /Volumes/Seagate/FOXA1_2019/AR_signal_FOXA1/Peaks_FOXA1_motif




~~~~~~~~~~~~~FOXA1 signal at AR peaks - try 2

#it seems that my graph was not clear enough so I need to try to do all the bigwigs on one bed file that contains AR peaks that are enriched in SPOP mutant, that are de-enriched in SPOP mutant (enriched in Control) and that are common
#then I will get some form of a clustering as well and the regions will be sorted only in one sample


conda activate deeptools


cd /Volumes/Seagate/FOXA1_2019/Heatmap

Bigwig files are: SPOPmut_DHT.bigwig  SPOPmut_EtOH.bigwig Ctrl_DHT.bigwig Ctrl_EtOH.bigwig 

Bed files are from AR ChIP-seq: Reanayzed in Diffbind
(samtools) MAC202969:Heatmap ivana$ wc -l Control_enriched.bed 
    9085 AR_Control_enriched.bed
(samtools) MAC202969:Heatmap ivana$ wc -l AR_SPOPmut_enriched.bed 
   10727 AR_SPOPmut_enriched.bed
(samtools) MAC202969:Heatmap ivana$ wc -l Common.bed #As defined as peaks with FDR > 0.05
   36324 AR_Common.bed

cat Control_enriched.bed  | sort -V -k1,1 -k2,2 > AR_Control_enriched.bed
cat AR_SPOPmut_enriched.bed   | sort -V -k1,1 -k2,2 > AAR_SPOPmut_enr.bed 
(samtools) MAC202969:Heatmap ivana$ wc -l AAR_SPOPmut_enr.bed 
   10727 AAR_SPOPmut_enr.bed

cat Common.bed   | sort -V -k1,1 -k2,2 > AR_Common.bed    



#prvo cu napraviti analizu na referentnom uzorku a to je Ctrl EtOH. I za njega cu sortirati signal za sve tri razlicite regije na descending way to jest za svaki bed file ne zapocinje od kromosoma 1 nego od najnizeg signala

computeMatrix reference-point \
-S Ctrl_EtOH.bigwig \
-R AR_Control_enriched.bed AR_Common.bed  AAR_SPOPmut_enr.bed \
--sortRegions descend \
--referencePoint center \
-a 500 -b 500 \
--missingDataAsZero \
-out Mikes_way.v4.gz \
--verbose  

plotHeatmap \
 -m Mikes_way.v4.gz \
 --outFileSortedRegions Ctrl_EtOH.regions.input.v3 \
 -out Ctrl_EtOHv3.eps \
 --heatmapHeight 15  \
 --whatToShow 'heatmap and colorbar' \
 --colorMap RdBu \
 --sortRegions no \
 --verbose    

 ##skipZeros didnt help but flag missingDataAsZero did help, vidi se na heatmap da imamo specificnu regiju sa missing data

computeMatrix reference-point \
-S SPOPmut_DHT.bigwig  SPOPmut_EtOH.bigwig Ctrl_DHT.bigwig Ctrl_EtOH.bigwig \
-R Ctrl_EtOH.regions.input.v3 \
--referencePoint center \
--missingDataAsZero \
-a 500 -b 500 \
-out refPoint.try7.tab.gz \
--verbose 

plotHeatmap \
 -m refPoint.try7.tab.gz \
 -out Mikes_way.v4.eps \
 --heatmapHeight 15  \
 --whatToShow 'heatmap and colorbar' \
 --colorMap RdBu \
 --sortRegions no \
 --verbose  

#ovo neka ide u supplementary





