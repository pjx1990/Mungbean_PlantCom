##############
## combine blue and no blue phenotype data
#############
rm(list = ls())
library(tidyverse)
setwd("F:/项目分析/GWAS/表型数据/BLUP/BLUE")
f=list.files(path = "./",pattern = "\\w+_blue.csv")
f

dat=NULL
for(i in 1:length(f)){
  print(i)
  data=read.csv(f[i],header = T)
  dat[[i]]=data[,1:2]
}
# tmp=read.csv(f[1],header = T) %>% select(SampleID)
allblue=data.frame(do.call(cbind,dat)) %>% 
  select(!matches("SampleID."))

write.table(allblue,"BLUE_trait18.txt",quote = F,sep = "\t",col.names = T,row.names = F)



# other dont calucate blue traits -----------------------------------------

alltrait=read.table("../all_phe.txt",header = T)                   
other_trait=c("BDC","BR","CHP","FLC","PDS","TLS","PDC","RFW","PLC","SDC","SDCG","TLC","YSC")
other=alltrait[,c("SampleID", "Location", "Year", "Season",other_trait)]

new_data=NULL
for(i in 1:(ncol(other)-4)){
  j= i+4
  pdat=other[,c(1:4,j)];names(pdat)
  tmp=pdat
  names(tmp)[ncol(tmp)]="y";names(tmp)

  # a=data.frame(SampleID=sort(unique(other$SampleID)))
  # blue_res=full_join(ble_res,a,by="SampleID") %>% arrange(SampleID)
  
  real_mean <- tmp[,c(1,ncol(tmp))] %>% 
    group_by(SampleID) %>% 
    summarise(real_mean=mean(y,na.rm = T))
  names(real_mean)[2]=names(pdat)[ncol(pdat)]
  new_data[[i]]=real_mean
}
new_data[[1]]
other_data=data.frame(do.call(cbind,new_data))%>% 
  select(!matches("SampleID."))
other_data[other_data=="NaN"] <- NA

write.table(other_data,"noBLUE_trait13.txt",quote = F,sep = "\t",col.names = T,row.names = F)


# merge -------------------------------------------------------------------

alltidydata=full_join(allblue,other_data,by="SampleID")
write.table(alltidydata,"all_trait31.txt",quote = F,sep = "\t",col.names = T,row.names = F)
