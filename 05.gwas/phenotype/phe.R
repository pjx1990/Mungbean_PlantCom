###############
### 表型处理
##############
rm(list = ls())
library(tidyverse)

setwd("F:\\1-项目分析\\GWAS\\表型数据\\20210716全部表型处理")


# 原始表型 --------------------------------------------------------------------


raw <- read.delim("all_phenotype.txt",header = T) 
vit <- read.delim("vitexin_raw.txt",header = T)
allraw <- full_join(vit,raw,by="Sample") %>% arrange(Sample)
allraw[1:5,1:5]

if(!exists("raw_phenotype"))dir.create("raw_phenotype")

for(i in 2:ncol(allraw)){
  # i=2
  # allraw[i]
  print(colnames(allraw)[i])
  write.table(allraw[i],file = paste0("raw_phenotype/",colnames(allraw)[i],".txt"),sep = "\t",quote = F,col.names = F,row.names = F)
}



# 原始表型数量性状ranklog转化 -------------------------------------------------------

colnames(allraw)
quant <- allraw[1:90]
class_t <- allraw[c(91:105)]

rankTransPheno <- function (pheno, para_c=0.5) 
{
  pheno <- qnorm((rank(pheno) - para_c)/(length(pheno) - 2*para_c + 1))
  return(pheno)
}

quant_conv <- apply(quant[-1],2,rankTransPheno)
quant_convdata <- cbind(quant[1],quant_conv)
quant_convdata[1:5,1:5]

if(!exists("rank_raw_phenotype"))dir.create("rank_raw_phenotype")
for(i in 2:ncol(quant_convdata)){
  print(colnames(quant_convdata)[i])
  write.table(quant_convdata[i],file = paste0("rank_raw_phenotype/",colnames(quant_convdata)[i],".txt"),sep = "\t",quote = F,col.names = F,row.names = F)
}


## RFW枯萎病抗性也是数量性状
rfw <- allraw[c(1,97)]
head(rfw)
rfw_rank <- rankTransPheno(rfw$RFW_2018SJZ_summer)
write.table(rfw_rank,"RFW.txt",col.names = F,row.names = F,sep = "\t")



# 去除离群值表型 -----------------------------------------------------------------

data <- read.table("allphe_outlier_NA.txt",header = T)
## Linux服务器已做





# 去除离群值表型，数量性状ranklog转化 ---------------------------------------------------

data[1:5,1:5]
vit_outlier <- read.delim("vitexin_remove_outliers.txt",header = T)
head(vit_outlier)

rank_data_vit <- full_join(vit_outlier,data,by="Sample")
rank_data_vit[1:5,1:5]

colnames(rank_data_vit)


rank_quant <- rank_data_vit[1:90]
rank_class_t <- rank_data_vit[c(91:105)]

rank_quant_conv <- apply(rank_quant[-1],2,rankTransPheno)
rank_quant_convdata <- cbind(rank_quant[1],rank_quant_conv,rank_class_t)
rank_quant_convdata[1:5,1:5]

if(!exists("rank_outlier_phenotype"))dir.create("rank_outlier_phenotype")
for(i in 2:ncol(rank_quant_convdata)){
  print(colnames(rank_quant_convdata)[i])
  write.table(rank_quant_convdata[i],file = paste0("rank_outlier_phenotype/",colnames(rank_quant_convdata)[i],".txt"),sep = "\t",quote = F,col.names = F,row.names = F)
}
