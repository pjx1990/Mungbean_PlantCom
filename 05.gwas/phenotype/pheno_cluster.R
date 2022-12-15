###########################
### 表型相关性及表型分类
##########################
rm(list = ls())
setwd("F:\\1-项目分析\\GWAS\\表型数据\\20210508表型")

if(!exists("phenotype_cor_class"))dir.create("phenotype_cor_class")
setwd("phenotype_cor_class")

library(pheatmap)
library(tidyverse)


data=read.delim("all_phenotype.txt",header = T,row.names = 1)
head(data)
colnames(data)

data2=data
# data2=data[1:87]
data2=na.omit(data2)
which(is.na(data))

# pdf("cor.pdf",width = 21,height = 19)
pheatmap(cor(data2))
# dev.off()

sample_dist <- dist(data)
sample_hc <- hclust(sample_dist)
plot(sample_hc)


# 材料间相关性 ------------------------------------------------------------------


data2=data
head(data2)
for(i in 1:ncol(data2)){
  data2[is.na(data2[,i]), i] <- mean(data2[,i], na.rm = TRUE)
}

data3=data.frame(t(data2))
# data3=na.omit(data3)
# scale(data3)

# pdf("sample_cor.pdf",width = 30,height = 28)
pheatmap(cor(data3))
# dev.off()

pheatmap(data3,scale = "row")


# PCA ---------------------------------------------------------------------


# devtools::install_github("husson/FactoMineR")

library(FactoMineR)

# scale
n=t(scale(t(data2)))
gene.pca <- PCA(n, ncp = 2, scale.unit = TRUE, graph = FALSE)
plot(gene.pca)  #PCA 简图
