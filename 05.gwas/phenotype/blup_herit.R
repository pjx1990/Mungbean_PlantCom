#############################
## BLUP和遗传力
#############################
#https://blog.csdn.net/yijiaobani/article/details/90215314
setwd("F:\\1-项目分析\\GWAS\\表型数据\\20210716全部表型处理\\BLUP")
rm(list = ls())
library(tidyverse)
library(lme4)
library(lmerTest)

# data <- read.delim("../all_phenotype_fixPDW.txt",header = T) %>% 
#   arrange(Sample)

data <- read.delim("../allphe_outlier_NA.txt",header = T) %>% 
  arrange(Sample)
colnames(data) <- gsub("ZJK","ZJK_summer",colnames(data))
colnames(data) <- gsub("2017","2017_",colnames(data))
colnames(data) <- gsub("2018","2018_",colnames(data))
colnames(data)



# BRN ---------------------------------------------------------------------


BRN <- data %>% select(1,starts_with("BRN")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")

BRN$Sample <- as.factor(BRN$Sample)
BRN$year <- as.factor(BRN$year)
BRN$loc <- as.factor(BRN$loc)
BRN$season <- as.factor(BRN$season)
str(BRN)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
          (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
        data=BRN)
summary(mod)

#提取方差
var=VarCorr(mod);var
# as.numeric(var[,"Variance"])
unclass(var)

#遗传力
vg=1.960e-01  #品种方差
vgl=1.056e-10 #品种与地点交互方差
vgy=0 #品种与年份交互方差
vgs=0 #品种与季节交互方差
ve=1.001e+00   #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
BRN_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(BRN_blup,"BRN_blup.csv",col.names = F)
write.table(BRN_blup$X.Intercept.,"BRN_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(BRN$value,BRN$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(BRN_blup$X.Intercept.,mm$mean)


# PDL ----------------------------------------------------------------------

PDL <- data %>% select(1,starts_with("PDL")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
PDL$Sample <- as.factor(PDL$Sample)
PDL$year <- as.factor(PDL$year)
PDL$loc <- as.factor(PDL$loc)
PDL$season <- as.factor(PDL$season)
str(PDL)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=PDL)
summary(mod)

#提取方差
# var=VarCorr(mod);var
# # as.numeric(var[,"Variance"])
# unclass(var)
# mod@devcomp

#遗传力
vg=1.7154618    #品种方差
vgl=0.0141102   #品种与地点交互方差
vgy=0.0408703   #品种与年份交互方差
vgs=0.0500171    #品种与季节交互方差
ve=0.3573246     #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
PDL_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(PDL_blup,"PDL_blup.csv",col.names = F)
write.table(PDL_blup$X.Intercept.,"PDL_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(PDL$value,PDL$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(PDL_blup$X.Intercept.,mm$mean)


# PDTN ----------------------------------------------------------------------

PDTN <- data %>% select(1,starts_with("PDTN")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
PDTN$Sample <- as.factor(PDTN$Sample)
PDTN$year <- as.factor(PDTN$year)
PDTN$loc <- as.factor(PDTN$loc)
PDTN$season <- as.factor(PDTN$season)
str(PDTN)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=PDTN)
summary(mod)

#遗传力
vg=43.70       #品种方差
vgl=0  #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=143.99    #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
PDTN_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(PDTN_blup,"PDTN_blup.csv",col.names = F)
write.table(PDTN_blup$X.Intercept.,"PDTN_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(PDTN$value,PDTN$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(PDTN_blup$X.Intercept.,mm$mean)



# PDW ----------------------------------------------------------------------

PDW <- data %>% select(1,starts_with("PDW")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
PDW$Sample <- as.factor(PDW$Sample)
PDW$year <- as.factor(PDW$year)
PDW$loc <- as.factor(PDW$loc)
PDW$season <- as.factor(PDW$season)
str(PDW)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=PDW)
summary(mod)

#遗传力
vg=1.987e-01   #品种方差
vgl=8.873e-01  #品种与地点交互方差
vgy=2.890e-03  #品种与年份交互方差
vgs=1.835e-02  #品种与季节交互方差
ve=8.457e-02   #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
PDW_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(PDW_blup,"PDW_blup.csv",col.names = F)
write.table(PDW_blup$X.Intercept.,"PDW_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(PDW$value,PDW$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(PDW_blup$X.Intercept.,mm$mean)


# SD100WT ----------------------------------------------------------------------

SD100WT <- data %>% select(1,starts_with("SD100WT")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
SD100WT$Sample <- as.factor(SD100WT$Sample)
SD100WT$year <- as.factor(SD100WT$year)
SD100WT$loc <- as.factor(SD100WT$loc)
SD100WT$season <- as.factor(SD100WT$season)
str(SD100WT)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=SD100WT)
summary(mod)

#遗传力
vg=1.33222     #品种方差
vgl=0  #品种与地点交互方差
vgy=0 #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=0.18775     #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
SD100WT_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(SD100WT_blup,"SD100WT_blup.csv",col.names = F)
write.table(SD100WT_blup$X.Intercept.,"SD100WT_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(SD100WT$value,SD100WT$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(SD100WT_blup$X.Intercept.,mm$mean)


# SDNPPD ----------------------------------------------------------------------

SDNPPD <- data %>% select(1,starts_with("SDNPPD")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
SDNPPD$Sample <- as.factor(SDNPPD$Sample)
SDNPPD$year <- as.factor(SDNPPD$year)
SDNPPD$loc <- as.factor(SDNPPD$loc)
SDNPPD$season <- as.factor(SDNPPD$season)
str(SDNPPD)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=SDNPPD)
summary(mod)

#遗传力
vg=3.239e-01  #品种方差
vgl=6.147e-09  #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=6.797e-01   #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
SDNPPD_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(SDNPPD_blup,"SDNPPD_blup.csv",col.names = F)
write.table(SDNPPD_blup$X.Intercept.,"SDNPPD_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(SDNPPD$value,SDNPPD$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(SDNPPD_blup$X.Intercept.,mm$mean)


# YPPL ----------------------------------------------------------------------

YPPL <- data %>% select(1,starts_with("YPPL")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
YPPL$Sample <- as.factor(YPPL$Sample)
YPPL$year <- as.factor(YPPL$year)
YPPL$loc <- as.factor(YPPL$loc)
YPPL$season <- as.factor(YPPL$season)
str(YPPL)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=YPPL)
summary(mod)

#遗传力
vg=7.402      #品种方差
vgl=0 #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=34.982  #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
YPPL_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(YPPL_blup,"YPPL_blup.csv",col.names = F)
write.table(YPPL_blup$X.Intercept.,"YPPL_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(YPPL$value,YPPL$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(YPPL_blup$X.Intercept.,mm$mean)


# CPC ----------------------------------------------------------------------

CPC <- data %>% select(1,starts_with("CPC")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
CPC$Sample <- as.factor(CPC$Sample)
CPC$year <- as.factor(CPC$year)
CPC$loc <- as.factor(CPC$loc)
CPC$season <- as.factor(CPC$season)
str(CPC)

mod=lmer(value ~ (1|Sample) + (1|loc) + #(1|year) +(1|season) +
           (1|Sample:loc) ,#+ (1|Sample:year) + (1|Sample:season),
         data=CPC)
mod=lmer(value ~ (1|Sample) + (1|loc) ,data=CPC)
summary(mod)

#遗传力
vg=0.8630      #品种方差
vgl=0  #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=1.2455     #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/2);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
CPC_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(CPC_blup,"CPC_blup.csv",col.names = F)
write.table(CPC_blup$X.Intercept.,"CPC_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(CPC$value,CPC$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(CPC_blup$X.Intercept.,mm$mean)


# CSC ----------------------------------------------------------------------

CSC <- data %>% select(1,starts_with("CSC")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
CSC$Sample <- as.factor(CSC$Sample)
CSC$year <- as.factor(CSC$year)
CSC$loc <- as.factor(CSC$loc)
CSC$season <- as.factor(CSC$season)
str(CSC)

mod=lmer(value ~ (1|Sample) + (1|loc) ,data=CSC)
# mod=lmer(value ~ (1|Sample) + (1|loc) + (1|Sample:loc),data=CSC)
summary(mod)

#遗传力
vg=5.038          #品种方差
vgl=0  #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=1.220         #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/2);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
CSC_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(CSC_blup,"CSC_blup.csv",col.names = F)
write.table(CSC_blup$X.Intercept.,"CSC_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(CSC$value,CSC$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(CSC_blup$X.Intercept.,mm$mean)


# VITEXIN ----------------------------------------------------------------------

vite <- read.table("./vitexin.txt",header = T)
vite$Rep <- as.factor(vite$Rep)
vite$Sample <- as.factor(vite$Sample)
str(vite)
# vite <- read.table("../vitexin_raw.txt",header = T)
# vite$Sample <- as.factor(vite$Sample)

mod=lmer(VITEXIN ~ (1|Sample)+(1|Rep)+(1|Sample:Rep),data=vite)
mod=lmer(VITEXIN ~ (1|Rep),data=vite)
summary(mod)

#遗传力
vg=0.4308653           #品种方差
vgl=0   #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=0.0014451          #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/2);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
VITEXIN_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(VITEXIN_blup,"VITEXIN_blup.csv",col.names = F)
write.table(VITEXIN_blup$X.Intercept.,"VITEXIN_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(VITEXIN$value,VITEXIN$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(VITEXIN_blup$X.Intercept.,mm$mean)



# RFW ----------------------------------------------------------------------

RFW <- data %>% select(1,starts_with("RFW")) #%>% gather(key,value,-Sample) %>% 

BDC <- data %>% select(1,starts_with("BDC")) 
FLC <- data %>% select(1,starts_with("FLC")) 
PDC <- data %>% select(1,starts_with("PDC")) 
PLC <- data %>% select(1,starts_with("PLC")) 
SDC <- data %>% select(1,starts_with("SDC")) 
TLC <- data %>% select(1,starts_with("TLC")) 
YLC <- data %>% select(1,starts_with("YLC")) 




# PLH ----------------------------------------------------------------------

PLH <- data %>% select(1,starts_with("PLH")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
PLH$Sample <- as.factor(PLH$Sample)
PLH$year <- as.factor(PLH$year)
PLH$loc <- as.factor(PLH$loc)
PLH$season <- as.factor(PLH$season)
str(PLH)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=PLH)
summary(mod)

#遗传力
vg=1.142e+02  #品种方差
vgl=1.625e-06  #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=2.886e+02  #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
PLH_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(PLH_blup,"PLH_blup.csv",col.names = F)
write.table(PLH_blup$X.Intercept.,"PLH_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(PLH$value,PLH$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(PLH_blup$X.Intercept.,mm$mean)



# GRH ----------------------------------------------------------------------

GRH <- data %>% select(1,starts_with("GRH")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
GRH$Sample <- as.factor(GRH$Sample)
GRH$year <- as.factor(GRH$year)
GRH$loc <- as.factor(GRH$loc)
GRH$season <- as.factor(GRH$season)
str(GRH)

mod=lmer(value ~ (1|Sample) + (1|loc) ,
         data=GRH)
summary(mod)

#遗传力
vg=0.171165   #品种方差
vgl=0  #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=0.181213    #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/2);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
GRH_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(GRH_blup,"GRH_blup.csv",col.names = F)
write.table(GRH_blup$X.Intercept.,"GRH_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(GRH$value,GRH$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(GRH_blup$X.Intercept.,mm$mean)




# HECL ----------------------------------------------------------------------

HECL <- data %>% select(1,starts_with("HECL")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
HECL$Sample <- as.factor(HECL$Sample)
HECL$year <- as.factor(HECL$year)
HECL$loc <- as.factor(HECL$loc)
HECL$season <- as.factor(HECL$season)
str(HECL)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=HECL)
summary(mod)

#遗传力
vg=3.5486    #品种方差
vgl=0  #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=0  #品种与季节交互方差
ve=153.8730   #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
HECL_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(HECL_blup,"HECL_blup.csv",col.names = F)
write.table(HECL_blup$X.Intercept.,"HECL_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(HECL$value,HECL$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(HECL_blup$X.Intercept.,mm$mean)


# MLA ----------------------------------------------------------------------

MLA <- data %>% select(1,starts_with("MLA")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
MLA$Sample <- as.factor(MLA$Sample)
MLA$year <- as.factor(MLA$year)
MLA$loc <- as.factor(MLA$loc)
MLA$season <- as.factor(MLA$season)
str(MLA)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=MLA)
summary(mod)

#遗传力
vg=1.983e+06    #品种方差
vgl=0  #品种与地点交互方差
vgy=0  #品种与年份交互方差
vgs=6.706e-04  #品种与季节交互方差
ve=2.655e+06   #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
MLA_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(MLA_blup,"MLA_blup.csv",col.names = F)
write.table(MLA_blup$X.Intercept.,"MLA_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(MLA$value,MLA$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(MLA_blup$X.Intercept.,mm$mean)



# MLL ----------------------------------------------------------------------

MLL <- data %>% select(1,starts_with("MLL")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
MLL$Sample <- as.factor(MLL$Sample)
MLL$year <- as.factor(MLL$year)
MLL$loc <- as.factor(MLL$loc)
MLL$season <- as.factor(MLL$season)
str(MLL)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=MLL)
summary(mod)

#遗传力
vg=121.0974     #品种方差
vgl=0.5952    #品种与地点交互方差
vgy=22.0857    #品种与年份交互方差
vgs=8.4496    #品种与季节交互方差
ve=59.6539     #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
MLL_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(MLL_blup,"MLL_blup.csv",col.names = F)
write.table(MLL_blup$X.Intercept.,"MLL_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(MLL$value,MLL$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(MLL_blup$X.Intercept.,mm$mean)


# MLW ----------------------------------------------------------------------

MLW <- data %>% select(1,starts_with("MLW")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
MLW$Sample <- as.factor(MLW$Sample)
MLW$year <- as.factor(MLW$year)
MLW$loc <- as.factor(MLW$loc)
MLW$season <- as.factor(MLW$season)
str(MLW)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=MLW)
summary(mod)

#遗传力
vg=1.286e+02     #品种方差
vgl=2.235e-06    #品种与地点交互方差
vgy=7.627e-09    #品种与年份交互方差
vgs=0    #品种与季节交互方差
ve=7.100e+01     #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
MLW_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(MLW_blup,"MLW_blup.csv",col.names = F)
write.table(MLW_blup$X.Intercept.,"MLW_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(MLW$value,MLW$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(MLW_blup$X.Intercept.,mm$mean)


# MSD ----------------------------------------------------------------------

MSD <- data %>% select(1,starts_with("MSD")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
MSD$Sample <- as.factor(MSD$Sample)
MSD$year <- as.factor(MSD$year)
MSD$loc <- as.factor(MSD$loc)
MSD$season <- as.factor(MSD$season)
str(MSD)

mod=lmer(value ~ (1|Sample) + (1|year) +(1|season) +
            (1|Sample:year) + (1|Sample:season),
         data=MSD)
summary(mod)

#遗传力
vg=0.4598          #品种方差
vgl=0   #品种与地点交互方差
vgy=0    #品种与年份交互方差
vgs=0    #品种与季节交互方差
ve=1.3379          #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/4);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
MSD_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(MSD_blup,"MSD_blup.csv",col.names = F)
write.table(MSD_blup$X.Intercept.,"MSD_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(MSD$value,MSD$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(MSD_blup$X.Intercept.,mm$mean)



# MSNN ----------------------------------------------------------------------

MSNN <- data %>% select(1,starts_with("MSNN")) %>% gather(key,value,-Sample) %>% 
  separate(key,c("trait","year","loc","season"),sep = "_")
MSNN$Sample <- as.factor(MSNN$Sample)
MSNN$year <- as.factor(MSNN$year)
MSNN$loc <- as.factor(MSNN$loc)
MSNN$season <- as.factor(MSNN$season)
str(MSNN)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=MSNN)
summary(mod)

#遗传力
# vg=1.175     #品种方差
# vgl=6.214e-09   #品种与地点交互方差
# vgy=7.848e-10    #品种与年份交互方差
# vgs=0    #品种与季节交互方差
# ve=1.379     #残差
# h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

vg=9.301e-01     #品种方差
vgl=0   #品种与地点交互方差
vgy=4.772e-10    #品种与年份交互方差
vgs=0    #品种与季节交互方差
ve=1.185     #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
MSNN_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(MSNN_blup,"MSNN_blup.csv",col.names = F)
write.table(MSNN_blup$X.Intercept.,"MSNN_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(MSNN$value,MSNN$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(MSNN_blup$X.Intercept.,mm$mean)



# PDS ----------------------------------------------------------------------

PDS <- data %>% select(1,starts_with("PDS")) #%>% gather(key,value,-Sample) %>% 

TLS <- data %>% select(1,starts_with("TLS"))

# FLD ----------------------------------------------------------------------

FLD <- data %>% select(1,starts_with("FLD")) %>% gather(key,value,-Sample) %>% 
separate(key,c("trait","year","loc","season"),sep = "_")
FLD$Sample <- as.factor(FLD$Sample)
FLD$year <- as.factor(FLD$year)
FLD$loc <- as.factor(FLD$loc)
FLD$season <- as.factor(FLD$season)
str(FLD)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=FLD)
summary(mod)

#遗传力
vg=6.2331         #品种方差
vgl=2.8250       #品种与地点交互方差
vgy=0      #品种与年份交互方差
vgs=1.8274       #品种与季节交互方差
ve=8.0558         #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
FLD_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(FLD_blup,"FLD_blup.csv",col.names = F)
write.table(FLD_blup$X.Intercept.,"FLD_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(FLD$value,FLD$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(FLD_blup$X.Intercept.,mm$mean)


# SDCG ----------------------------------------------------------------------

SDCG <- data %>% select(1,starts_with("SDCG"))# %>% gather(key,value,-Sample) %>% 

# CHP ----------------------------------------------------------------------

CHP <- data %>% select(1,starts_with("CHP"))# %>% gather(key,value,-Sample) %>% 
separate(key,c("trait","year","loc","season"),sep = "_")
CHP$Sample <- as.factor(CHP$Sample)
CHP$year <- as.factor(CHP$year)
CHP$loc <- as.factor(CHP$loc)
CHP$season <- as.factor(CHP$season)
str(CHP)

mod=lmer(value ~ (1|Sample) + (1|loc) + (1|year) +(1|season) +
           (1|Sample:loc) + (1|Sample:year) + (1|Sample:season),
         data=CHP)
summary(mod)

#遗传力
vg=6.2331         #品种方差
vgl=2.8250       #品种与地点交互方差
vgy=0      #品种与年份交互方差
vgs=1.8274       #品种与季节交互方差
ve=8.0558         #残差
h2=vg/(vg+vgl/2+vgy/2+vgs/2+ve/8);h2 #遗传力 0?????

tmp <- data.frame(value=ranef(mod)$Sample)
tmp <- cbind(Sample=rownames(tmp),tmp)
head(tmp)
CHP_blup <- left_join(data[1],tmp,by="Sample")
# write.csv(CHP_blup,"CHP_blup.csv",col.names = F)
write.table(CHP_blup$X.Intercept.,"CHP_blup.txt",row.names = F,col.names = F)

##BLUP与均值相关性
mm=as.data.frame(tapply(CHP$value,CHP$Sample,na.rm=T,mean))
names(mm) <- "mean"
plot(CHP_blup$X.Intercept.,mm$mean)
