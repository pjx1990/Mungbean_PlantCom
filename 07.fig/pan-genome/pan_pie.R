################
## 泛基因组双层饼图
###############

## https://www.jianshu.com/p/7410c023df7b
## 基本思路：先做两个柱形图，再旋转坐标轴

rm(list = ls())

library(tidyverse)
library(ggsci) # 配色


# 基本数据 --------------------------------------------------------------------


hard <- read.delim("../HardCore.lst",header = F)
head(hard)
soft <- read.delim("../softCore.lst",header = F)
shell <- read.delim("../shell.lst",header = F)
cloud <- read.delim("../cloud.lst",header = F)

d2 <- data.frame(cat2=c("Hardcore","Softcore","Shell","Cloud"),
                 # value2=1:4,
                 value2=c(nrow(hard),nrow(soft),nrow(shell),nrow(cloud)))
d2
d1 <- data.frame(cat1=c("Core","Core","Variable","Variable"),
                 # value1=1:4,
                 value1=c(nrow(hard)+nrow(soft),nrow(hard)+nrow(soft),
                          nrow(shell)+nrow(cloud),nrow(shell)+nrow(cloud)))
d1

dat <- cbind(d1,d2)
dat


# 整理数据 1 --------------------------------------------------------------------

# 分别求所占百分比
dat1 = aggregate(dat$value1, by = list(dat$cat1), FUN = sum)
dat1$per1 = dat1$x / sum(dat1$x)
dat1$x <- dat1$x/2  ##注意数据对应！！！
dat1

# for循环构建标签的相对位置
for (i in seq(nrow(dat1), 1)) {
  if (i == nrow(dat1)) {
    dat1$per.y1[i] = dat1$per1[i] / 2
  }else{
    dat1$per.y1[i] = sum(dat1$per1[(i + 1):nrow(dat1)]) + dat1$per1[i] / 2
  }
}

# 构建标签后合并数据
dat1$label1 = paste(dat1$Group.1,"\n",dat1$x,'(',round(dat1$per1*100, 2),'%',')', sep = '')
dat1
dat1$d1="a"
p1=ggplot() + 
  geom_bar(data = dat1,aes(d1,per1,fill=Group.1),stat = "identity",position = "stack")+
  geom_text(data = dat1,aes(1.25, as.numeric(per.y1),label = label1),size = 2.5, color = 'black');p1


# 整理数据2 -------------------------------------------------------------------

# 重复操作
dat2 = aggregate(dat$value2, by = list(dat$cat2), FUN = sum)
dat2$per2 = dat2$x / sum(dat2$x)
# dat2$Group.1 <- factor(dat2$Group.1,levels = c("Hardcore","Softcore","Shell","Cloud"))
dat2 <- dat2[c(2,4,3,1),]

for (i in seq(nrow(dat2), 1)) {
  if (i == nrow(dat2)) {
    dat2$per.y2[i] = dat2$per2[i] / 2
  }else{
    dat2$per.y2[i] = sum(dat2$per2[(i + 1):nrow(dat2)]) + dat2$per2[i] / 2
  }
}

dat2
dat2$label2 = paste(dat2$Group.1,"\n",dat2$x,'(',round(dat2$per2*100, 2),'%',')', sep = '')
dat2$d2="b"
dat2

dat2$Group.1 <- factor(dat2$Group.1,levels = c("Hardcore","Softcore","Shell","Cloud"))
dat2$label2 <- factor(dat2$label2,levels = c("Hardcore\n33258(76.52%)",
                                             "Softcore\n2872(6.61%)", 
                                             "Shell\n7154(16.46%)", 
                                             "Cloud\n178(0.41%)" ))


p2=ggplot() + 
  geom_bar(data =dat2, aes(d2,per2,fill=Group.1),stat = "identity",position = "stack")+
  geom_text(data =dat2, aes(2, as.numeric(per.y2),label = label2),size =2.5, color = 'black');p2


# 合并作图 ----------------------------------------------------------------------

p=ggplot() + 
  geom_bar(data = dat1,aes(d1,per1,fill=Group.1),stat = "identity",position = "stack",
           # width = 0.85,
           color = 'white')+
  geom_text(data = dat1,aes(1.1, as.numeric(per.y1),label = label1),size = 5, color = 'black')+
  geom_bar(data =dat2, aes(d2,per2,fill=Group.1),stat = "identity",position = "stack",
           # width = 1.25,
           color = 'white')+
  geom_text(data =dat2, aes(2, as.numeric(per.y2),label = label2),size =5, color = 'black')+
  scale_y_continuous(labels = scales::percent) +
  coord_polar(theta = "y") + # 转换坐标轴
  theme_void() +
  # scale_fill_igv() + # 设置填充色
  # scale_fill_aaas() +
  scale_fill_lancet() +
  theme(legend.position = 'none');p # 隐藏图例

#width=height=8
