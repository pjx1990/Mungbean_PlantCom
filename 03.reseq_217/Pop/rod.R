################ ROD ID
rod <- read.delim("sweep_region.txt",header = T)
head(rod)
rod$ID <- paste0("ROD",1:nrow(rod))

gene <- read.delim("sweep_gene_function.txt",header = T)
colnames(gene)
colnames(rod)

library(tidyverse)
data <- right_join(rod[c(1:3,8)],gene,by=c("CHROM","BIN_START","BIN_END" ))
write.csv(data,"ROD_suptable.csv",row.names = F)
