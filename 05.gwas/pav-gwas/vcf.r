#######################
### gene pav vcf format
######################
rm(list = ls())
setwd("F:\\河北农科院绿豆基因组项目\\1-项目分析\\GWAS\\PAV\\gene")
library(tidyverse)

gff <- read.delim("all.gff3",header = F,sep = "\t")
gene <- gff %>% filter(V3=="gene")

# gsub("ID=(.*);","\\1","ID=jg14238;")
gene$V9 <- gsub("ID=(.*);","\\1",gene$V9)
head(gene)

pav <- read.delim("pav.tsv",header = T,sep = "\t",row.names = 1)
pav_t <- data.frame(t(pav))
head(pav_t)
colnames(pav_t) <- gsub("lz[.]","lz-",colnames(pav_t))
colnames(pav_t)

pav_t$ID=rownames(pav_t)
pav_t[pav_t==0] <- "0/0"
pav_t[pav_t==1] <- "1/1"

setdiff(rownames(pav_t),gene$V9)

gene2 <- gene[c("V1","V9","V4","V5")] %>% 
  mutate(Pos=ceiling((V4+V5)/2)) %>% 
  select(c(V1,Pos,V9))

colnames(gene2) <- c("#CHROM","POS","ID")
gene2$REF <- sample(c("A","G"),nrow(gene2),replace = T)
gene2$ALT <- sample(c("T","C"),nrow(gene2),replace = T)
gene2$QUAL <- "."
gene2$FILTER <- "."
gene2$INFO <- "."
gene2$FORMAT <- "GT"


pav_t$ID <- gsub("m1[.]","m1-",pav_t$ID)
setdiff(gene2$ID,pav_t$ID)
vcf <- left_join(gene2,pav_t,by="ID")

write.table("##fileformat=VCFv4.1","pav_gene.vcf",row.names = F,col.names = F,quote = F)
write.table(vcf,"pav_gene.vcf",row.names = F,col.names = T,sep = "\t",quote = F,append = T)



# # chenk NA ----------------------------------------------------------------
# 
# id <- apply(vcf,1,function(x)any(is.na(x)))
# vcf[id,]
# 
# setdiff(gene2$ID,pav_t$ID)
# setdiff(pav_t$ID,gene2$ID)
