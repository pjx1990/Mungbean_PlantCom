########################
# GAPIT GWAS重绘
########################

rm(list = ls())
library(tidyverse)
library(qqman)
library(customLayout)

#files <- list.files(path = "../Allmodel_200/",pattern = "GAPIT.Blink.\\w+.GWAS.Results.csv")
files <- list.files(path = "../Allmodel_200/",pattern = "GAPIT.\\w+.\\w+.GWAS.Results.csv")
files

# 性状名称顺序保持一致
#traits_name <- sapply(files,function(x)unlist(strsplit(x,"[.]"))[3])
traits_name <- gsub("GAPIT[.](\\w+[.]\\w+)[.]GWAS[.]Results[.]csv","\\1",files)
traits_name
#model <- sapply(files,function(x)unlist(strsplit(x,"[.]"))[2])
#model[1]

for(i in 1:length(traits_name)){
  # i=2
  res = read.csv(paste0("../Allmodel_200/",files[i]), header = T)
  
  ## beferroni adjust
  line=0.01/nrow(res)
  dat = res[c(1:4)]
  colnames(dat)[1:4] = c('SNP','CHR','BP','P')
  # remove scaffold
  dat <- filter(dat,!str_detect(CHR,"SCAFFOLD_"))
  dat$CHR <- as.numeric(dat$CHR)
  dat$P <- as.numeric(dat$P)
  # when pvalue is 0
  dat$P[dat$P==0] <- NA
  dat=na.omit(dat)
#  dat[is.na(dat)]=min(dat$P,na.rm = T)*0.01
  #png(paste0(model[1],"_",traits_name[i],".png"),width = 1200,height = 550)
  png(paste0(traits_name[i],".png"),width = 1200,height = 600)
  ## 按2:1分布
  #lay <-lay_new(mat =matrix(1:2, ncol =2),widths = c(2,1))
  lay <-lay_new(mat =matrix(1:2, ncol =2),widths = c(1.8,0.8))
  # lay_show(lay)
  lay_set(lay)
  # source("my_manhattan.r")
  manhattan(dat,
             col = c("blue","orange"), 
            #col = c("#4197d8", "#f8c120", "#413496", "#495226","#d60b6f", "#e66519","#d581b7", "#83d3ad", "#7c162c", "#26755d"),
            # main=paste0(traits_name[i],"_2017_Spring"),
            main=paste0(traits_name[i]),
            suggestiveline = 0,
	    cex=1.5,cex.axis=1.2,cex.lab=1.2,cex.main=2,
            genomewideline = -log10(line)
  )
  qq(dat$P, main="", cex=1.5,cex.axis=1.2, cex.lab=1.2,cex.main=2,col = "blue")
  # qq(dat$P, main="Q-Q plot of GWAS p-value", col = "blue4")
  dev.off()
}

