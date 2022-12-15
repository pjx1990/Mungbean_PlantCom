#######################
## 表型分析
######################

setwd("F:\\1-项目分析\\GWAS\\表型数据\\20210716全部表型处理")

rm(list = ls())
library(tidyverse)
library(moments) #caculate skewness and kurtosis

# data <- read.delim("all_phenotype.txt",header = T,row.names = 1)
data <- read.delim("allphe_outlier_NA.txt",header = T,row.names = 1)
# data <- read.delim("allphe_outlier_NA_fixPDW.txt",header = T,row.names = 1)
colnames(data)
trait <- read.delim("trait_name.txt",header = F)
trait

BRN <- data %>% select(starts_with("BRN")) %>% gather(key,value)
PDL <- data %>% select(starts_with("PDL")) %>% gather(key,value)
PDTN <- data %>% select(starts_with("PDTN")) %>% gather(key,value)
PDW <- data %>% select(starts_with("PDW")) %>% select(-PDW_2018ZJK) %>% gather(key,value)
SD100WT <- data %>% select(starts_with("SD100WT")) %>% gather(key,value)
SDNPPD <- data %>% select(starts_with("SDNPPD")) %>% gather(key,value)
YPPL <- data %>% select(starts_with("YPPL")) %>% gather(key,value)
CPC <- data %>% select(starts_with("CPC")) %>% gather(key,value)
CSC <- data %>% select(starts_with("CSC")) %>% gather(key,value)

vit <- read.delim("vitexin_raw.txt",header = T,row.names = 1)

# VITEXIN <- data %>% select(starts_with("VITEXIN")) %>% gather(key,value)
# ISOVITEXIN <- data %>% select(starts_with("ISOVITEXIN")) %>% gather(key,value)

BR <- data %>% select(starts_with("BR")) %>% select(-starts_with("BRN")) %>% gather(key,value)
RFW <- data %>% select(starts_with("RFW")) %>% gather(key,value)
BDC <- data %>% select(starts_with("BDC")) %>% gather(key,value)
FLC <- data %>% select(starts_with("FLC")) %>% gather(key,value)
PDC <- data %>% select(starts_with("PDC")) %>% gather(key,value)
PLC <- data %>% select(starts_with("PLC")) %>% gather(key,value)
SDC <- data %>% select(starts_with("SDC")) %>% select(-starts_with("SDCG"))%>% gather(key,value)
TLC <- data %>% select(starts_with("TLC")) %>% gather(key,value)
YSC <- data %>% select(starts_with("YSC")) %>% gather(key,value)
PLH <- data %>% select(starts_with("PLH")) %>% gather(key,value)
GRH <- data %>% select(starts_with("GRH")) %>% gather(key,value)
HECL <- data %>% select(starts_with("HECL")) %>% gather(key,value)
MLA <- data %>% select(starts_with("MLA")) %>% gather(key,value)
MLL <- data %>% select(starts_with("MLL")) %>% gather(key,value)
MLW <- data %>% select(starts_with("MLW")) %>% gather(key,value)
MSD <- data %>% select(starts_with("MSD")) %>% gather(key,value)
MSNN <- data %>% select(starts_with("MSNN")) %>% gather(key,value)
PDS <- data %>% select(starts_with("PDS")) %>% gather(key,value)
TLS <- data %>% select(starts_with("TLS")) %>% gather(key,value)
FLD <- data %>% select(starts_with("FLD")) %>% gather(key,value)
SDCG <- data %>% select(starts_with("SDCG")) %>% gather(key,value)
CHP <- data %>% select(starts_with("CHP")) %>% gather(key,value)


mystats <- function(x,na.omit=T){
  if(na.omit)
    x <- x[!is.na(x)]
  m <- mean(x)
  s <- sd(x)
  mi <- min(x)
  ma <- max(x)
  skew <- skewness(x)
  kurt <- kurtosis(x)
  return(c(mean=m,stdev=s,min=mi,max=ma,skewness=skew,kurtosis=kurt))
}

