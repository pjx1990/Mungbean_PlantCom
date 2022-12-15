###########################
### 所有表型去除离群值
##########################
rm(list = ls())
library(tidyverse)
library(readxl)

setwd("F:\\1-项目分析\\GWAS\\表型数据\\20210508表型")
# data <- read_excel(path = "./allphenotype.xlsx",sheet = 2)
data <- read.delim("all_phenotype.txt",header = T,sep = "\t",check.names = F)
colnames(data)

# unique(colnames(data))
boxplot(data$FLD_2017SJZ_spring)
boxplot(data$PLH_2017SJZ_spring)
boxplot(data$MSD_2017SJZ_spring)

head(data[,89:103])

# remove outliers ---------------------------------------------------------

# Remove outliers from a column
remove_outliers <- function(x, na.rm = TRUE, ...) {
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

# Removes all outliers from a data set
remove_all_outliers1 <- function(df){
  # We only want the numeric columns
  df[,sapply(df, is.numeric)] <- lapply(df[,sapply(df, is.numeric)], remove_outliers)
  df
}



df_tmp <- cbind(Sample=data[,1],remove_all_outliers1(data[2:88]),data[,89:103]) %>%
  arrange(Sample)
write.table(df_tmp,"allphe_outlier_NA.txt",sep = "\t",quote = F,col.names = T,row.names = F)

# df_removed <- na.omit(df_tmp)
# write.table(df_removed,"allphe_remove_outliers.txt",sep = "\t",quote = F,col.names = T,row.names = F)


# 统计去掉异常值后各性状缺失值 ----------------------------------------------------------

trait_na=data.frame(sapply(df_tmp[-1], function(x) sum(is.na(x))))
names(trait_na)="missingValue"
write.csv(trait_na,"Trait_missingValue.csv",col.names = NA)


# # 找出相同样本缺失值的性状 ------------------------------------------------------------
# 
# which_na=data.frame(which(is.na(df_tmp), arr.ind=TRUE))
# unique(which_na$col)
# table(which_na$row)


# output each trait ------------------------------------------------------------

dir.create("alltrait")
colnames(df_tmp)
for (i in 2:ncol(df_tmp)) {
  # i=4
  x=df_tmp[,c(1,i)]
  x=na.omit(x)
  write.table(x,paste0("alltrait/",colnames(df_tmp)[i],".txt"),sep = "\t",quote = F,col.names = T,row.names = F)
}
