###########################
## 表型BLUE计算
##########################
rm(list = ls())
setwd("F:/1-项目分析/GWAS/表型数据/BLUP")
library(tidyverse)
library(lme4)


# 导入多年多点多季节表型 -------------------------------------------------------------


sjz2017spring=read.delim("2017shijiazhuang-spring.txt",header = T,row.names = 1)
head(sjz2017spring)
sjz2017summer=read.delim("2017shijiazhuang-summer.txt",header = T,row.names = 1)
head(sjz2017summer)
sjz2018spring=read.delim("2018shijiazhuang-spring.txt",header = T,row.names = 1)
head(sjz2018spring)
sjz2018summer=read.delim("2018shijiazhuang-summer.txt",header = T,row.names = 1)
head(sjz2018summer)
zjk2018spring=read.delim("2018zhangjiakou-spring.txt",header = T,row.names = 1)
head(zjk2018spring)
zjk2018summer=read.delim("2018zhangjiakou-summer.txt",header = T,row.names = 1)
head(zjk2018summer)

colnames(sjz2017spring)=n1=gsub("(\\w+)_\\d+\\w+","\\1",colnames(sjz2017spring))
colnames(sjz2017summer)=n2=gsub("(\\w+)_\\d+\\w+","\\1",colnames(sjz2017summer))
colnames(sjz2018spring)=n3=gsub("(\\w+)_\\d+\\w+","\\1",colnames(sjz2018spring))
colnames(sjz2018summer)=n4=gsub("(\\w+)_\\d+\\w+","\\1",colnames(sjz2018summer))
colnames(zjk2018spring)=n5=gsub("(\\w+)_\\d+\\w+","\\1",colnames(zjk2018spring))
colnames(zjk2018summer)=n6=gsub("(\\w+)_\\d+\\w+","\\1",colnames(zjk2018summer))

overlap=Reduce(intersect,list(n1,n2,n3,n4,n5,n6));overlap
alln=Reduce(union,list(n1,n2,n3,n4,n5,n6));alln
setdiff(n1,overlap)
setdiff(n2,overlap)
setdiff(n3,overlap)
setdiff(n4,overlap)
setdiff(n5,overlap)
setdiff(n6,overlap)


## 合并所有表型

data=plyr::rbind.fill(sjz2017spring,
                      sjz2017summer,
                      sjz2018spring,
                      sjz2018summer,
                      zjk2018spring,
                      zjk2018summer)
identical(colnames(data),alln)

data$SampleID=rep(rownames(sjz2017spring),times=6)
data$Location=rep(c("SJZ","ZJK"),times=c(217*4,217*2))
data$Year=rep(c("2017","2018"),times=c(217*2,217*4))
data$Season=rep(c("Spring","Summer","Spring","Summer","Spring","Summer"),each=217)

alldata=data[,c(32:35,1:31)]
write.table(alldata,"all_phe.txt",sep = "\t",col.names = T,row.names = F,quote = F)


# # 比较duo年多点表型 --------------------------------------------------------------
# 
# for(i in 5:ncol(alldata)){
#   # i=5
#   pdat=alldata[,c(1:4,i)];names(pdat)
#   tmp=pdat
#   names(tmp)[ncol(tmp)]="trait";names(tmp)
#   p=ggplot(tmp,aes(Year,trait))+
#     geom_violin()+
#     geom_boxplot(width=0.1)+
#     ylab(names(pdat)[ncol(pdat)])+
#     # facet_wrap(~Season+Location)
#     facet_wrap(~ Location+Season);p
#   ggsave(p,filename = paste0(names(pdat)[ncol(pdat)],".png"),width = 8,height = 6,dpi = 300)
# }



# BLUP/BLUE计算 -------------------------------------------------------------------


library(lsmeans)

alldata$Location=factor(alldata$Location)
alldata$Year=factor(alldata$Year)
alldata$Season=factor(alldata$Season)


