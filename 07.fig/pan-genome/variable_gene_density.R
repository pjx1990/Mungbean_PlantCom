########################
## 泛基因组可变基因（shell+cloud）密度分布
########################
rm(list = ls())
library(tidyverse)


gene <- read.delim("variable_gene_pos.txt",header = F,sep = "\t")
head(gene)
str(gene)
gene_mean <- gene %>% mutate(gene_average_pos=round((V3+V4)/2)) %>% 
  select(V1,V2,gene_average_pos) %>% 
  filter(grepl("^\\d",V2))

library(CMplot)
CMplot(gene_mean,plot.type = "d",
       bin.size = 1e6,
       file="jpg",
       main = "test",
       # memo="variable_density",
       dpi=300)

myfun <- CMplot
source("myfun.r")
myfun(gene_mean,plot.type = "d",
      bin.size = 1e6,
      file="jpg",
      # memo="variable_density",
      dpi=300)

myfun(gene_mean,plot.type = "d",
      bin.size = 1e6,
      file="pdf")
