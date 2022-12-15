###########################
### GWAS MTAs 全局概览图（全部性状整合）
###########################
rm(list = ls())
library(tidyverse)
library(scales)

bin <- read.delim("20210826MTA/allMTAs_anno_gene_fun.txt",header = T)
head(bin)

mydata <- read.delim("mungbean_chr2.txt",header = T)
mydata <- mydata %>% mutate(chr_label_pos=xmin+(len/2))
mydata



# 设置范围 --------------------------------------------------------------------


bin_test <- bin %>% select(1:7) %>% 
  mutate(bin_start=Pos/1000000) %>% 
  mutate(bin_end=(bin_start+0.1)) %>%   #0.01
  unite("Type",c("Loc","Year","Season"))

head(bin_test)
str(bin_test)
colnames(bin_test)

Xmin <- NULL
Xmax <- NULL
for(i in 1:nrow(bin_test)){
  # i=1
  if(bin_test[i,3]==1){
    Xmin=c(Xmin,bin_test[i,6])
    Xmax=c(Xmax,bin_test[i,7])
  }else if(bin_test[i,3]==2){
    Xmin=c(Xmin,bin_test[i,6]+mydata[1,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[1,4])
  }else if(bin_test[i,3]==3){
    Xmin=c(Xmin,bin_test[i,6]+mydata[2,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[2,4])
  }else if(bin_test[i,3]==4){
    Xmin=c(Xmin,bin_test[i,6]+mydata[3,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[3,4])
  }else if(bin_test[i,3]==5){
    Xmin=c(Xmin,bin_test[i,6]+mydata[4,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[4,4])
  }else if(bin_test[i,3]==6){
    Xmin=c(Xmin,bin_test[i,6]+mydata[5,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[5,4])
  }else if(bin_test[i,3]==7){
    Xmin=c(Xmin,bin_test[i,6]+mydata[6,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[6,4])
  }else if(bin_test[i,3]==8){
    Xmin=c(Xmin,bin_test[i,6]+mydata[7,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[7,4])
  }else if(bin_test[i,3]==9){
    Xmin=c(Xmin,bin_test[i,6]+mydata[8,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[8,4])
  }else if(bin_test[i,3]==10){
    Xmin=c(Xmin,bin_test[i,6]+mydata[9,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[9,4])
  }else if(bin_test[i,3]==11){
    Xmin=c(Xmin,bin_test[i,6]+mydata[10,4])
    Xmax=c(Xmax,bin_test[i,7]+mydata[10,4])
  }
}
Xmin
Xmax

bin_test$xmin <- Xmin
bin_test$xmax <- Xmax


# 整合性状 --------------------------------------------------------------------

RColorBrewer::display.brewer.all()
set1 <- RColorBrewer::brewer.pal(9,"Set1")
col <- set1[c(1:5,8)]
col

###===================产量相关
yield_traits <- c("BRN","PDL","PDTN","PDW","SD100WT","SDNPPD","YPPL")
BRN <- bin_test %>% filter(Traits=="BRN")
PDL <- bin_test %>% filter(Traits=="PDL")
PDTN <- bin_test %>% filter(Traits=="PDTN")
PDW <- bin_test %>% filter(Traits=="PDW")
SD100WT <- bin_test %>% filter(Traits=="SD100WT")
SDNPPD <- bin_test %>% filter(Traits=="SDNPPD")
YPPL <- bin_test %>% filter(Traits=="YPPL")
###==================品质相关性状
quality_traits <- c("CPC","CSC","VITEXIN","ISOVITEXIN")
CPC <- bin_test %>% filter(Traits=="CPC")
CSC <- bin_test %>% filter(Traits=="CSC")
VITEXIN <- bin_test %>% filter(Traits=="VITEXIN")
ISOVITEXIN <- bin_test %>% filter(Traits=="ISOVITEXIN")
###==================抗性相关性状
resistance_traits <- c("BR","RFW")
BR <- bin_test %>% filter(Traits=="BR")
RFW <- bin_test %>% filter(Traits=="RFW")
###=================颜色相关
color_traits <- c("BDC","FLC","PDC","PLC","SDC","TLC","YSC")
BDC <- bin_test %>% filter(Traits=="BDC")
FLC <- bin_test %>% filter(Traits=="FLC")
PDC <- bin_test %>% filter(Traits=="PDC")
PLC <- bin_test %>% filter(Traits=="PLC")
SDC <- bin_test %>% filter(Traits=="SDC")
TLC <- bin_test %>% filter(Traits=="TLC")
YSC <- bin_test %>% filter(Traits=="YSC")
###=================株型相关
plant_architecture_traits <- c("PLH","GRH","HECL","MLA","MLL","MLW","MSD","MSNN","PDS")
PLH <- bin_test %>% filter(Traits=="PLH")
GRH <- bin_test %>% filter(Traits=="GRH")
HECL <- bin_test %>% filter(Traits=="HECL")
MLA <- bin_test %>% filter(Traits=="MLA")
MLL <- bin_test %>% filter(Traits=="MLL")
MLW <- bin_test %>% filter(Traits=="MLW")
MSD <- bin_test %>% filter(Traits=="MSD")
MSNN <- bin_test %>% filter(Traits=="MSNN")
PDS <- bin_test %>% filter(Traits=="PDS")
###==================其他
other_traits <- c("FLD","SDCG","CHP")
FLD <- bin_test %>% filter(Traits=="FLD")
SDCG <- bin_test %>% filter(Traits=="SDCG")
CHP <- bin_test %>% filter(Traits=="CHP")

all_traits <- c(yield_traits,quality_traits,resistance_traits,color_traits,plant_architecture_traits,other_traits)
all_traits


# plot --------------------------------------------------------------------


ggplot(mydata)+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=0,ymax=2),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-2.1,ymax=-0.1),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-4.2,ymax=-2.2),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-6.3,ymax=-4.3),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-8.4,ymax=-6.4),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-10.5,ymax=-8.5),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-12.6,ymax=-10.6),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-14.7,ymax=-12.7),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-16.8,ymax=-14.8),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-18.9,ymax=-16.9),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-21,ymax=-19),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-23.1,ymax=-21.1),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-25.2,ymax=-23.2),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-27.3,ymax=-25.3),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-29.4,ymax=-27.4),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-31.5,ymax=-29.5),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-33.6,ymax=-31.6),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-35.7,ymax=-33.7),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-37.8,ymax=-35.8),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-39.9,ymax=-37.9),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-42,ymax=-40),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-44.1,ymax=-42.1),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-46.2,ymax=-44.2),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-48.3,ymax=-46.3),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-50.4,ymax=-48.4),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-52.5,ymax=-50.5),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-54.6,ymax=-52.6),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-56.7,ymax=-54.7),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-58.8,ymax=-56.8),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-60.9,ymax=-58.9),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-63,ymax=-61),
            colour="black", fill = "white")+
  geom_rect(aes(xmin=xmin,xmax=xmax,
                ymin=-65.1,ymax=-63.1),
            colour="black", fill = "white") +
  
  geom_rect(data=BRN,aes(xmin=xmin,xmax=xmax,
                    ymin=0,ymax=2,
                    fill = Type)) +
  geom_rect(data=PDL,aes(xmin=xmin,xmax=xmax,
                    ymin=-2.1,ymax=-0.1,
                    fill = Type))+
  geom_rect(data=PDTN,aes(xmin=xmin,xmax=xmax,
                     ymin=-4.2,ymax=-2.2,
                     fill = Type))+
  geom_rect(data=PDW,aes(xmin=xmin,xmax=xmax,
                    ymin=-6.3,ymax=-4.3,
                    fill = Type))+
  geom_rect(data=SD100WT,aes(xmin=xmin,xmax=xmax,
                        ymin=-8.4,ymax=-6.4,
                        fill = Type))+
  geom_rect(data=SDNPPD,aes(xmin=xmin,xmax=xmax,
                       ymin=-10.5,ymax=-8.5,
                       fill = Type))+
  geom_rect(data=YPPL,aes(xmin=xmin,xmax=xmax,
                     ymin=-12.6,ymax=-10.6,
                     fill = Type))+
  geom_rect(data=CPC,aes(xmin=xmin,xmax=xmax,
                    ymin=-14.7,ymax=-12.7,
                    fill = Type))+
  geom_rect(data=CSC,aes(xmin=xmin,xmax=xmax,
                    ymin=-16.8,ymax=-14.8,
                    fill = Type))+
  geom_rect(data=VITEXIN,aes(xmin=xmin,xmax=xmax,
                        ymin=-18.9,ymax=-16.9,
                        fill = Type))+
  geom_rect(data=ISOVITEXIN,aes(xmin=xmin,xmax=xmax,
                           ymin=-21,ymax=-19,
                           fill = Type))+
  geom_rect(data=BR,aes(xmin=xmin,xmax=xmax,
                   ymin=-23.1,ymax=-21.1,
                   fill = Type))+
  geom_rect(data=RFW,aes(xmin=xmin,xmax=xmax,
                    ymin=-25.2,ymax=-23.2,
                    fill = Type))+
  geom_rect(data=BDC,aes(xmin=xmin,xmax=xmax,
                    ymin=-27.3,ymax=-25.3,
                    fill = Type))+
  geom_rect(data=FLC,aes(xmin=xmin,xmax=xmax,
                    ymin=-29.4,ymax=-27.4,
                    fill = Type))+
  geom_rect(data=PDC,aes(xmin=xmin,xmax=xmax,
                    ymin=-31.5,ymax=-29.5,
                    fill = Type))+
  geom_rect(data=PLC,aes(xmin=xmin,xmax=xmax,
                    ymin=-33.6,ymax=-31.6,
                    fill = Type))+
  geom_rect(data=SDC,aes(xmin=xmin,xmax=xmax,
                    ymin=-35.7,ymax=-33.7,
                    fill = Type))+
  geom_rect(data=TLC,aes(xmin=xmin,xmax=xmax,
                    ymin=-37.8,ymax=-35.8,
                    fill = Type))+
  geom_rect(data=YSC,aes(xmin=xmin,xmax=xmax,
                    ymin=-39.9,ymax=-37.9,
                    fill = Type))+
  geom_rect(data=PLH,aes(xmin=xmin,xmax=xmax,
                    ymin=-42,ymax=-40,
                    fill = Type))+
  geom_rect(data=GRH,aes(xmin=xmin,xmax=xmax,
                    ymin=-44.1,ymax=-42.1,
                    fill = Type))+
  geom_rect(data=HECL,aes(xmin=xmin,xmax=xmax,
                     ymin=-46.2,ymax=-44.2,
                     fill = Type))+
  geom_rect(data=MLA,aes(xmin=xmin,xmax=xmax,
                    ymin=-48.3,ymax=-46.3,
                    fill = Type))+
  geom_rect(data=MLL,aes(xmin=xmin,xmax=xmax,
                    ymin=-50.4,ymax=-48.4,
                    fill = Type))+
  geom_rect(data=MLW,aes(xmin=xmin,xmax=xmax,
                    ymin=-52.5,ymax=-50.5,
                    fill = Type))+
  geom_rect(data=MSD,aes(xmin=xmin,xmax=xmax,
                    ymin=-54.6,ymax=-52.6,
                    fill = Type))+
  geom_rect(data=MSNN,aes(xmin=xmin,xmax=xmax,
                     ymin=-56.7,ymax=-54.7,
                     fill = Type))+
  geom_rect(data=PDS,aes(xmin=xmin,xmax=xmax,
                    ymin=-58.8,ymax=-56.8,
                    fill = Type))+
  geom_rect(data=FLD,aes(xmin=xmin,xmax=xmax,
                    ymin=-60.9,ymax=-58.9,
                    fill = Type))+
  geom_rect(data=SDCG,aes(xmin=xmin,xmax=xmax,
                     ymin=-63,ymax=-61,
                     fill = Type))+
  geom_rect(data=CHP,aes(xmin=xmin,xmax=xmax,
                    ymin=-65.1,ymax=-63.1,
                    fill = Type)) +
  
  theme(panel.grid.major = element_blank(), 
        panel.grid.minor = element_blank(), 
        panel.background = element_blank(),
        legend.position = "top", #yes:18/20;no:15/25
        legend.title = element_blank(),
        legend.text = element_text(size = 15),
        # axis.text.x = element_text(colour = "black"),#size = 10,
        # axis.text.y = element_text(hjust = 0.5, vjust=1, margin=margin(0,-50,0,0)), #margin上右下左 
        axis.text.x = element_text(vjust=-1,size=15,margin=margin(-25,0,0,0),color = "black"), #,face = "bold"
        axis.text.y = element_text(hjust=0.5, margin=margin(0,-50,0,0),size=12,color = "black"), #margin上右下左 #hjust = 0.5, vjust=1,
        # plot.margin = margin(0,0,0,0),
        axis.ticks = element_blank()) + 
  scale_x_continuous(name = "", breaks=c(mydata$chr_label_pos),labels=c(mydata$chr))+
  # scale_x_continuous(position = "top", name = "", breaks=c(mydata$chr_label_pos),labels=c(mydata$chr))+
  scale_fill_manual(values = col)+
  scale_y_continuous(breaks=seq(from=1,by=-2.1,length=32),labels = all_traits)

#width=20,height=15



# 对照生成的图片验证下结果 ------------------------------------------------------------

##yield
unique(BRN$Chr)
unique(PDL$Chr)
unique(PDTN$Chr)
unique(PDW$Chr)
unique(SD100WT$Chr)
unique(SDNPPD$Chr)
unique(YPPL$Chr)
##quality
unique(CPC$Chr)
unique(CSC$Chr)
unique(VITEXIN$Chr)
unique(ISOVITEXIN$Chr)
##resistance
unique(BR$Chr)
unique(RFW$Chr)
##color
unique(BDC$Chr)
unique(FLC$Chr)
unique(PDC$Chr)
unique(PLC$Chr)
unique(SDC$Chr)
unique(TLC$Chr)
unique(YSC$Chr)
##plant arch
unique(PLH$Chr)
unique(GRH$Chr)
unique(HECL$Chr)
unique(MLA$Chr)
unique(MLL$Chr)
unique(MLW$Chr)
unique(MSD$Chr)
unique(MSNN$Chr)
unique(PDS$Chr)
##other
unique(FLD$Chr)
unique(SDCG$Chr)
unique(CHP$Chr)