##同时考虑Year+Season+Location的性状
# syl_trait=c("BRN","FLD","HECL","MLA","MLL","MLW","MSNN","PDL","PDTN","PDW","PLH","SD100WT","SDNPPD","YPPL")
syl_trait=c("MLW","MSNN","PDL","PDTN","PDW","PLH","SD100WT","SDNPPD","YPPL")
##不考虑做BLUE的性状
no_trait=c("BDC","BR","CHP","FLC","PDS","TLS","PDC","RFW","PLC","SDC","SDCG","TLC","YSC")
##考虑Year+Location的性状
yl_trait=c("GRH")
##考虑Year+Season的性状
ys_trait=c("MSD")
##考虑Location
l_trait=c("CPC","CSC")


# 同时考虑Year+Season+Location ------------------------------------------------

syl_trait_data <- alldata[,c("SampleID", "Location", "Year", "Season",syl_trait)]

blue_data=NULL
for(i in 5:ncol(syl_trait_data)){
  # i=5
  pdat=syl_trait_data[,c(1:4,i)];names(pdat)
  tmp=pdat
  names(tmp)[ncol(tmp)]="y";names(tmp)
  # summary(tmp$y)
  ## BLUE
  ble=lmer(y~ SampleID +(1|Year)+(1|Location)+(1|Season),data = tmp)
  # as.data.frame(fixef(ble))
  
  re = lsmeans::lsmeans(ble,"SampleID")
  ble_res=as.data.frame(re)
  # summary(ble_res$lsmean)
  
  a=data.frame(SampleID=sort(unique(syl_trait_data$SampleID)))
  blue_res=full_join(ble_res,a,by="SampleID") %>% arrange(SampleID)
  
  real_mean <- tmp[,c(1,ncol(tmp))] %>% 
    group_by(SampleID) %>% 
    summarise(real_mean=mean(y))
  
  # png(paste0(names(pdat)[ncol(pdat)],"_blue-mean_scatterplot.png"))
  # plot(blue_res$lsmean,real_mean$real_mean)
  # dev.off()
  
  names(blue_res)[2]=names(pdat)[ncol(pdat)]
  # blue_data[[i]]=blue_res[1:2]
  blue_data[[i]]=blue_res
  write.csv(blue_data[[i]],paste0(names(pdat)[ncol(pdat)],"_blue.csv"),row.names = F)
}
# blue_alldata <- do.call(cbind,blue_data)




# 考虑Year+Location ---------------------------------------------------------

yl_trait_data <- alldata[,c("SampleID", "Location", "Year", "Season",yl_trait)]

blue_data=NULL
for(i in 5:ncol(yl_trait_data)){
  # i=8
  pdat=yl_trait_data[,c(1:4,i)];names(pdat)
  tmp=pdat
  names(tmp)[ncol(tmp)]="y";names(tmp)
  # summary(tmp$y)
  ## BLUE
  ble=lmer(y~ SampleID +(1|Year)+(1|Location),data = tmp)
  # as.data.frame(fixef(ble))
  
  re = lsmeans::lsmeans(ble,"SampleID")
  ble_res=as.data.frame(re)
  # summary(ble_res$lsmean)
  
  a=data.frame(SampleID=sort(unique(yl_trait_data$SampleID)))
  blue_res=full_join(ble_res,a,by="SampleID") %>% arrange(SampleID)
  
  real_mean <- tmp[,c(1,ncol(tmp))] %>% 
    group_by(SampleID) %>% 
    summarise(real_mean=mean(y))
  
  # png(paste0(names(pdat)[ncol(pdat)],"_blue-mean_scatterplot.png"))
  # plot(blue_res$lsmean,real_mean$real_mean)
  # dev.off()
  
  names(blue_res)[2]=names(pdat)[ncol(pdat)]
  # blue_data[[i]]=blue_res[1:2]
  blue_data[[i]]=blue_res
  write.csv(blue_data[[i]],paste0(names(pdat)[ncol(pdat)],"_blue.csv"),row.names = F)
}




