########################
### 两类材料中各地区数目，群体多样性统计
#######################
rm(list = ls())
library(tidyverse)

setwd("F:\\Paper\\数据整理\\fig\\群体进化\\进化树217\\结合pav聚为两类")

data <- read.delim("allsample.txt",header = T,sep = "\t")
head(data)

s_data <- data %>% 
  filter(Data.Source=="This study") %>% 
  select(Province.PRC,Group.in.phylogenetic.tree)

table(s_data)



# 多样性Pi (1k window) -------------------------------------------------------------------

g1_pi <- read.delim("G1_1k.windowed.pi",sep = "\t")
head(g1_pi)
mean(g1_pi$PI)
# 0.002479476

g2_pi <- read.delim("G2_1k.windowed.pi",sep = "\t")
head(g2_pi)
mean(g2_pi$PI)
# 0.001882763



# 多样性Fst (10kb window) ------------------------------------------------------------------


fst <- read.delim("G1-G2_10k.windowed.weir.fst",sep = "\t")
head(fst)
mean(fst$MEAN_FST)
# 0.1861495


bl_pbl <- read.delim("landrace-cultivar.windowed.weir.fst",sep = "\t")
mean(bl_pbl$MEAN_FST)
# 0.03813367



# 东亚和南亚的中国和印度材料占比 ---------------------------------------------------------

head(data)
china <- data %>% 
  filter(Region=="East Asia")
table(china$Country)
202/241

india <- data %>% 
  filter(Region=="South Asia")
table(india$Country)
331/358


##全部比例
table(data$Country)
# 202/750  #chinese mailand
331/750 #india

