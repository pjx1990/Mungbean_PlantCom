##########################
## PAV不同亚群（国外、国内2群）频率分布
#########################
rm(list = ls())
library(tidyverse)

setwd("E:\\项目\\河北农科院绿豆基因组项目\\Paper\\数据整理\\PAV\\不同亚群基因频率分布\\国外亚群和国内2群且去掉10样")
pav <- read.csv("../../genePAV.csv",header = T,check.names = F)
pav[1:6,1:6]
pav_rmdup <- pav[!duplicated(pav),]
pav_rmdup[1:6,1:6]
rownames(pav_rmdup) <- pav_rmdup$Gene

samp <- read.delim("sample_type.txt",header = T,sep = "\t")

head(samp)

# ?fisher.test
# fisher.test
# fisher.test(rbind(c(1,9),c(11,3)), alternative="less")$p.value


# 拆分亚群 --------------------------------------------------------------------

land_sa <- samp %>% filter(Type=="China2") %>% select(SampleID)
land <- pav_rmdup[,land_sa$SampleID]

cult_sa <- samp %>% filter(Type=="China1") %>% select(SampleID)
cult <- pav_rmdup[,cult_sa$SampleID]

nonchina_sa <- samp %>% filter(Type=="NonChina") %>% select(SampleID)
nonchina <- pav_rmdup[,nonchina_sa$SampleID]




# 计算每个基因在各亚群频率 ------------------------------------------------------------

land_num <- apply(land,1,sum)
cul_num <- apply(cult,1,sum)
nonchina_num <- apply(nonchina,1,sum)

land_freq <- land_num/ncol(land)
cul_freq <- cul_num/ncol(cult)
nonchina_freq <- nonchina_num/ncol(nonchina)

test <- data.frame(NonChina=nonchina_freq,China2=land_freq,China1=cul_freq)
ggplot(test,aes(NonChina,China2))+geom_point()
ggplot(test,aes(China2,China1))+geom_point()



# 计算每个基因出现在两组的fisher exact test -------------------------------------------

data_num <- data.frame(NonChina=nonchina_num,China2=land_num,China1=cul_num)


## nonchina-vs-land
i=10
fisher.test(rbind(c(data_num[i,1],ncol(nonchina)),c(data_num[i,2],ncol(land))))$p.value
fisher.test(rbind(c(data_num[i,1],data_num[i,2]),c(ncol(nonchina),ncol(land))))$p.value

p <- NULL
for(i in 1:nrow(data_num)){
  tmp<- fisher.test(rbind(c(data_num[i,1],ncol(nonchina)),c(data_num[i,2],ncol(land))))$p.value
  # p <- c(tmp,p)
  p <- c(p,tmp)
}
p
p[10]


range(p)

# x=cut(p,c(0.01,0.001,1e-5,1e-20),right = T)
table(cut(p,c(1,0.05,0.01,0.001,1e-20,1e-30),right = T))
x=cut(p,c(1,0.05,0.01,0.001,1e-10,1e-20),right = T,
      # labels = c("≥0.05","<0.05","<0.01","<0.001","<1e-20"))
      labels = c("<1e-10","<0.001","<0.01","<0.05","≥0.05"))
table(x)

x=cut(p,c(1,0.05,0.01,0.001,1e-20),right = T,
      labels = c("<0.001","<0.01","<0.05","≥0.05"))
table(x)

nonchina_land <- data.frame(NonChina=nonchina_freq,
                            China2=land_freq,
                            P=p,
                            FDR=x)
nonchina_land$FDR <- factor(nonchina_land$FDR,levels = c("≥0.05","<0.05","<0.01","<0.001")) #为了方便作图排序
# nonchina_land$FDR <- factor(nonchina_land$FDR,levels = c("<0.001","<0.01","<0.05","≥0.05")) #为了方便作图排序
nonchina_land[is.na(nonchina_land$FDR),]
nonchina_land[is.na(nonchina_land$FDR),][,4] <- "≥0.05"
table(nonchina_land$FDR)

write.csv(nonchina_land,"NonChina_China2_freq.csv",col.names  = NA)


## land-vs-China1

i=200
fisher.test(rbind(c(data_num[i,2],ncol(land)),c(data_num[i,3],ncol(cult))))$p.value

