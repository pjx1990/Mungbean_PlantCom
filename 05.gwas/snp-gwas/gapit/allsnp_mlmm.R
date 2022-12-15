rm(list = ls())
args=commandArgs(T)

t1=proc.time()
#Step 0: Import library and GAPIT functions run this section each time to start R)
#######################################################################################
library('MASS') # required for ginv
library(multtest)
library(gplots)
library(compiler) #required for cmpfun
library("scatterplot3d")

# source("http://www.zzlab.net/GAPIT/emma.txt")
# source("http://www.zzlab.net/GAPIT/gapit_functions.txt")
source("/project/pengjx/scripts/gwas/emma.txt")
source("/project/pengjx/scripts/gwas/gapit_functions.txt")


#Step 1: Set data directory and import files
#myY  <- read.table("2017spring_test.txt", head = TRUE,fill = T)
myY  <- read.table(args[1], head = TRUE,fill = T)
colnames(myY)[1] <- "Taxa"

myG <- read.delim(args[2], head = FALSE,sep = "\t")
#myG <- read.delim("../200_phe.hmp.txt", head = FALSE,sep = "\t")
myG[1:10,1:10]
myG[1,1:11] <- c("rs", "alleles", "chrom","pos", "strand", "assembly", "center", "protLSID", "assayLSID", "panel", "QCcode")


if(!exists("allsnp_MLM-MLMM"))dir.create("allsnp_MLM-MLMM")
setwd("./allsnp_MLM-MLMM")
#Step 2: Run GAPIT
myGAPIT <- GAPIT(
  Y=myY,
  G=myG,
  PCA.total=3,
  # model=c("FarmCPU"),
  #model=c("GLM","MLM","SUPER","MLMM","FarmCPU","Blink"),
  model=c("MLMM"),
  file.output=T
)


t2=proc.time()
t=t2-t1
write.table(paste0('执行时间：',t[3][[1]],'秒'),"MLMM.time.txt",row.names=F,col.names=F)
