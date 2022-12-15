###############
## 泛基因组外显子长度
###############
rm(list = ls())
library(tidyverse)

l1 <- read.delim("hardCore.lst",sep = "\t",header = F)
head(l1)
l2 <- read.delim("softCore.lst",header = F)
l3 <- read.delim("shell.lst",header = F)
l4 <- read.delim("cloud.lst",header = F)

core_list <- rbind(l1,l2)
vari_list <- rbind(l3,l4)

data <- read.delim("外显子长度len.cds.stat.xls",header = T,sep = "\t")
head(data)

core_data <- data[match(core_list$V1,data$Gene),]
vari_data <- data[match(vari_list$V1,data$Gene),]

mean(core_data$Length)
mean(core_data$CDS_Num)

mean(vari_data$Length)
mean(vari_data$CDS_Num)

l1$Category <- "Hardcore"
l2$Category <- "Softcore"
l3$Category <- "Shell"
l4$Category <- "Cloud"

alld <- rbind(l1,l2,l3,l4)
head(alld)

finald <- inner_join(data,alld,by=c("Gene"="V1"))
head(finald)
write.csv(finald,"pan_gene_category.csv",row.names = F)



# GO 功能 -------------------------------------------------------------------

GO <- read.delim("GO.txt",header = T,sep = "\t")
head(GO)

gene2GO <- GO %>% 
  group_by(gene) %>% 
  summarise(GO=str_c(GO,collapse = "#"))
head(gene2GO)
str(l1)
str(gene2GO)
write.table(gene2GO,"gene2GO.txt",quote = F,sep = "\t",col.names = T,row.names = F)

# hardcore <- inner_join(l1,gene2GO,by=c("V1"="gene"))
# softcore <- gene2GO[match(l2$V1,gene2GO$gene),]
# shell <- gene2GO[match(l3$V1,gene2GO$gene),]
# cloud <- gene2GO[match(l4$V1,gene2GO$gene),]
# 
# core <- rbind(hardcore,softcore)
# varib <- rbind(shell,cloud)
# 
# write.table(hardcore,"hardcore_GO.txt",sep = "\t",quote = F,col.names = F,row.names = F)
