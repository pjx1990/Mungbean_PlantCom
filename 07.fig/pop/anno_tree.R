###################
## 中国材料进化树注释文件
###################
rm(list = ls())
library(tidyverse)
library(RColorBrewer)


alldata <- read.delim("allsample2.txt",header = T,row.names = 1)
head(alldata)

our <- alldata %>% filter(Data.Source=="This study") %>% 
  select(Accession,Biological.status,Group.in.phylogenetic.tree)
head(our)

our$Group.in.phylogenetic.tree <- gsub("Cluster Ⅰ","G1",our$Group.in.phylogenetic.tree)
our$Group.in.phylogenetic.tree <- gsub("Cluster Ⅱ","G2",our$Group.in.phylogenetic.tree)
our$Group.in.phylogenetic.tree <- gsub("Cluster Ⅲ","G3",our$Group.in.phylogenetic.tree)
our$Group.in.phylogenetic.tree <- gsub("Cluster Ⅳ","G4",our$Group.in.phylogenetic.tree)
write.csv(our,"sample217.csv",row.names = F)


display.brewer.all()
# col1 <- brewer.pal(4,"Set2")
col1 <- brewer.pal(4,"Dark2")

## 进化树聚类（4类）注释
cluster <- data.frame(sample=our$Accession,
                      range="range",
                      color=our$Group.in.phylogenetic.tree,
                      type=our$Group.in.phylogenetic.tree)
unique(cluster$color)
cluster$color <- gsub("G1",col1[1],cluster$color)
cluster$color <- gsub("G2",col1[2],cluster$color)
cluster$color <- gsub("G3",col1[3],cluster$color)
cluster$color <- gsub("G4",col1[4],cluster$color)

head(cluster)
write.table("TREE_COLORS\nSEPARATOR SPACE\nDATA","cluster4_anno.txt",
            row.names = F,col.names = F,sep = " ",quote = F)
write.table(cluster,"cluster4_anno.txt",
            row.names = F,col.names = F,sep = " ",quote = F,
            append = T)


## 品种类型（2类）设置注释

head(our)
col2 <- c("#f8766d","#00b0f6") #ggplot2中使用的默认“柔和的红色”和“柔和的蓝色”分别具有十六进制代码#f8766d和#00b0f6
type <- data.frame(sample=our$Accession,
                   clade="clade",
                   color=our$Biological.status,
                   normal="normal",
                   size="2")
type$color <- gsub("Pre-breeding line",col2[2],type$color)
type$color <- gsub("Breeding line",col2[1],type$color)

write.table("TREE_COLORS\nSEPARATOR SPACE\nDATA","type2_anno.txt",
            row.names = F,col.names = F,sep = " ",quote = F)
write.table(type,"type2_anno.txt",
            row.names = F,col.names = F,sep = " ",quote = F,
            append = T)


# 自定义图例 -------------------------------------------------------------------


### test
names <- c('Africa', 'Asia', 'Europe', 'North America', 'Oceania','South America')
clrs <- c('orange', 'red', 'green', 'blue', 'purple')
plot(NULL ,xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
legend("topleft", title="Continent", legend = names, lty=1, lwd=2, cex=1.25,
       bty='n', col = clrs)

## our data
col1
col2

cluster_name <- sort(unique(alldata$Group.in.phylogenetic.tree)[1:4])
type_name <- c("Breeding Line","Pre-breeding Line")
names <- c(cluster_name,type_name)
clrs <- c(col1,col2)
png("legend.png",width = 600,height = 400)
plot(NULL ,xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
legend("topleft", title="", legend = names, lty=1, lwd=12, cex=1.5,
       bty='n', col = clrs)
dev.off()

pdf("legend.pdf",width = 8,height = 6)
plot(NULL ,xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
legend("topleft", title="", legend = names, lty=1, lwd=12, cex=1.5,
       bty='n', col = clrs)
dev.off()


# 改名为Group1-4 -------------------------------------------------------------

cluster_name <- paste0("Group",1:4)
type_name <- c("BL","PBL")
names <- c(cluster_name,type_name)
clrs <- c(col1,col2)
png("legend2.png",width = 600,height = 400)
plot(NULL ,xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
legend("topleft", title="", legend = names, lty=1, lwd=12, cex=1.5,
       bty='n', col = clrs)
dev.off()

pdf("legend2.pdf",width = 8,height = 6)
plot(NULL ,xaxt='n',yaxt='n',bty='n',ylab='',xlab='', xlim=0:1, ylim=0:1)
legend("topleft", title="", legend = names, lty=1, lwd=12, cex=1.5,
       bty='n', col = clrs)
dev.off()
