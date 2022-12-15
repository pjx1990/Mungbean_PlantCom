library(gdsfmt)
library(SNPRelate)

# 输入 PLINK 文件路径
bed.fn <- "test.bed"
fam.fn <- "test.fam"
bim.fn <- "test.bim"

# 将 PLINK 文件转为 GDS 文件
snpgdsBED2GDS(bed.fn, fam.fn, bim.fn, "test.gds")

# 读取 GDS 文件
genofile <- snpgdsOpen("test.gds")

# 根据 LD 过滤 SNPs，阈值根据需要设定
set.seed(1000)
snpset <- snpgdsLDpruning(genofile, ld.threshold=0.2)

# 选择 SNP pruning 后要保留的 SNP
snpset.id <- unlist(unname(snpset))

# 计算 PCA，num.thread 是并行的线程数
pca <- snpgdsPCA(genofile, snp.id=snpset.id, num.thread=10)

# 以百分比形式输出 variance proportion
print(pca$varprop*100)