p2 <- NULL
for(i in 1:nrow(data_num)){
  tmp<- fisher.test(rbind(c(data_num[i,2],ncol(land)),c(data_num[i,3],ncol(cult))))$p.value
  # p2 <- c(tmp,p2)
  p2 <- c(p2,tmp)
}
p2
p2[200]
range(p2)

# y=cut(p,c(0.01,0.001,1e-5,1e-20),right = T
y=cut(p2,c(1,0.05,0.01,0.001,1e-20),right = T,
      labels = c("<0.001","<0.01","<0.05","≥0.05"))
table(y)

land_cul <- data.frame(China2=land_freq,
                            China1=cul_freq,
                            P=p2,
                            FDR=y)
land_cul$FDR <- factor(land_cul$FDR,levels = c("≥0.05","<0.05","<0.01","<0.001")) #为了方便作图排序
land_cul[is.na(land_cul$FDR),]
land_cul[is.na(land_cul$FDR),][,4] <- "≥0.05"
table(land_cul$FDR)

write.csv(land_cul,"China2_China1_freq.csv",col.names = NA)




# 频率作图 --------------------------------------------------------------------


library(RColorBrewer)
col=c("gray","red","blue","purple")
# col=c("red","blue","purple","gray")

## nonchina-vs-land

p=ggplot(data = nonchina_land)+
  geom_point(aes(NonChina,China2,color=FDR))+
  # geom_jitter(aes(NonChina,China2,color=FDR))+
  labs(x="Frequency in Non-China",y="Frequency in China2")+
  scale_color_manual(values = col)+
  cowplot::theme_cowplot();p

ggsave(p,filename = "NonChina_China2_freq.png",width = 8,height = 6,dpi = 300)
ggsave(p,filename = "NonChina_China2_freq.pdf",width = 8,height = 6)

p=ggplot(data = nonchina_land)+
  # geom_point(aes(NonChina,China2,color=FDR))+
  geom_jitter(aes(NonChina,China2,color=FDR))+
  labs(x="Frequency in Non-China",y="Frequency in China2")+
  scale_color_manual(values = col)+
  cowplot::theme_cowplot();p

ggsave(p,filename = "NonChina_China2_freq_jitter.png",width = 8,height = 6,dpi = 300)
ggsave(p,filename = "NonChina_China2_freq_jitter.pdf",width = 8,height = 6)


##land-vs-cul
p=ggplot(data = land_cul)+
  geom_point(aes(China2,China1,color=FDR))+
  labs(x="Frequency in China2",y="Frequency in China1")+
  scale_color_manual(values = col)+
  cowplot::theme_cowplot();p
ggsave(p,filename = "China2_China1_freq.png",width = 8,height = 6,dpi = 300)
ggsave(p,filename = "China2_China1_freq.pdf",width = 8,height = 6)

p=ggplot(data = land_cul)+
  geom_jitter(aes(China2,China1,color=FDR))+
  labs(x="Frequency in China2",y="Frequency in China1")+
  scale_color_manual(values = col)+
  cowplot::theme_cowplot();p
ggsave(p,filename = "China2_China1_freq_jitter.png",width = 8,height = 6,dpi = 300)
ggsave(p,filename = "China2_China1_freq_jitter.pdf",width = 8,height = 6)








