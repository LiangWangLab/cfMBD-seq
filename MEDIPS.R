library(MEDIPS)
library(BSgenome.Hsapiens.UCSC.hg19)

##Parameters
BSgenome="BSgenome.Hsapiens.UCSC.hg19"
uniq=1
extend=167
shift=0
ws=1000

##Data Import and Preprocessing
Treatment1 = MEDIPS.createSet(file = "101.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws)
Treatment1 = c(Treatment1, MEDIPS.createSet(file = "102.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws))
Treatment1 = c(Treatment1, MEDIPS.createSet(file = "103.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws))
Treatment2 = MEDIPS.createSet(file = "201.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws)
Treatment2 = c(Treatment2, MEDIPS.createSet(file = "202.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws))
Treatment3 = MEDIPS.createSet(file = "301.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws)

##Export Wiggle files for visualization of rpkm normalized data
MEDIPS.exportWIG(Set = Treatment1, file = "Treatment1.wig", format = "rpkm", descr = "Treatment1")
MEDIPS.exportWIG(Set = Treatment2, file = "Treatment2.wig", format = "rpkm", descr = "Treatment2")
MEDIPS.exportWIG(Set = Treatment3, file = "Treatment3.wig", format = "rpkm", descr = "Treatment3")

##Correlation between samples
cor.matrix = MEDIPS.correlation(MSets = c(Treatment1, Treatment2, Treatment3), plot = T, method = "pearson")
cor.matrix

##Saturation analysis
srTreatment1 = MEDIPS.saturation(file = "101.bam", BSgenome = BSgenome, uniq = uniq, extend = extend, shift = shift, window_size = ws,  nit = 10, nrit = 1, empty_bins = TRUE,rank = FALSE)
MEDIPS.plotSaturation(srTreatment1, main="xxx")

srTreatment2 = MEDIPS.saturation(file = "201.bam", BSgenome = BSgenome, uniq = uniq, extend = extend, shift = shift, window_size = ws, nit = 10, nrit = 1, empty_bins = TRUE,rank = FALSE)
MEDIPS.plotSaturation(srTreatment2, main="xxx")
