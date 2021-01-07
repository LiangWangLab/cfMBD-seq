library(tidyverse)
library(annotatr)

dm_regions = read_regions(con = "chr_for_annotation.txt", genome = 'hg19',  format = 'bed')
# Select annotations for intersection with regions
CpG_annots = c('hg19_cpgs')
# Build the annotations (a single GRanges object)
CpG_annotations = build_annotations(genome = 'hg19', annotations = CpG_annots)
# Intersect the regions we read in with the annotations
CpG_annotated = annotate_regions(regions = dm_regions, annotations = CpG_annotations, ignore.strand = TRUE, quiet = FALSE)
# Coerce to a data.frame
CpG_df_annotated = data.frame(CpG_annotated)
#Generate CpG annotation bed
CpG_cut <- CpG_df_annotated[,c(6:9,15)] 
CpG_order <- CpG_cut[order(CpG_cut$annot.start),]
CpG_order <- CpG_orer[order(CpG_orer$annot.seqnames),]
write.table(CpG_order,"hg19_CpG_annotation.bed", sep="\t", quote = FALSE, row.names = FALSE, col.names = FALSE)
