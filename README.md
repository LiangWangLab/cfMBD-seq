# cfMBD-seq
Author: Jinyong Huang

# Introduction
The code within the LiangWanglab/cfMBD-seq repository is used for quick quality controls of cfMBD-seq data, including FASTQ to SAM by bowtie2, SAM to BAM by samtools, quality controls using R packages RaMWAS/MEDIPS,  and call CpG annotations coverage using bedtools. Bash programming and pre-installation of software are required. Access to a high-performance computing cluster is also recommended. 

# Requirements
Computer running a Linux system (≥ 8 GB RAM) Cluster computing is HIGHLY recommended when working with FASTQ/BAM files  
Modules: bowtie2 (version ), samtools (version ), reference genome-human/hg19, bedtools (version )  
R/RStudio (version  or greater)  
Packages: BSgenome.hsapiens.UCSC.hg19, RaMWAS, MEDIPS

# Procedure
1. Bash to process raw data FASTQ files to BAM files.  
```./fastq_to_bam.sh```  
2. Quality control using RaMWAS, which generates summary QC (including duplicate  rate%, non-CpG coverage, CpG coverage, and noise) and coverage by CpG density plot.  
```Rscript RaMWAS.R```  
3. Quality control using MEDIPS, which generates saturation analysis plot and genome-wide correlation between samples.  
```Rscript MEDIPS.R```   
4. Call CpG annotations coverage using bedtools and normalize the coverage using R.
