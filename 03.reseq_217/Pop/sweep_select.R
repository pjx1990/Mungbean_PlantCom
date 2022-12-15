###########################
### ROD
# 所有Wild归为landrace中，改为Germplasm，Cultivar改为释放品种releasing variety

###########################
rm(list = ls())


# ROD ---------------------------------------------------------------------


# pi <- read.delim("10kb_Pi_landrace-cultivar_out.txt",sep = "\t",header = T)
# head(pi)

cul <- read.delim("cultivar.windowed.pi",header = T,sep = "\t")
head(cul)
land <- read.delim("landrace.windowed.pi",header = T,sep = "\t")
head(land)

tail(cul)
tail(land)

identical(cul[-4],land[-4])

library(tidyverse)
data=inner_join(cul,land,by=c("CHROM","BIN_START","BIN_END"))
head(data)

data2 <- data %>% mutate(ROD=1-PI.x/PI.y) %>% arrange(-ROD)
n=ceiling(nrow(data2)*0.05)
select_ROD <- head(data2,n)

colnames(select_ROD)[c(5,7)] <- c("Breeding lines(pi)","Germplasm(pi)")
write.csv(select_ROD,"top5%_ROD.csv",row.names = F,quote = F)

# Fst ---------------------------------------------------------------------

fst <- read.delim("landrace-cultivar.windowed.weir.fst",header = T,sep = "\t")
head(fst)

top_fst <- fst %>% arrange(-MEAN_FST) %>% head(ceiling(nrow(fst)*0.05))
head(top_fst)



# intersect ---------------------------------------------------------------

overlap <- inner_join(select_ROD,top_fst,by=c("CHROM","BIN_START","BIN_END"))

table(overlap$CHROM)
overlap$CHROM <- as.numeric(overlap$CHROM)
overlap <- overlap %>% arrange(CHROM)
colnames(overlap)

select_region <- overlap %>% select(-contains("N_VARIANTS"),-WEIGHTED_FST)
write.table(select_region,"sweep_region.txt",col.names = T,row.names = F,sep = "\t",quote = F)


# interct gene ------------------------------------------------------------

gene <- read.table("allgene.txt",header = F)
gene$V1 <- as.numeric(gene$V1)
gene <- na.omit(gene)
head(gene)
head(select_region)
table(select_region$CHROM)

str(gene)
str(select_region)

tmp <- NULL
for(i in 1:nrow(select_region)){
  # i=150  #190
  x=select_region[i,];x
  res <- NULL
  for(j in 1:nrow(gene)){
    # j=3455
    if(x[1]==gene[j,1] & 
       ((gene[j,2]<=x[3] & gene[j,2]>=x[2]) |
        (gene[j,3]<=x[3] & gene[j,3]>=x[2]) |
        (gene[j,2]<=x[2] & gene[j,3]>=x[3]) )){
      
      res[[j]] <- cbind(x,gene[j,])
    }
  }
  
  if(!is.null(res)){
    tmp[[i]] <- data.frame(do.call(rbind,res))
  }
  
}

final_data <- data.frame(do.call(rbind,tmp)) %>% select(-V1)

colnames(final_data)[8:11] <- c("Start","End","Coding direction","Gene")
write.table(final_data,"Sweep_gene.txt",col.names = T,row.names = F,sep = "\t",quote = F)  
