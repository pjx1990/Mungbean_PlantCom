require(clusterProfiler)
library(DOSE)
argv <- commandArgs(TRUE)

goanno <- read.delim(argv[1], header=T, sep='\t')
glst <- read.table(argv[2], head=FALSE)
outpre <- argv[3]

colnames(goanno) <- c('gene', 'GO', 'name')
head(goanno)
t2g <- goanno[, c('GO', 'gene')]
t2n <- goanno[, c('GO', 'name')]

glst <- as.character(glst$V1)

x <- enricher(glst, TERM2GENE=t2g, TERM2NAME=t2n, pvalueCutoff=1, qvalueCutoff=1)
write.table(x, file=paste(outpre, '.go.xls', sep=''), sep="\t", quote=FALSE, row.names=FALSE)

pdf(paste(outpre, '.go.pdf', sep=''))

barplot(x)

dev.off()

