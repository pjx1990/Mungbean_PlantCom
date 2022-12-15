#####################
## θπ Pi
###################
rm(list = ls())
#setwd("F:/河北农科院绿豆基因组项目/项目分析/选择清除/Pi")
library(tidyverse)


## all sample ---------------------------------------------------------------------
#
#mydata<-read.table("all.Tajima.D",header = T)
#mydata1<-na.omit(mydata)
#mydata2 <- mydata1 %>% filter(!str_detect(CHROM,"scaffold"))
#mydata2$CHROM <- as.numeric(mydata2$CHROM)
#mydata2 <- mydata2 %>% arrange(CHROM)
#unique(mydata2$CHROM)
#mydata2$CHROM <- paste0("Chr",mydata2$CHROM)
#unique(mydata2$CHROM)
#mydata2$CHROM <- factor(mydata2$CHROM,levels = unique(mydata2$CHROM))
#head(mydata2)
#p=ggplot(mydata2, aes(x=BIN_START/1000000,
#                      y=PI,
#                      group=factor(CHROM),
#                      colour=CHROM))+
#  geom_line()+
#  facet_wrap(~CHROM)+
#  xlab("Physical distance(Mb)")+
#  ylab("θπ")+
#  theme(legend.position = "none");p
#ggsave(p,filename = "all_θπ.png",width = 12,height = 8,dpi = 300)
#

# type3:wild-cultivar-landrace --------------------------------------------

tidy_data <- function(pi,type){
  mydata<-read.table(pi,header = T) 
  mydata1<-na.omit(mydata)
  mydata2 <- mydata1 %>% filter(!str_detect(CHROM,"scaffold"))
  mydata2$CHROM <- as.numeric(mydata2$CHROM)
  mydata2 <- mydata2 %>% arrange(CHROM)
  unique(mydata2$CHROM)
  mydata2$CHROM <- paste0("Chr",mydata2$CHROM)
  unique(mydata2$CHROM)
  mydata2$CHROM <- factor(mydata2$CHROM,levels = unique(mydata2$CHROM))
  mydata2$Type <- type
  return(mydata2)
}
a=tidy_data(pi = "East_Asia.Tajima.D",type = "East_Asia")
b=tidy_data(pi = "South_Asia.Tajima.D",type = "South_Asia")
c=tidy_data(pi = "West_Asia.Tajima.D",type = "West_Asia")
d=tidy_data(pi = "Southeast_Asia.Tajima.D",type = "Southeast_Asia")
e=tidy_data(pi = "Other.Tajima.D",type = "Other")

out=data.frame(Type=c("East_Asia","South_Asia","West_Asia","Southeast_Asia","Other"),
               Pi=c(mean(a$TajimaD,na.rm=T),mean(b$TajimaD,na.rm=T),mean(c$TajimaD,na.rm=T),mean(d$TajimaD,na.rm=T),mean(e$TajimaD,na.rm=T)))
write.table(out,"Tajima_asia_out.txt",sep = "\t",quote = F,row.names = F,col.names = T)

data=rbind(a,b,c,d)
p=ggplot(data, aes(x=BIN_START/1000000,
                   y=TajimaD,
                   group=factor(CHROM),
                   colour=Type))+
  geom_line()+
  geom_hline(aes(yintercept=0), colour="red", linetype="dashed")+
  facet_wrap(~CHROM,nrow=1,scales = "free_x")+
  xlab("Physical distance(Mb)")+
  ylab("Tajima's D")
#  theme(legend.position = c(1,0),legend.justification = c(1,0));p
ggsave(p,filename = "asia_Tajima.png",width = 15,height = 3.5,dpi = 300)

