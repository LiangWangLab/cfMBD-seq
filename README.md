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
