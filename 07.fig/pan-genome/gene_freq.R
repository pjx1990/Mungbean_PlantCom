############################
## 适应和改良过程中gene频率上升和下降的gene
############################
rm(list = ls())
library(tidyverse)

fun <- read.delim("../../allgene.function.anno.txt",header = T)


# 适应 --------------------------------------------------------------------

ad <- read.csv("../GO/适应gene/adapt_gene.csv",header = T)
ad_up <- ad %>% filter(Change=="Up")
ov_up <- inner_join(fun,ad_up,by="Gene") %>% arrange(NonChina.Landrace.P) %>% 
  select(1,13,14,4,5,2,3,6,7:12,15:16)
write.csv(ov_up,"适应过程频率上升_gene.csv",row.names = F)

ad_down <- ad %>% filter(Change=="Down")
ov_down <- inner_join(fun,ad_down,by="Gene") %>% arrange(NonChina.Landrace.P) %>% 
  select(1,13,14,4,5,2,3,6,7:12,15:16)
write.csv(ov_down,"适应过程频率下降_gene.csv",row.names = F)


# 改良 --------------------------------------------------------------------

im <- read.csv("../GO/改良gene/improve_gene.csv",header = T)
im_up <- im %>% filter(Change=="Up")
ov2_up <- inner_join(fun,im_up,by="Gene") %>% arrange(Landrace.Cultivar.P) %>% 
  select(1,15,16,4,5,2,3,6,7:14)
write.csv(ov2_up,"改良过程频率上升_gene.csv",row.names = F)

im_down <- im %>% filter(Change=="Down")
ov2_down <- inner_join(fun,im_down,by="Gene") %>% arrange(Landrace.Cultivar.P) %>% 
  select(1,15,16,4,5,2,3,6,7:14)
write.csv(ov2_down,"改良过程频率下降_gene.csv",row.names = F)
