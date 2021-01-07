Rscript CpG_annotations_reference.R

for i in $(ls *.bam | cut -c 1-2)
do   
       echo $i CpGI coverage 
       bedtools coverage -a hg19_CpG_annotation.bed -b $i.rmdup.bam -counts > $i.txt
done

Rscript CpG_annotations_coverage.R
