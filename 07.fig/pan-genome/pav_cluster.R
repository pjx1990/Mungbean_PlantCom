################
## PAV gene cluter tree
###############
rm(list = ls ())
library(tidyverse)

pav <- read.csv("./genePAV.csv",header = T,check.names = F)#,row.names = 1)
# pav[1:5,1:5]
# length(unique(pav$Gene))
# 
# dup <- pav[duplicated(pav$Gene),]
# length(unique(dup$Gene))
# 
# dup2 <- right_join(pav,dup,by="Gene")
# remove_dup <- dup2[duplicated(dup2),]

remove_pav <- pav[!duplicated(pav),]
# write.csv(remove_pav,"remove_dup_genePAV.csv",row.names = F)


# cluter ------------------------------------------------------------------

remove_pav[1:5,1:5]

# test <- head(remove_pav,10)
test <- remove_pav

# library(pheatmap)
# pheatmap(test[-1])

out.dist=dist(t(test[-1]),method="euclidean") 
out.hclust=hclust(out.dist,method="complete") 


png("test.png",width = 3000,height = 600)
plot(out.hclust,xlab = "")   
dev.off()


pdf("test.pdf",width = 35,height = 10)
plot(out.hclust,xlab = "")   
dev.off()

# out.dist=dist(remove_pav[-1],method="euclidean") 

rect.hclust(out.hclust,k=6)  #用矩形画出分为3类的区域
out.id=cutree(out.hclust,k=6)#得到分为3类的数值
out.id



# tree --------------------------------------------------------------------

library(ape)
tree = as.phylo(out.hclust)
plot(tree, type="fan")
write.tree(phy=tree, file="pav.nwk") 
# 保存为nwk
