#Create CpG annotations reference
Rscript CpG_annotations_reference.R

#Create a folder named 'data' for output
import os
os.makedirs('./1/2/3/4/5', exist_ok=True)

#Loop through all bam files for CpG annotations
for i in $(ls *.bam | cut -c 1-2)
do   
       echo $i CpGI coverage 
       bedtools coverage -a hg19_CpG_annotation.bed -b $i.rmdup.bam -counts > $i.txt
done

#Generate TPM normalized summary table
Rscript CpG_annotations_coverage.R
