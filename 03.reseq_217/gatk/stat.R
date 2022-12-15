######################
#### 测序深度和比对率统计
#####################
rm(list = ls())
library(tidyverse)

setwd("F:/项目分析/群体变异")

# 测序深度 --------------------------------------------------------------------

dep=read.table("vigna.depth.txt")
head(dep)
# ggplot(dep,aes(y=V2))+geom_boxplot()
dep_median=median(dep$V2)
dep_mean=mean(dep$V2)

p=ggplot(dep,aes(x=V2))+
  geom_histogram(binwidth = 1,colour="black",fill="blue",alpha=0.5)+
  geom_vline(xintercept = dep_mean,color="red",linetype=2,size=1.5)+
  geom_rug()+
  # annotate("text", x=13, y=75,label= paste0("Mean Depth = ",round(dep_mean,2)),size=5)+
  labs(x="Depth(X)",y="Sample Numbers")+
  cowplot::theme_cowplot();p
ggsave(p,filename = "sequen_depth.png",width = 8,height = 6,dpi = 300)


# 比对率 ---------------------------------------------------------------------


map=read.delim("allmapping.txt",sep = ":",header = F)
head(map)
map$V2
map$V1=gsub("[.]flagstat","",map$V1)
map2 <- map %>% separate(col=V2,into = c("Mapping","Rate"),sep = "\\(")
map2$Mapping=gsub("\\d+ \\+ 0 mapped","Mapped",map2$Mapping)
map2$Mapping=gsub("\\d+ \\+ 0 properly paired","Properly paired",map2$Mapping)
map2$Rate=as.numeric(gsub("% ","",map2$Rate))

mean(map2$Rate)
p=ggplot(map2,aes(x=Mapping,y=Rate,fill=Mapping))+
  geom_violin(trim = F,color="white")+
  geom_boxplot(width=0.2,position = position_dodge(0.9))+
  scale_fill_manual(values = c("#56B4E9", "#E69F00"))+
  guides(fill=F)+
  labs(x="",y="Mapping Rate(%)")+
  cowplot::theme_cowplot();p
ggsave(p,filename = "mapping_rate.png",width = 6,height = 6,dpi = 300)
