library(dplyr)
nonsyn=read.delim("nonsyn.snp.win.xls",header = F,sep = "\t")
syn=read.delim("syn.snp.win.xls",header = F,sep = "\t")

data=inner_join(nonsyn,syn,by=c("V1","V2","V3"))%>% 
	mutate(ratio=V4.x/V4.y)%>% select(1:3,6)
data[is.na(data)]=0
write.table(data,"nonsys_sys_100kb.win.xls",col.names=F,row.names=F,sep="\t",quote=F)
