######################
##通路筛选
#####################
rm(list = ls())
library(tidyverse)


# 适应过程 开花相关通路--------------------------------------------------------------------

ad <- read.delim("../GO/适应gene/adaption.go.xls",header = T)
d1 <- head(ad,1) %>% select(geneID) %>% as.character()
d2 <- ad[2,] %>% select(geneID) %>% as.character()

geneid <- unique(unlist(strsplit(d1,"/")),unlist(strsplit(d2,"/")))
geneid

fun <- read.delim("../../allgene.function.anno.txt",header = T)

gene <- fun[match(geneid,fun$Gene),] %>% 
  select(1,4,5,2,3,6)

freq <- read.csv("../allgene_freq.csv",header = T)

dat <- left_join(gene,freq,by="Gene")
write.csv(dat,"适应过程开花相关基因功能及其频率.csv",row.names=F)


# 开花相关基因具体缺失 --------------------------------------------------------------

pav <- read.csv("../../../remove_dup_genePAV.csv",header = T,check.names = F)
pavgene <- pav[match(geneid,pav$Gene),]
rownames(pavgene) <- pavgene$Gene
data <- data.frame(t(pavgene[-1])) %>% 
  rownames_to_column("SampleID")

##材料类型
type <- read.delim("../sample_type.txt",header = T)
d4 <- left_join(data,type,by="SampleID") %>% 
  arrange(SampleID)
write.csv(d4,"适应过程开花相关基因在所有材料中的缺失情况.csv",row.names=F)



# 开花相关基因与开花性状表型相关性 --------------------------------------------------------

library(ggsignif)
allphe <- read.delim("all_phenotype.txt",header = T) %>% 
  select(1,starts_with("FLD")) %>% 
  arrange(Sample)

#0-1分组做t检验
# pheatmap::pheatmap(cor(na.omit(allphe)))

identical(d4$SampleID,allphe$Sample)

i=2
d4[c(1,i)]
j=2
allphe[c(1,j)]

for(i in 2:10){
  for (j in 2:7) {
    # i=2
    # j=2
    print(paste0("----------gene:",names(d4)[i],"------trait:",names(allphe)[j],"---------------"))
    m1 <- inner_join(d4[c(1,i)],allphe[c(1,j)],by=c("SampleID"="Sample"))
    gname <- names(m1)[2]
    tname <- names(m1)[3]
    colnames(m1)[2:3] <- c("gene","trait")
    
    m1$gene <- factor(m1$gene,levels = c("1","0"),labels = c("Presence","Absence"))
    # compaired <- list(c("0", "1"))
    compaired <- list(c("Presence","Absence"))
    p=ggplot(m1,aes(gene,trait,fill=gene))+
      # geom_violin(trim = FALSE) +
      geom_boxplot()+ #width=0.5
      geom_jitter()+
      # geom_jitter(aes(color=gene),alpha=0.2)+
      labs(x='', y= tname,color=gname,fill=gname)+
      geom_signif(comparisons = compaired,
                  step_increase = 0.1,
                  map_signif_level = F,
                  test = wilcox.test)+ #t.test wilcox.test
      # cowplot::theme_cowplot()+
      theme_bw();p
    ggsave(p,filename = paste(gname,tname,"PAV_freq.png",sep = "_"),width = 8,height = 6)
  }
}