if(F){
  
  # 受选择基因在不同亚群的频率变化 ---------------------------------------------------------
  
  
  nonchina_land_gene <- nonchina_land %>% filter(FDR!="≥0.05")
  land_cul_gene <- land_cul %>% filter(FDR!="≥0.05")
  
  length(intersect(rownames(nonchina_land_gene),rownames(land_cul_gene)))
  length(union(rownames(nonchina_land_gene),rownames(land_cul_gene)))
  
  
  gene <- full_join(rownames_to_column(nonchina_land_gene,"gene"),
                    rownames_to_column(land_cul_gene,"gene"),
                    by="gene")
  # write.csv(gene,"selected_gene_freq.csv",row.names = F)
  
  
  ## all gene frequency
  data_freq <- data_num %>% 
    mutate(NonChina_freq=NonChina/ncol(nonchina),
           China2_freq=China2/ncol(land),
           China1_freq=China1/ncol(cult)) %>% 
    rownames_to_column("gene")
  # write.csv(data_freq,"allgene_freq.csv",row.names = F)
  
  
  ## selected gene freq
  
  select_gene <- data_freq[match(gene$gene,data_freq$gene),]
  #filter no change gene 
  idx <- apply(select_gene,1,function(x) x[5]==x[6] && x[6]==x[7])
  plot_data <- select_gene[!idx,] 
  
  ## add type
  type <- apply(plot_data, 1, function(x){
    if(x[5]>=x[6] && x[6]>=x[7]){
      "Constantly down"
    }else if(x[5]<=x[6] && x[6]<=x[7]){
      "Constantly up"
    }else if((x[5]<=x[6] && x[6]>=x[7]) || (x[5]>=x[6] && x[6]<=x[7])){
      "Reverse"
    }else{
      "Other"
    }
  })
  plot_data$`Frequency change trend`= unlist(type)
  unique(plot_data$`Frequency change trend`)
  write.csv(plot_data,"三亚群一起比较_change.csv",row.names = F)
  # write.csv(plot_data,"data4plot_change.csv",row.names = F)
  table(plot_data$`Frequency change trend`)
  
  
  # plot change -------------------------------------------------------------
  
  dat <- plot_data %>% select(1,5:8)
  colnames(dat)[2:4]=c("NonChina", "China2", "China1")
  
  d2 <- dat %>% gather(Type,Frequency,-c(`Frequency change trend`,gene))
  d2$Type <- factor(d2$Type,levels = c("NonChina","China2","China1"))
  
  p=ggplot(d2,aes(Type,Frequency,color=`Frequency change trend`,group=gene))+
    geom_line(size=1)+
    cowplot::theme_cowplot()+
    scale_color_manual(values = c("red","blue","gray"))+
    labs(x="");p
  ggsave(p,filename = "三亚群一起比较_freq_change.png",width = 8,height = 6,dpi = 300)
  ggsave(p,filename = "三亚群一起比较_freq_change.pdf",width = 8,height = 6)
  
  
  
  # # ## 两亚群分别做频率变化 -----------------------------------------------------------
  # 
  # 
  # #filter no change gene 
  # idx2 <- apply(data_freq,1,function(x)as.numeric(x[5])==as.numeric(x[6]) && as.numeric(x[6])==as.numeric(x[7]))
  # data_freq2 <- data_freq[!idx2,]
  # str(data_freq2)
  # ## add type
  # x <- apply(data_freq2, 1, function(x){
  #   if(x[5]>=x[6] && x[6]>=x[7]){
  #     "Constantly down"
  #   }else if(x[5]<=x[6] && x[6]<=x[7]){
  #     "Constantly up"
  #   }else if((x[5]<=x[6] && x[6]>=x[7]) || (x[5]>=x[6] && x[6]<=x[7])){
  #     "Reverse"
  #   }else{
  #     "Other"
  #   }
  # })
  # data_freq2$`Frequency change trend`= unlist(x)
  # unique(data_freq2$`Frequency change trend`)
  # 
  # ## 两亚群分别做频率变化
  # 
  # ##nonchina-land 把China1加进去
  # f1 <- data_freq2[match(rownames(nonchina_land_gene),data_freq2$gene),] %>% select(1,5:8)
  # colnames(f1)[2:4]=c("NonChina", "China2", "China1")
  # 
  # d2 <- f1 %>% gather(Type,Frequency,-c(`Frequency change trend`,gene))
  # d2$Type <- factor(d2$Type,levels = c("NonChina","China2","China1"))
  # 
  # p=ggplot(d2,aes(Type,Frequency,color=`Frequency change trend`,group=gene))+
  #   geom_line(size=1)+
  #   cowplot::theme_cowplot()+
  #   scale_color_manual(values = c("red","blue","gray"))+
  #   labs(x="");p
  # ggsave(p,filename = "nonchina-China2-3类.png",width = 8,height = 6,dpi = 300)
  # ggsave(p,filename = "nonchina-China2-3类.pdf",width = 8,height = 6)
  # write.csv(f1,"nonchina-China2-3类.csv",row.names=F)
  # 
  # ##nonchina-land 不把China1加进去
  # idx2 <- apply(data_freq,1,function(x)as.numeric(x[5])==as.numeric(x[6]))
  # tmp <- data_freq[!idx2,]
  # tmp$`Frequency change trend` <- unlist(apply(tmp, 1, function(x){if(x[5]>x[6]){"Down"}else{"Up"}}))
  # f1 <- tmp[match(rownames(nonchina_land_gene),tmp$gene),] %>% select(1,5,6,8)
  # colnames(f1)[2:3]=c("NonChina", "China2")
  # d2 <- f1 %>% gather(Type,Frequency,-c(`Frequency change trend`,gene))
  # d2$Type <- factor(d2$Type,levels = c("NonChina","China2"))
  # p=ggplot(d2,aes(Type,Frequency,color=`Frequency change trend`,group=gene))+
  #   geom_line(size=1)+
  #   cowplot::theme_cowplot()+
  #   scale_color_manual(values = c("red","blue"))+
  #   labs(x="");p
  # ggsave(p,filename = "nonchina-China2-2类.png",width = 8,height = 6,dpi = 300)
  # ggsave(p,filename = "nonchina-China2-2类.pdf",width = 8,height = 6)
  # write.csv(f1,"nonchina-China2-2类.csv",row.names=F)
  # 
  # 
  # land_cul_gene
  # 
  # ##land-China1 把nonchina加进去
  # f2 <- data_freq2[match(rownames(land_cul_gene),data_freq2$gene),] %>% select(1,5:8)
  # colnames(f2)[2:4]=c("NonChina", "China2", "China1")
  # 
  # d2 <- f2 %>% gather(Type,Frequency,-c(`Frequency change trend`,gene))
  # d2$Type <- factor(d2$Type,levels = c("NonChina","China2","China1"))
  # 
  # p=ggplot(d2,aes(Type,Frequency,color=`Frequency change trend`,group=gene))+
  #   geom_line(size=1)+
  #   cowplot::theme_cowplot()+
  #   scale_color_manual(values = c("red","blue","gray"))+
  #   labs(x="");p
  # ggsave(p,filename = "China2-China1-3类.png",width = 8,height = 6,dpi = 300)
  # ggsave(p,filename = "China2-China1-3类.pdf",width = 8,height = 6)
  # write.csv(f2,"China2-China1-3类.csv",row.names=F)
  # 
  # ##land-China1 不把nonchina加进去
  # idx2 <- apply(data_freq2,1,function(x)as.numeric(x[6])==as.numeric(x[7]))
  # tmp <- data_freq[!idx2,]
  # tmp$`Frequency change trend` <- unlist(apply(tmp, 1, function(x){if(x[6]>x[7]){"Down"}else{"Up"}}))
  # f1 <- tmp[match(rownames(land_cul_gene),tmp$gene),] %>% select(1,6,7,8)
  # f1 <- na.omit(f1)
  # colnames(f1)[2:3]=c("China2", "China1")
  # d2 <- f1 %>% gather(Type,Frequency,-c(`Frequency change trend`,gene))
  # d2$Type <- factor(d2$Type,levels = c("China2", "China1"))
  # p=ggplot(d2,aes(Type,Frequency,color=`Frequency change trend`,group=gene))+
  #   geom_line(size=1)+
  #   cowplot::theme_cowplot()+
  #   scale_color_manual(values = c("red","blue"))+
  #   labs(x="");p
  # ggsave(p,filename = "China2-China1-2类.png",width = 8,height = 6,dpi = 300)
  # ggsave(p,filename = "China2-China1-2类.pdf",width = 8,height = 6)
  # write.csv(f1,"China2-China1-2类.csv",row.names=F)
  
  
  
  # 有利基因 --------------------------------------------------------------------
  
  ## favorable  频率上升
  fav <- plot_data %>% filter(`Frequency change trend`=="Constantly up")
  write.csv(fav,"favorable.csv",row.names = F)
  
  ## unfavorable 频率下降
  unfav <- plot_data %>% filter(`Frequency change trend`=="Constantly down")
  write.csv(unfav,"unfavorable.csv",row.names = F)
  
  
  # ##和第三次比较
  # fav1 <- read.csv("../客户第三次材料分类/favorable.csv",header = T)
  # head(fav1)
  # unfav1 <- read.csv("../客户第三次材料分类/unfavorable.csv",header = T)
  # head(unfav1)
  # 
  # length(intersect(fav$gene,fav1$gene))
  # length(intersect(unfav$gene,unfav1$gene))
  
  
}
