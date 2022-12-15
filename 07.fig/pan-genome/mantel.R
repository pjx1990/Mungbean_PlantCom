########################################
## PAV gene 矩阵和snp distance矩阵 相关性mantel test
#
## 参考：https://mp.weixin.qq.com/s/MfUM3s4zkUzGwB7iZB5G1A
######################################
rm(list = ls ())
library(tidyverse)

pav <- read.csv("../genePAV.csv",header = T,check.names = F)#,row.names = 1)
remove_pav <- pav[!duplicated(pav),]

# gene pav distance ------------------------------------------------------------------

remove_pav[1:5,1:5]
test <- remove_pav

out.dist=dist(t(test[-1]),method="euclidean") 
out.hclust=hclust(out.dist,method="complete") 
plot(out.hclust,xlab = "")

str(out.dist)
out.dist
library(reshape2)
df <- melt(as.matrix(out.dist), varnames = c("row", "col"))
head(df)
write.table(df,"pav_dist.txt",sep = "\t",row.names = F,quote = F)


# png("test.png",width = 3000,height = 600)
# plot(out.hclust,xlab = "")   
# dev.off()
# 
# pdf("test.pdf",width = 35,height = 10)
# plot(out.hclust,xlab = "")   
# dev.off()
# 
# rect.hclust(out.hclust,k=6)  #用矩形画出分为3类的区域
# out.id=cutree(out.hclust,k=6)#得到分为3类的数值
# out.id


# snp distance matrix -----------------------------------------------------

ibd <- read.delim("nj.ibdM0",sep = "\t",check.names = F)
head(ibd)




# mantel test -------------------------------------------------------------

library(vegan)
res <- mantel(out.dist, ibd[-1], method = 'spearman', permutations = 9999, na.rm = TRUE)
res
# write.table(res,"pav_snp_matrix_mantel_test.txt",row.names = F)



