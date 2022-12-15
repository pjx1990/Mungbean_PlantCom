library(dplyr)
cul <- read.delim("/project/pengjx/mungbean/04.sweep/gwas-217-allsnp/sweep/cultivar.windowed.pi",header = T,sep = "\t")
land <- read.delim("/project/pengjx/mungbean/04.sweep/gwas-217-allsnp/sweep/landrace.windowed.pi",header = T,sep = "\t")

data=inner_join(cul,land,by=c("CHROM","BIN_START","BIN_END"))
data2 <- data %>% mutate(ROD=1-PI.x/PI.y) %>% select(1:3,8)
write.table(data2,"ROD_10kb.win.xls",col.names=T,row.names=F,sep="\t",quote=F)
