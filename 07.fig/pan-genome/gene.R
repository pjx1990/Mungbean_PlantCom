############################
## 适应和改良过程中gene频率持续上升和下降的gene
############################
rm(list = ls())
library(tidyverse)

fun <- read.delim("../../allgene.function.anno.txt",header = T)


# 持续上升 --------------------------------------------------------------------

ad_up <- read.csv("../GO/adaption_up.gene.csv",header = T)
im_up <- read.csv("../GO/improve_up.gene.csv",header = T)

ov_up <- inner_join(ad_up[1],im_up,by="Gene")
write.csv(ov_up,"持续上升favoriable_gene.csv",row.names = F)


# 持续下降 --------------------------------------------------------------------

ad_down <- read.csv("../GO/improve_up.gene.csv",header = T)
im_down <- read.csv("../GO/improve_down.gene.csv",header = T)
ov_down <- inner_join(ad_down[1],im_down,by="Gene")
write.csv(ov_down,"持续下降unfavoriable_gene.csv",row.names = F)
