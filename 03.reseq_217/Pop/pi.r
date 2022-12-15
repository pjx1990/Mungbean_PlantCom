#####################
## θπ Pi
###################
rm(list = ls())
library(tidyverse)


# all sample ---------------------------------------------------------------------

mydata<-read.table("all.windowed.pi",header = T)
mydata1<-na.omit(mydata)
mydata2 <- mydata1 %>% filter(!str_detect(CHROM,"scaffold"))
mydata2$CHROM <- as.numeric(mydata2$CHROM)
mydata2 <- mydata2 %>% arrange(CHROM)
unique(mydata2$CHROM)
mydata2$CHROM <- paste0("Chr",mydata2$CHROM)
unique(mydata2$CHROM)
mydata2$CHROM <- factor(mydata2$CHROM,levels = unique(mydata2$CHROM))
head(mydata2)
p=ggplot(mydata2, aes(x=BIN_START/1000000,
                      y=PI,
                      group=factor(CHROM),
                      colour=CHROM))+
  geom_line()+
  facet_wrap(~CHROM)+
  xlab("Physical distance(Mb)")+
  ylab("θπ")+
  theme(legend.position = "none");p
ggsave(p,filename = "all_θπ.png",width = 12,height = 8,dpi = 300)


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
wild=tidy_data(pi = "wild.windowed.pi",type = "Wild")
head(wild)
landrace=tidy_data(pi = "landrace.windowed.pi",type = "Landrace")
cultivar=tidy_data(pi = "cultivar.windowed.pi",type = "Cultivar")

data=rbind(wild,landrace,cultivar)
head(data)
p=ggplot(data, aes(x=BIN_START/1000000,
                   y=PI,
                   group=factor(CHROM),
                   colour=Type))+
  geom_line()+
  facet_wrap(~CHROM)+
  xlab("Physical distance(Mb)")+
  ylab("θπ")+
  theme(legend.position = c(1,0),legend.justification = c(1,0));p
ggsave(p,filename = "type3_θπ.png",width = 12,height = 8,dpi = 300)
