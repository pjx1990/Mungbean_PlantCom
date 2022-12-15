pav <- read.csv("./genePAV.csv",header = T,check.names = F)
remove_pav <- pav[!duplicated(pav),]
write.csv(remove_pav,"remove_dup_genePAV.csv",row.names = F)

out.dist=dist(t(remove_pav[-1]),method="euclidean") 
out.hclust=hclust(out.dist,method="complete") 
png("cluster.png",width = 3000,height = 600)
plot(out.hclust,xlab = "")   
dev.off()


pdf("cluster.pdf",width = 35,height = 10)
plot(out.hclust,xlab = "")   
dev.off()
