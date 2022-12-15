###################
##  世界材料进化树注释文件
###################

rm(list = ls())
library(tidyverse)
library(RColorBrewer)


alldata <- read.delim("../进化树217/allsample2.txt",header = T,row.names = 1)
head(alldata)

data.frame(table(alldata$Country)) %>% arrange(-Freq)
data.frame(table(alldata$Region)) %>% arrange(-Freq)

alldata$Region[alldata$Region=="America" | 
                 alldata$Region=="Australia" |
                 alldata$Region=="Africa" |
                 alldata$Region=="Europe" |
                 alldata$Region=="Central Asia" |
                 alldata$Region=="Unknown" ] <- "Other"

our <- alldata  %>% 
  select(Accession,Region,Country,Biological.status)
head(our)

unique(our$Region)


# global region annot -----------------------------------------------------


display.brewer.all()
# col1 <- brewer.pal(4,"Set2")
col1 <- brewer.pal(5,"Dark2")

region <- data.frame(sample=our$Accession,
                     range="range",
                     col=our$Region,
                     region=our$Region)
head(region)
region$col <- gsub(unique(our$Region)[1],col1[1],region$col)
region$col <- gsub(unique(our$Region)[2],col1[2],region$col)
region$col <- gsub(unique(our$Region)[3],col1[3],region$col)
region$col <- gsub(unique(our$Region)[4],col1[4],region$col)
region$col <- gsub(unique(our$Region)[5],col1[5],region$col)

write.table("TREE_COLORS\nSEPARATOR COMMA\nDATA","region5_anno.txt",
            row.names = F,col.names = F,quote = F)
write.table(region,"region5_anno.txt",
            row.names = F,col.names = F,sep = ",",quote = F,
            append = T)


# accession type annot ----------------------------------------------------

head(our)
col2 <- c("#f8766d","#00b0f6") #ggplot2中使用的默认“柔和的红色”和“柔和的蓝色”分别具有十六进制代码#f8766d和#00b0f6
type <- data.frame(sample=our$Accession,
                   d2=1,
                   d3=1,
                   color=our$Biological.status,
                   d4=1,
                   d5=0.5)
type$color <- gsub("Pre-breeding line",col2[2],type$color)
type$color <- gsub("Breeding line",col2[1],type$color)
head(type)

write.table("DATASET_SYMBOL\nSEPARATOR COMMA\nDATASET_LABEL,example symbols\nCOLOR,#ffff00\nMAXIMUM_SIZE,50\nDATA","type2_anno.txt",
            row.names = F,col.names = F,quote = F)
write.table(type,"type2_anno.txt",
            row.names = F,col.names = F,sep = ",",quote = F,
            append = T)
