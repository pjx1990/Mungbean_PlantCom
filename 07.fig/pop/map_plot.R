###################
## 材料世界地图绘制
###################

library(tidyverse)
library(scatterpie)
library(ggsci)

# our data ----------------------------------------------------------------

alldata <- read.delim("allsample2.txt",header = T,row.names = 1)
head(alldata)

#世界范围的中国统一为北京经纬度
data <- alldata
idx <- which(data$Country=="China")
data[idx,]$Latitude <- "39.92"
data[idx,]$Longitude <- "116.46"

w_data <- data %>% count(Country,Biological.status) %>% 
  spread(Biological.status,n,fill = 0)
head(w_data)


w_data2 <- left_join(w_data,data[,c(3,5,6)],by="Country")
w_data2 <- w_data2[!duplicated(w_data2),]
head(w_data2)
w_data3 <- w_data2[w_data2$Country!="Unknown",]
w_data3$Country <- as.factor(w_data3$Country)
w_data3$Latitude <- as.numeric(w_data3$Latitude)
w_data3$Longitude <- as.numeric(w_data3$Longitude)
head(w_data3)

world <- map_data('world')
head(world)

## plot1
plot_wd <- w_data3 %>% mutate(radius=log(`Breeding line`+`Pre-breeding line`)+1)
head(plot_wd)
p=ggplot(world, aes(long, lat)) +
  geom_map(map=world, aes(map_id=region), fill=NA, color="black") +
  coord_quickmap() +
  geom_scatterpie(aes(x=Longitude, y=Latitude, group=Country, r=radius),
                  data=plot_wd, 
                  cols=c("Breeding line","Pre-breeding line"), 
                  color=NA, 
                  alpha=.8) +
  # scale_fill_jco(name="Type") +
  geom_scatterpie_legend(plot_wd$radius, x=-140, y=-60)+
  theme(legend.position="none")+labs(x="",y="");p


### plot2

plot_wd2 <- plot_wd
colnames(plot_wd2)[2:3] <- c("Breeding Line (BL)","Pre-breeding Line (PBL)")
p=ggplot(world, aes(long, lat)) +
  geom_map(map=world, aes(map_id=region), fill="white", color="black") +
  coord_quickmap() +
  geom_scatterpie(aes(x=Longitude, y=Latitude, group=Country, r=radius),
                  data=plot_wd2, 
                  cols=c("Breeding Line (BL)","Pre-breeding Line (PBL)"), 
                  color=NA, 
                  alpha=.8) +
  # geom_scatterpie_legend(plot_wd$radius, x=-140, y=-60)+
  theme(legend.position=c(0.15,0.2),
        panel.background = element_blank(),
        panel.border = element_blank(),
        legend.title = element_blank(),
        axis.text=element_blank(),
        axis.ticks=element_blank(),
        legend.text = element_text(size=15))+
labs(x="",y="");p

ggsave(p,filename = "worldmap2.png",width = 15,height = 8,dpi = 600)
ggsave(p,filename = "worldmap2.pdf",width = 15,height = 8)
