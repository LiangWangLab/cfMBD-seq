#Create CpG annotations reference
Rscript CpG_annotations_reference.R

#Create a folder named 'data' for output
import os
path = os.getcwd()
for i in range(0,40):
    file_path = path + '\data'+ str(i)
    os.mkdir(file_path)

#Loop through all bam files for CpG annotations and output in 'data'
for i in $(ls *.bam | cut -c 1-2)
do   
       echo $i CpGI coverage 
       bedtools coverage -a hg19_CpG_annotation.bed -b $i.rmdup.bam -counts > $i.txt
done

#Generate TPM normalized summary table
Rscript CpG_annotations_coverage.R
