##################
## 分解表型数据
##################
rm(list = ls())
setwd("C:\\Users\\Jesse\\Desktop\\绿豆\\GEMMA")
library(tidyverse)

dir.create("phenotype")
data <- read.table("allphe_outlier_NA.txt",header = T)
for(i in 2:ncol(data)){
  # i=2
  print(colnames(data)[i])
  write.table(data[i],file = paste0("phenotype/",colnames(data)[i],".txt"),sep = "\t",quote = F,col.names = F,row.names = F)
}

