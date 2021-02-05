#Create CpG annotations reference
Rscript CpG_annotations_reference.R

#Loop through all bam files for CpG annotations and output in 'data'
mkdir -p data
for i in $(ls *.bam | cut -c 1-2)
do   
       echo $i CpG annotations
       bedtools coverage -a hg19_CpG_annotation.bed -b $i.bam -counts > data/$i.txt
done

#Generate TPM normalized summary table
Rscript CpG_annotations_coverage.R
