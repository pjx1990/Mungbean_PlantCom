#####################
## Fst
###################
rm(list = ls())

library(tidyverse)

tidy_data <- function(fst,type){
        mydata<-read.table(fst,header = T) 
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
wc=tidy_data(fst = "wild-cultivar.windowed.weir.fst",type = "Wild-Cultivar")
head(wc)
lc=tidy_data(fst = "landrace-cultivar.windowed.weir.fst",type = "Landrace-Cultivar")
wl=tidy_data(fst = "wild-landrace.windowed.weir.fst",type = "Wild-Landrace")

data=rbind(wc,lc,wl)
head(data)
p=ggplot(data, aes(x=BIN_START/1000000,
                    y=MEAN_FST,
                    group=factor(CHROM),
                    colour=Type))+
        geom_line()+
        facet_wrap(~CHROM)+
        xlab("Physical distance(Mb)")+
        ylab("Fst")+
        theme(legend.position = c(1,0),legend.justification = c(1,0));p
ggsave(p,filename = "Fst.png",width = 12,height = 8,dpi = 300)

