library(ramwas)

##Run once
library(BSgenome.Hsapiens.UCSC.hg19)
cpgset = getCpGsetCG(BSgenome.Hsapiens.UCSC.hg19)
saveRDS(file = "UCSC.hg19_cpgset.rds", object = cpgset)

##Parameters
#Create a text file named 'bam_list.txt' and type in file name of bams on that file.
param = ramwasParameters(
  filebamlist = "bam_list.txt",
  filecpgset = "UCSC.hg19_cpgset.rds",
  cputhreads = 10,
  scoretag = "MAPQ",
  minscore = 4,
  minfragmentsize = 100,
  maxfragmentsize = 600,
  minavgcpgcoverage = 0.3,
  minnonzerosamples = 0.3
)

##Quality control
ramwas1scanBams(param)
ramwas2collectqc(param)
#Open /qc/summary_bams/Summary_QC.txt to see summary QC.

##Example of making a Coverage by CpG density plot 
#change working directory
setwd(".../rds_qc")
qc1 <- readRDS(file = "cfMBD.qc.rds")$qc
qc2 <- readRDS(file = "cfMeDIP.qc.rds")$qc
qc3 <- readRDS(file = "Lowinput_MBD.qc.rds")$qc

plot(qc1$avg.coverage.by.density, ylim=c(0,30),col = "red")

y2 = qc2$avg.coverage.by.density;
x2 = (seq_along(y2) - 1)/100;
lines(x2, y2, col = "blue", lwd = 3)

y3 = qc3$avg.coverage.by.density;
x3 = (seq_along(y3) - 1)/100;
lines(x3, y3, col = "green", lwd = 3)

legend("topleft", legend=c("cfMBD-seq", "cfMeDIP-seq", "Low input MBD-seq"),
       col=c("red", "blue", "green"), lty=1, lwd=3)
