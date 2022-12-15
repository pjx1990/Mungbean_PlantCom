#####################
## TajimaD
###################
rm(list = ls())

library(tidyverse)

# all sample --------------------------------------------------------------


mydata<-read.table("all.Tajima.D",header = T) 
mydata1<-na.omit(mydata)
mydata2 <- mydata1 %>% filter(!str_detect(CHROM,"scaffold"))
mydata2$CHROM <- as.numeric(mydata2$CHROM)
mydata2 <- mydata2 %>% arrange(CHROM)
unique(mydata2$CHROM)
mydata2$CHROM <- paste0("Chr",mydata2$CHROM)
unique(mydata2$CHROM)
mydata2$CHROM <- factor(mydata2$CHROM,levels = unique(mydata2$CHROM))
p=ggplot(mydata2, aes(x=BIN_START/1000000,
                    y=TajimaD,
                    group=factor(CHROM),
                    colour=CHROM))+
  geom_line()+
  facet_wrap(~CHROM)+
  xlab("Physical distance(Mb)")+
  ylab("Tajima's D")+
  theme(legend.position = "none");p
ggsave(p,filename = "Tajima_all.png",width = 12,height = 8,dpi = 300)


# type3:wild-landrace-cultivar --------------------------------------------

tidy_data <- function(tajima,type){
  mydata<-read.table(tajima,header = T) 
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
wild=tidy_data(tajima = "wild.Tajima.D",type = "Wild")
head(wild)
landrace=tidy_data(tajima = "landrace.Tajima.D",type = "Landrace")
cultivar=tidy_data(tajima = "cultivar.Tajima.D",type = "Cultivar")

data=rbind(wild,landrace,cultivar)
head(data)
p=ggplot(data, aes(x=BIN_START/1000000,
                   y=TajimaD,
                   group=factor(CHROM),
                   colour=Type))+
  geom_line()+
  facet_wrap(~CHROM)+
  xlab("Physical distance(Mb)")+
  ylab("Tajima's D")+
  theme(legend.position = c(1,0),legend.justification = c(1,0));p
ggsave(p,filename = "Tajima_type3.png",width = 12,height = 8,dpi = 300)
