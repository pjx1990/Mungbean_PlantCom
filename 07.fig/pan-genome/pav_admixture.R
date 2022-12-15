########################
### 根据PAV进化树自定义聚类结果（四类），对群体结构分析
########################
rm(list = ls())
setwd("F:\\河北农科院绿豆基因组项目\\Paper\\数据整理\\fig\\泛基因组\\pav聚类"

library(tidyverse)

fam=read.table("F:/Paper/数据整理/fig/群体进化/群体结构admixture-217/snp.fam",sep = " ")
head(fam)

pop=read.table("./pop.txt",header = T)
head(pop)

pop2=pop[match(fam$V1,pop$sampleID),]
head(pop2)


# sample order test-------------------------------------------------------------------

admix_res <- read.delim(paste("F:/Paper/数据整理/fig/群体进化/群体结构admixture-217/snp",4,"Q",sep = "."),sep = " ",header=F)
data <- cbind(pop2,admix_res)
data2 <- data %>% gather(pop,value,-c(sampleID,group)) #%>% arrange(-value)
data2$sampleID <- factor(data2$sampleID,levels = pop$sampleID) 
col=RColorBrewer::brewer.pal(4, "Set1")
ggplot(data2,aes(x = sampleID, y=value,fill=pop)) +
  geom_bar(stat = "identity",position = "fill")+
  scale_fill_manual(values = col)+
  guides(fill="none")+
  theme(axis.text.x = element_text(angle = 90))


admix_res <- read.delim(paste("F:/Paper/数据整理/fig/群体进化/群体结构admixture-217/snp",2,"Q",sep = "."),sep = " ",header=F)
data <- cbind(pop2,admix_res)
data2 <- data %>% gather(pop,value,-c(sampleID,group)) #%>% arrange(-value)
data2$sampleID <- factor(data2$sampleID,levels = pop$sampleID) 
col=RColorBrewer::brewer.pal(2, "Set1")
ggplot(data2,aes(x = sampleID, y=value,fill=pop)) +
  geom_bar(stat = "identity",position = "fill")+
  scale_fill_manual(values = col)+
  guides(fill="none")+
  theme(axis.text.x = element_text(angle = 90))

# normal ------------------------------------------------------------------

plot_k <- function(k){
  # k=3
  admix_res <- read.delim(paste("F:/Paper/数据整理/fig/群体进化/群体结构admixture-217/snp",k,"Q",sep = "."),sep = " ",header=F)
  # data <- cbind(pop,admix_res)
  data <- cbind(pop2,admix_res)
  
  # data2 <- plotdat %>% gather(Group,value,-c(sampleID,Type))
  data2 <- data %>% gather(pop,value,-c(sampleID,group))
  head(data2)
  ##一定要注意x轴标签排序，设为因子
  data2$sampleID <- factor(data2$sampleID,levels = pop$sampleID) #注意不是pop2
  
  # col=RColorBrewer::brewer.pal(k, "Set1")
  col=RColorBrewer::brewer.pal(k, "Dark2") #和進化樹保持一致
  p=ggplot(data2,aes(x = sampleID, y=value,fill=pop)) +
    geom_bar(stat = "identity",position = "fill")+
    scale_fill_manual(values = col)+
    guides(fill="none")+
    theme_void();p
  return(p)
}



p2=plot_k(k=2);p2
p3=plot_k(k=3);p3
p4=plot_k(k=4);p4
p5=plot_k(k=5);p5
# p6=plot_k(k=6);p6
# p7=plot_k(k=7);p7
# p8=plot_k(k=8);p8
# p9=plot_k(k=9);p9
# p10=plot_k(k=10);p10



table(pop2$group)


library(patchwork)

plt3=p2/p3/p4/p5;plt3
# ggsave(plt3,filename = "structure_K2-5.png",width = 15,height = 8,dpi = 500)
# ggsave(plt3,filename = "structure_K2-5.pdf",width = 15,height = 8)
ggsave(plt3,filename = "structure_K2-5_colorDark2.png",width = 15,height = 8,dpi = 500)
ggsave(plt3,filename = "structure_K2-5_colorDark2.pdf",width = 15,height = 8)


# 
# plt=p2/p3/p4/p5/p6/p7/p8/p9;plt
# # p2/p3/p4/p5/p6/p7/p8/p9/p10
# # plt=p2/p3/p4/p5/p6/p7/p8/p9/p11;plt
# ggsave(plt,filename = "structure_K2-9.png",width = 15,height = 8,dpi = 500)
# ggsave(plt,filename = "structure_K2-9.pdf",width = 15,height = 8)
# # p2+p3+p4+p5+p6+p7+p8+p9+p10+plot_layout(ncol = 2)
# 
# 
# plt2=p2/p3/p4/p5/p6/p7;plt2
# ggsave(plt2,filename = "structure_K2-7.png",width = 15,height = 8,dpi = 500)
# ggsave(plt2,filename = "structure_K2-7.pdf",width = 15,height = 8)



# CV K --------------------------------------------------------------------

CV_K <- read.delim("CV2.log",header = F,sep = "\t")
head(CV_K)
cv2 <- CV_K[CV_K$V1<16,]
# cv2$V1 <- as.factor(cv2$V1,levels=cv2$V1)
p=ggplot(cv2,aes(x=V1,y=V2))+
  geom_point()+
  geom_line()+
  cowplot::theme_cowplot()+
  scale_x_continuous(breaks=seq(2,15,1))+
  labs(x="K",y="Cross Validation Error");p
ggsave(p,filename = "K_error.png",width = 8,height = 8,dpi = 300)
