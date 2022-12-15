######################
### pca 3d
######################

rm(list = ls())

library(tidyverse)
library(scatterplot3d)

pca <- read.table("pca.eigenvec",sep = " ",header = F)
head(pca)

value=read.table("pca.eigenval",header = F)
value
sum(value$V1)
samp <- read.delim("Sample_217.txt",header = T)
head(samp)

data <- inner_join(pca[-1],samp,by=c("V2"="SampleID"))
# data$Origin2 <- sapply(data$Origin,function(x)ifelse(x!="Chinese_Mainland" &x!="India","Other",x))
colnames(data)[2:4]=c("PC1","PC2","PC3")
head(data)

library(RColorBrewer)
display.brewer.all()
col=brewer.pal(9, "Set1")
n=data.frame(table(data$Region))
coldf=data.frame(Region=rep(n$Var1,times=n$Freq),col=rep(col,times=n$Freq))
unique(coldf)

png(filename = "pca3d.png",width = 800,height = 600)
# 绘制三维PCA图
scatterplot3d(data[,2:4],
              # pch = c(rep(17,158),rep(19,40),rep(8,19)),
              # color= c(rep("red",3),rep("blue",3)),
              pch = data$Type_code,
              color = data$Region_code,
              angle = 45)
              # angle=45, main= "3D PCA plot",
              # cex.symbols= 1.5,mar=c(5, 4, 4, 5))
# 添加图例
legend("topright", #title = "Sample",
       xpd=TRUE,inset= -0.01,
       legend = unique(data$Region),
       lty=0.5,lwd=1,
       # bty="n",
       text.width = 2,
       x.intersp = 0.8,
       y.intersp = 1,
       pch = 19,
       col = unique(data$Region_code))

legend("top", #title = "Sample",
       xpd=TRUE,inset= -0.01,
       lty=0.5,lwd=1,
       # bty="n",
       horiz = T,
       text.width = 2,
       x.intersp = 0.8,
       y.intersp = 1,
       legend = unique(data$Type),
       pch = unique(data$Type_code))

dev.off()
# 
# legend("topright",title = "Sample",
#        xpd=TRUE,inset= -0.01,
#        legend = unique(data$Region),
#        col = unique(data$Region_code),
#        pch = unique(data$Type_code))

