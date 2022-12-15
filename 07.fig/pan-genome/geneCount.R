##############################
### 不同亚群基因数目比较
#############################
rm(list = ls())
library(tidyverse)
# install.packages("ggsignif")
library(ggsignif)
#https://www.jianshu.com/p/07e1bee02ee8

pav <- read.csv("../../../genePAV.csv",header = T,check.names = F)
pav[1:6,1:6]
pav_rmdup <- pav[!duplicated(pav),]
pav_rmdup[1:6,1:6]
rownames(pav_rmdup) <- pav_rmdup$Gene
# write.csv(pav_rmdup,"pav_removeDuplicatedGene.csv",row.names = F)


# 拆分亚群 --------------------------------------------------------------------


samp <- read.delim("../sample_type.txt",header = T,sep = "\t") 
# samp <- read.delim("../../客户第三次材料分类/sample_type.txt",header = T,sep = "\t")


land_sa <- samp %>% filter(Type=="China2") %>% select(SampleID)
land <- pav_rmdup[,land_sa$SampleID]

cult_sa <- samp %>% filter(Type=="China1") %>% select(SampleID)
cult <- pav_rmdup[,cult_sa$SampleID]

nonchina_sa <- samp %>% filter(Type=="NonChina") %>% select(SampleID)
nonchina <- pav_rmdup[,nonchina_sa$SampleID]


# 计算各亚群基因数目 ------------------------------------------------------------------


nonchina_num <- apply(nonchina,2,sum)
land_num <- apply(land,2,sum)
cult_num <- apply(cult,2,sum)

data <- data.frame(Type=rep(c("NonChina","China2","China1"),times=c(length(nonchina_num),length(land_num),length(cult_num))),
                   geneCount=c(nonchina_num,land_num,cult_num))
data$Type <- factor(data$Type,levels = c("NonChina","China2","China1"))


# 两个国外野生基因 ----------------------------------------------------------------

wild <- data[match(c("lz-194","lz-199"),rownames(data)),]
wild
mean(data$geneCount)
median(data$geneCount)


median(nonchina_num)
median(land_num)
median(cult_num)


# plot --------------------------------------------------------------------


compaired <- list(c("NonChina", "China2"),c("NonChina","China1"),c("China2","China1"))

p=ggplot(data,aes(Type,geneCount,fill=Type))+
  geom_violin(trim = FALSE) +
  geom_boxplot(width=0.25)+
  geom_jitter(aes(color=Type),alpha=0.5)+
  labs(x='', y= 'Gene Count')+
  geom_signif(comparisons = compaired,
              step_increase = 0.1,
              map_signif_level = F,
              test = t.test)+ #t.test wilcox.test
  cowplot::theme_cowplot()+
  theme(legend.position = "none");p
ggsave(p,filename = "geneCount.png",width = 6,height = 6,dpi = 300)
ggsave(p,filename = "geneCount.pdf",width = 6,height = 6)