allt <- data.frame(BRN=mystats(BRN$value),
                   PDL=mystats(PDL$value),
                   PDTN=mystats(PDTN$value),
                   PDW=mystats(PDW$value),
                   SD100WT=mystats(SD100WT$value),
                   SDNPPD=mystats(SDNPPD$value),
                   YPPL=mystats(YPPL$value),
                   CPC=mystats(CPC$value),
                   CSC=mystats(CSC$value),
                   # VITEXIN=mystats(VITEXIN$value),
                   # ISOVITEXIN=mystats(ISOVITEXIN$value),
                   VITEXIN=mystats(vit$VITEXIN),
                   ISOVITEXIN=mystats(vit$ISOVITEXIN),
                   BR=mystats(BR$value),
                   RFW=mystats(RFW$value),
                   BDC=mystats(BDC$value),
                   FLC=mystats(FLC$value),
                   PDC=mystats(PDC$value),
                   PLC=mystats(PLC$value),
                   SDC=mystats(SDC$value),
                   TLC=mystats(TLC$value),
                   YSC=mystats(YSC$value),
                   PLH=mystats(PLH$value),
                   GRH=mystats(GRH$value),
                   HECL=mystats(HECL$value),
                   MLA=mystats(MLA$value),
                   MLL=mystats(MLL$value),
                   MLW=mystats(MLW$value),
                   MSD=mystats(MSD$value),
                   MSNN=mystats(MSNN$value),
                   PDS=mystats(PDS$value),
                   TLS=mystats(TLS$value),
                   FLD=mystats(FLD$value),
                   SDCG=mystats(SDCG$value),
                   CHP=mystats(CHP$value))

alldata <- data.frame(t(allt))
write.csv(alldata,"trait_stat.csv",col.names = NA)



# mean --------------------------------------------------------------------


# dat <- read.delim("all_phenotype.txt",header = T)
dat <- read.delim("allphe_outlier_NA.txt",header = T)
BRN <- dat %>% select(1,starts_with("BRN")) %>% arrange(Sample)
write.table(BRN$Sample,"trait_mean/sample_order.txt",col.names = F,row.names = F,quote = F)
write.table(apply(BRN[-1],1,mean,na.rm=T),"trait_mean/BRN.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("PDL")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/PDL.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("PDTN")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/PDTN.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("PDW"))  %>% select(-PDW_2018ZJK) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/PDW.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("SD100WT")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/SD100WT.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("SDNPPD")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/SDNPPD.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("YPPL")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/YPPL.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("CPC")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/CPC.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("CSC")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/CSC.txt",row.names = F,col.names = F)

# tmp <- dat %>% select(1,starts_with("VITEXIN")) %>% arrange(Sample)
# write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/VITEXIN.txt",row.names = F,col.names = F)

# tmp <- dat %>% select(1,starts_with("ISOVITEXIN")) %>% arrange(Sample)
# write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/ISOVITEXIN.txt",row.names = F,col.names = F)
vite <- read.delim("vitexin_raw.txt",header = T)
vit2 <- left_join(BRN[1],vite,by="Sample")
write.table(vit2$VITEXIN,"trait_mean/VITEXIN.txt",row.names = F,col.names = F)
write.table(vit2$ISOVITEXIN,"trait_mean/ISOVITEXIN.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("BR"))  %>% select(-starts_with("BRN")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/BR.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("RFW")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/RFW.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("BDC")) %>% select(-starts_with("SDCG")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/BDC.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("FLC")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/FLC.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("PDC")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/PDC.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("PLC")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/PLC.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("SDC")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/SDC.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("TLC")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/TLC.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("YSC")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/YSC.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("PLH")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/PLH.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("GRH")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/GRH.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("HECL")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/HECL.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("MLA")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/MLA.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("MLL")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/MLL.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("MLW")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/MLW.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("MSD")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/MSD.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("MSNN")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/MSNN.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("PDS")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/PDS.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("TLS")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/TLS.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("FLD")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/FLD.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("SDCG")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/SDCG.txt",row.names = F,col.names = F)

tmp <- dat %>% select(1,starts_with("CHP")) %>% arrange(Sample)
write.table(apply(tmp[-1],1,mean,na.rm=T),"trait_mean/CHP.txt",row.names = F,col.names = F)


# 根据性状均值求表型相关性 ------------------------------------------------------------

files <- list.files(path = "trait_mean",pattern = ".txt")
ad <- NULL
for(i in 1:length(files)){
  ad[[i]] <- read.table(paste0("trait_mean/",files[i]),header = F)
}
alld <- do.call(cbind,ad)
f_name <- gsub(".txt","",files)
f_name
colnames(alld) <- f_name
alld2 <- cbind(BRN[1],alld)
# write.csv(alld2,"alltrait_mean.csv",row.names = F,quote = F)
write.csv(alld2,"alltrait_outlier_mean.csv",row.names = F,quote = F)

library(pheatmap)
test <- na.omit(alld)
str(test)
pheatmap(cor(test))

anno <- read.delim("anno.txt",header = F,row.names = 1)
colnames(anno) <- "Trait related"
pheatmap(cor(test),annotation_row = anno,
         annotation_col = anno,
         display_numbers = T,
         colorRampPalette (c("blue","white","red")) (100))
#wid 1000 height 800
write.csv(cor(test),"pheno_mean_cor.csv")


# 全部表型相关性 -----------------------------------------------------------------

ald <- read.delim("all_phenotype.txt",header = T,row.names = 1)
ald <- na.omit(ald)
pheatmap(cor(ald),
         colorRampPalette (c("blue","white","red")) (100))
#18 16
