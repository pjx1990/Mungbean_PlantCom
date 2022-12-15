require(clusterProfiler)
library(DOSE)
library(tidyverse)

argv <- commandArgs(TRUE)
argv[1] <- "../../allgene_GO.txt"

goanno <- read.delim(argv[1], header=T, sep='\t')
head(goanno)

fun <- read.delim("../../allgene.function.anno.txt",header = T)

# argv[2] <- "favorable.csv"
# argv[3] <- "fav"

# argv[2] <- "unfavorable.csv"
# argv[3] <- "unfav"



# # #adaption国外引进适应过程all/UP/DOWN
argv[2] <- "../20211129/nonchina_China2-3类.csv"
# argv[3] <- "adaption"
# argv[3] <- "adaption_up"
argv[3] <- "adaption_down"


# #improve国内改良过程UP/DOWN
# argv[2] <- "../20211129/China2_China1_3类.csv"
# argv[3] <- "improve"
# argv[3] <- "improve_up"
# argv[3] <- "improve_down"


glst <- read.csv(argv[2], header=T)
# glst <- read.csv(argv[2], header=T) %>% filter(Frequency.change.trend == "Constantly down") #Up
outpre <- argv[3]


colnames(goanno) <- c('gene', 'GO', 'name',"type")
head(goanno)
t2g <- goanno[, c('GO', 'gene')]
t2n <- goanno[, c('GO', 'name')]

glst <- as.character(glst$gene)

gene <- fun[match(glst,fun$Gene),] %>% select(1,5,4,2,3,6)
gene <- gene[apply(gene, 1, function(x) !all(is.na(x))),]
write.csv(gene,paste0(outpre,".gene.csv"),row.names = F)

x <- enricher(glst, TERM2GENE=t2g, TERM2NAME=t2n, pvalueCutoff=1, qvalueCutoff=1)
write.csv(x, file=paste(outpre, '.go.csv', sep=''), row.names=FALSE)

# pdf(paste(outpre, '.go.pdf', sep=''))
png(paste(outpre, '.go.png', sep=''))
barplot(x)
dev.off()


# MF ----------------------------------------------------------------------


unique(goanno$type)
mf <- subset(goanno,goanno$type=="molecular_function")
mf
t2g <- mf[, c('GO', 'gene')]
t2n <- mf[, c('GO', 'name')]
x <- enricher(glst, TERM2GENE=t2g, TERM2NAME=t2n, pvalueCutoff=1, qvalueCutoff=1)
write.csv(x, file=paste(outpre, '.MF.csv', sep=''), row.names=FALSE)
# pdf(paste(outpre, '.MF.pdf', sep=''))
png(paste(outpre, '.MF.png', sep=''))
barplot(x)
dev.off()


# BP ----------------------------------------------------------------------

bp <- subset(goanno,goanno$type=="biological_process")
bp
t2g <- bp[, c('GO', 'gene')]
t2n <- bp[, c('GO', 'name')]
x <- enricher(glst, TERM2GENE=t2g, TERM2NAME=t2n, pvalueCutoff=1, qvalueCutoff=1)
write.csv(x, file=paste(outpre, '.BP.csv', sep=''), row.names=FALSE)
# pdf(paste(outpre, '.BP.pdf', sep=''))
png(paste(outpre, '.BP.png', sep=''))
barplot(x)
dev.off()



# BP and MF ---------------------------------------------------------------

bf <- subset(goanno,goanno$type=="biological_process" | goanno$type=="molecular_function")
bf
t2g <- bf[, c('GO', 'gene')]
t2n <- bf[, c('GO', 'name')]
x <- enricher(glst, TERM2GENE=t2g, TERM2NAME=t2n, pvalueCutoff=1, qvalueCutoff=1)
write.csv(x, file=paste(outpre, '.BP_MF.csv', sep=''), row.names=FALSE)
# pdf(paste(outpre, '.BP_MF.pdf', sep=''))
png(paste(outpre, '.BP_MF.png', sep=''))
barplot(x)
dev.off()


# 
# # 两次材料分类的选择基因交集 -----------------------------------------------------------
# 
# fav1 <- read.csv("../favorable.csv",header = T)
# fav2 <- read.csv("favorable.csv",header = T)
# length(intersect(fav1$gene,fav2$gene))
# 
# unfav1 <- read.csv("../unfavorable.csv",header = T)
# unfav2 <- read.csv("unfavorable.csv",header = T)
# length(intersect(unfav1$gene,unfav2$gene))
