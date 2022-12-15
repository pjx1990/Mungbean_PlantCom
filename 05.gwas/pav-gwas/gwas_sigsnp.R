rm(list = ls())
library(tidyverse)
library(qqman) # 载入包
library(customLayout)


# Gemma LMM model ---------------------------------------------------------------

files <- list.files(path = "../output/",pattern="\\w+.assoc.txt")
#files

traits_name <- gsub("(\\w+)[.]assoc[.]txt","\\1",files)
#traits_name

#for(i in 1:5){
for(i in 1:length(traits_name)){
#        i=1
       print(paste0("===========processing ",files[i]))
	data <- read.table(paste0("../output/",files[i]),header = TRUE) #读取数据
	data1 <- data[,c(1,2,3,12)] #按照规则截取列
	line=0.05/nrow(data1)
	# colnames(dat)[1:4] = c('SNP','CHR','BP','P')
	# remove scaffold
	#data1 <- filter(data1,!str_detect(chr,"SCAFFOLD_"))
	#data1 <- filter(data1,str_detect(chr,"HIC_ASM_"))
	data1$chr <- gsub("scaffold_","",data1$chr)
	data1$chr <- gsub("contig","",data1$chr)
	data1$chr <- as.numeric(data1$chr)
	data1$p_wald <- as.numeric(data1$p_wald)
	data2 <- na.omit(data1) # 删除含有NA的整行
       data3=data %>% filter(p_wald<line) %>% arrange(p_wald)
     if(nrow(data3)>0){
       get_pve <- function(af,beta,se,N=217){
         MAF=af
         # MAF=1-af
         PVE = (2*(beta^2)*MAF*(1-MAF))/(2*(beta^2)*MAF*(1-MAF)+((se^2)*2*N*MAF*(1-MAF)))
         return(PVE)
       }
       pve <- NULL
       for(j in 1:nrow(data3)){
         # j=1
         tmp <- get_pve(af=data3[j,7],beta=data3[j,8],se=data3[j,9])
         pve <- c(pve,tmp)
       }
       data3$PVE <- pve
       write.table(data3,paste0(traits_name[i],"_sig.txt"),sep='\t',quote=F,col.names=T,row.names=F)
}
	par(cex=0.8) #设置点的大小
	png(file=paste0(traits_name[i],".png"),width=1200, height=400)
	#lay <-lay_new(mat =matrix(1:2, ncol =2),widths = c(1.8,0.8))
	lay <-lay_new(mat =matrix(1:2, ncol =2),widths = c(2,1))
	lay_set(lay)
	manhattan(data2,chr="chr",snp="rs",bp="ps",p="p_wald",
		  main=paste0(traits_name[i]),
#		  cex=1.5,cex.axis=1.2,cex.lab=1.2,cex.main=2,
#		  col = c("#8DA0CB","#E78AC3","#A6D854","#FFD92F","#E5C494","#66C2A5","#FC8D62"),
		  suggestiveline = 0,genomewideline = -log10(line))
#	qq(data2$p_wald, main="", cex=1.5,cex.axis=1.2, cex.lab=1.2,cex.main=2) #,col = "blue")
	qq(data2$p_wald, main="")
	dev.off()

}
