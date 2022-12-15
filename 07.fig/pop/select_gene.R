##################
## ROD
library(tidyverse)
rod <- read.csv("ROD.csv",header = T)
head(rod)

data= rod %>% 
  group_by(CHROM,BIN_START,BIN_END) %>% 
  summarise(GeneCount=n())

write.table(data,"select_region_gene.xls",row.names = F,col.names = F,quote = F,sep = "\t")
