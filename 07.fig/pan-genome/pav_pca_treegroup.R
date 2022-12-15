########################
### 根据PAV进化树自定义聚类结果（四类），对PCA分组
########################
rm(list = ls())

library(tidyverse)
pca <- read.table("pca.eigenvec",sep = " ",header = F)
head(pca)

value=read.table("pca.eigenval",header = F)
value
## Proportion of explained variance 
value$V1/sum(value$V1)*100
# pca[1,3]/sum(pca$V3)

pop <- read.table("pop.txt",header = T)
pop$group <- gsub("G","Group",pop$group)
head(pop)

our <- read.csv("sample217.csv",header = T)
head(our)

data <- inner_join(pca,pop,by=c("V1"="sampleID"))
head(data)
data2 <- inner_join(data,our,by=c("V1"="Accession"))
data2$Biological.status <- gsub("Pre-breeding line","PBL",data2$Biological.status)
data2$Biological.status <- gsub("Breeding line","BL",data2$Biological.status)

col <- RColorBrewer::brewer.pal(4,"Dark2")


p=ggplot(data=data2, aes(V3,V4,color=group,shape=Biological.status)) + 
  geom_point(aes(size=1.5))+#stat_ellipse()+
  scale_size(guide=FALSE)+
  scale_color_manual(values = col)+
  scale_shape_manual (values =c(17,16))+
  # theme_bw()+
  cowplot::theme_cowplot()+
  theme(legend.position = c(0.7,0.8),
        legend.title = element_blank(),
        legend.text = element_text(size = 15))+
  labs(x="PC1 (37.52%)",y="PC2 (15.61%)");p
ggsave(p,filename = "pca.png",width = 10,height = 8)


p=ggplot(data=data2, aes(V3,V4,color=group,shape=Biological.status)) + 
  geom_point(aes(size=1.5))+#stat_ellipse()+
  scale_size(guide=FALSE)+
  scale_color_manual(values = col)+
  scale_shape_manual (values =c(17,16))+
  # theme_bw()+
  cowplot::theme_cowplot()+
  theme(legend.position = "none",
        legend.title = element_blank(),
        legend.text = element_text(size = 15))+
  labs(x="PC1 (37.52%)",y="PC2 (15.61%)");p
ggsave(p,filename = "pca_nolegend.png",width = 10,height = 8)
