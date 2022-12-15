#!/usr/bin/env Rscript

library(ggplot2)

argv <- commandArgs(TRUE)

pcs <- argv[1]
outpre <- argv[2]
pcs <- read.table(pcs, head=FALSE)
pcs <- pcs[,seq(5)]
colnames(pcs) <- c('Group', 'Sample', 'PC1', 'PC2', 'PC3')
pops <- nlevels(pcs$Group)

colours <- c("red", "blue", "green", "#daa520", "burlywood4") #lan, hong, huang, lv
#colours <- rep(colours, 5)[seq(pops)]
colours <- rep(colours, 5)
shapes <- c(21, 22, 4, 24, 10)
#shapes <- rep(shapes, each=5)[seq(pops)]
shapes <- rep(shapes, each=5)

p <- ggplot(pcs, aes(PC1, PC2, colour=factor(Group), shape=factor(Group))) +
geom_point(alpha=0.5, size=2, stroke=1.5) + scale_colour_manual(values=colours) +
scale_fill_manual(values=colours) +
scale_shape_manual(values=shapes) +
theme(panel.background = element_blank(),panel.grid.minor=element_blank(),
panel.border=element_rect(colour="#666666",fill="NA"))

#ggsave(filename=paste(outpre,'.PC12.pdf', sep=''), plot=p)
ggsave(filename=paste(outpre,'.PC12.png', sep=''), plot=p)

p <- ggplot(pcs, aes(PC1, PC3, colour=factor(Group), shape=factor(Group))) +
geom_point(alpha=0.5, size=2, stroke=1.5) + scale_colour_manual(values=colours) +
scale_fill_manual(values=colours) +
scale_shape_manual(values=shapes) +
theme(panel.background = element_blank(),panel.grid.minor=element_blank(),
panel.border=element_rect(colour="#666666",fill="NA"))

#ggsave(filename=paste(outpre,'.PC13.pdf', sep=''), plot=p)
ggsave(filename=paste(outpre,'.PC13.png', sep=''), plot=p)

p <- ggplot(pcs, aes(PC2, PC3, colour=factor(Group), shape=factor(Group))) +
geom_point(alpha=0.5, size=2, stroke=1.5) + scale_colour_manual(values=colours) +
scale_fill_manual(values=colours) +
scale_shape_manual(values=shapes) +
theme(panel.background = element_blank(),panel.grid.minor=element_blank(),
panel.border=element_rect(colour="#666666",fill="NA"))

#ggsave(filename=paste(outpre,'.PC23.pdf', sep=''), plot=p)
ggsave(filename=paste(outpre,'.PC23.png', sep=''), plot=p)