# 考虑Year+Season -----------------------------------------------------------

ys_trait_data <- alldata[,c("SampleID", "Location", "Year", "Season",ys_trait)]

blue_data=NULL
for(i in 5:ncol(ys_trait_data)){
  # i=8
  pdat=ys_trait_data[,c(1:4,i)];names(pdat)
  tmp=pdat
  names(tmp)[ncol(tmp)]="y";names(tmp)
  # summary(tmp$y)
  ## BLUE
  ble=lmer(y~ SampleID +(1|Year)+(1|Season),data = tmp)
  # as.data.frame(fixef(ble))
  
  re = lsmeans::lsmeans(ble,"SampleID")
  ble_res=as.data.frame(re)
  # summary(ble_res$lsmean)
  
  a=data.frame(SampleID=sort(unique(ys_trait_data$SampleID)))
  blue_res=full_join(ble_res,a,by="SampleID") %>% arrange(SampleID)
  
  real_mean <- tmp[,c(1,ncol(tmp))] %>% 
    group_by(SampleID) %>% 
    summarise(real_mean=mean(y))
  
  # png(paste0(names(pdat)[ncol(pdat)],"_blue-mean_scatterplot.png"))
  # plot(blue_res$lsmean,real_mean$real_mean)
  # dev.off()
  
  names(blue_res)[2]=names(pdat)[ncol(pdat)]
  # blue_data[[i]]=blue_res[1:2]
  blue_data[[i]]=blue_res
  write.csv(blue_data[[i]],paste0(names(pdat)[ncol(pdat)],"_blue.csv"),row.names = F)
}



# 考虑Location --------------------------------------------------------------

l_trait_data <- alldata[,c("SampleID", "Location", "Year", "Season",l_trait)]

blue_data=NULL
for(i in 5:ncol(l_trait_data)){
  # i=8
  pdat=l_trait_data[,c(1:4,i)];names(pdat)
  tmp=pdat
  names(tmp)[ncol(tmp)]="y";names(tmp)
  # summary(tmp$y)
  ## BLUE
  ble=lmer(y~ SampleID +(1|Location),data = tmp)
  # as.data.frame(fixef(ble))
  
  re = lsmeans::lsmeans(ble,"SampleID")
  ble_res=as.data.frame(re)
  # summary(ble_res$lsmean)
  
  a=data.frame(SampleID=sort(unique(l_trait_data$SampleID)))
  blue_res=full_join(ble_res,a,by="SampleID") %>% arrange(SampleID)
  
  real_mean <- tmp[,c(1,ncol(tmp))] %>% 
    group_by(SampleID) %>% 
    summarise(real_mean=mean(y))
  
  # png(paste0(names(pdat)[ncol(pdat)],"_blue-mean_scatterplot.png"))
  # plot(blue_res$lsmean,real_mean$real_mean)
  # dev.off()
  
  names(blue_res)[2]=names(pdat)[ncol(pdat)]
  # blue_data[[i]]=blue_res[1:2]
  blue_data[[i]]=blue_res
  write.csv(blue_data[[i]],paste0(names(pdat)[ncol(pdat)],"_blue.csv"),row.names = F)
}



####################################################################################
### BLUP
# blp=lmer(y~(1|Location)+(1|Year)+(1|Season)+(1|SampleID),data = tmp)
# summary(blp)
# 
# H=28.189/(28.189+29.444/2)
# 
# blups= ranef(blp)
# names(blups)
# lines=blups$SampleID+blp@beta
# res=data.frame(id=rownames(lines),blup=lines)
# write.table(res,file="data_blup_result.txt",row.names = F,quote = F,sep="\t")
# hist(lines[,1],col="#0AB3CA",border="white",xlab="BLUP of lines",main="")






