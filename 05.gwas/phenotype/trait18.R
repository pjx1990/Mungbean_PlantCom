##################
# BLUP 相关性
##################
rm(list = ls())
setwd("F:\\1-项目分析\\GWAS\\表型数据\\20210716全部表型处理\\BLUP")

files <- list.files(path = "./",pattern = "blup.txt")
ad <- NULL
for(i in 1:length(files)){
  ad[[i]] <- read.table(files[i],header = F)
}
alld <- do.call(cbind,ad)
f_name <- gsub("_blup.txt","",files)
f_name
colnames(alld) <- f_name

BRN <- read.csv("BRN_blup.csv",header = T)
alld2 <- cbind(BRN[1],alld)
colnames(alld2)[1] <- "Sample"

write.csv(alld2,"trait18_blup.csv",row.names = F,quote = F)

library(pheatmap)
test <- na.omit(alld2)
pheatmap(cor(test[-1]),colorRampPalette (c("blue","white","red")) (100))
