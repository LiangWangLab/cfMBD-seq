library(MEDIPS)
library(BSgenome.Hsapiens.UCSC.hg19)

##Parameters
BSgenome="BSgenome.Hsapiens.UCSC.hg19"
uniq=1
extend=167
shift=0
ws=1000

##Data Import and Preprocessing
a = MEDIPS.createSet(file = "xx.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws)
a = c(a, MEDIPS.createSet(file = "xx.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws))
b = MEDIPS.createSet(file = "xx.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws)
b = c(b, MEDIPS.createSet(file = "xx.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws))
c = MEDIPS.createSet(file = "xx.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws)
d = MEDIPS.createSet(file = "xx.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws)
Input = MEDIPS.createSet(file = "xx.bam", BSgenome = BSgenome, extend = extend, shift = shift, uniq = uniq, window_size = ws)

##Export Wiggle files for visualization of rpkm normalized data
MEDIPS.exportWIG(Set = a, file = "a.wig", format = "rpkm", descr = "a")
MEDIPS.exportWIG(Set = b, file = "b.wig", format = "rpkm", descr = "b")
MEDIPS.exportWIG(Set = c, file = "c.wig", format = "rpkm", descr = "c")
MEDIPS.exportWIG(Set = d, file = "d.wig", format = "rpkm", descr = "d")

##Correlation between samples
cor.matrix = MEDIPS.correlation(MSets = c(a, b, c, d, Input), plot = F, method = "pearson")
cor.matrix

##Saturation analysis
sr1 = MEDIPS.saturation(file = "xx.bam", BSgenome = BSgenome, uniq = uniq, extend = extend, shift = shift, window_size = ws,  nit = 10, nrit = 1, empty_bins = TRUE,rank = FALSE)
MEDIPS.plotSaturation(sr1, main="xxx")

sr2 = MEDIPS.saturation(file = "xx.bam", BSgenome = BSgenome, uniq = uniq, extend = extend, shift = shift, window_size = ws, nit = 10, nrit = 1, empty_bins = TRUE,rank = FALSE)
MEDIPS.plotSaturation(sr2, main="xxx")
