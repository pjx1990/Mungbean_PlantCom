#source("https://raw.githubusercontent.com/YinLiLin/CMplot/master/R/CMplot.r")
source("/project/pengjx/scripts/CMplot/R/CMplot.r")
library(getopt)
#+--------------------
# get options
#+--------------------
spec <- matrix(c(
  'help', 'h', 0, "logical", "help",
  'binsize', 's', 1, "integer", "the size of bin for SNP_density plot, optional.",
  'color', 'c', 1, "character", " the colour for the SNP density, separated by ',', optional.",
  'name', 'n', 1, "character", "add a character to the output file name, optional.",
  'input', 'i', 1, "character", "vcf input file, forced."
), byrow = TRUE, ncol = 5)

opt <- getopt(spec)

#+--------------------
# check options
#+--------------------
if ( !is.null(opt$help) | is.null(opt$input) ) {
  cat(getopt(spec, usage=TRUE))
  q(status=1)
}
if ( is.null(opt$binsize ) )            { opt$binsize = 1e6 }
if ( is.null(opt$color ) )              { opt$color = c("darkgreen","yellow","red") }
if ( is.null(opt$name ) )               { opt$name = "Fig1" }

#data(pig60K)
data <- read.table(opt$input, comment.char = "#", header = F, blank.lines.skip = T)
num <- dim(data)[1]
name <- paste("A", 1:num, sep = "")
snp <- data.frame(name,data[1],data[2])
colnames(snp) = c("SNP","Chromosome","Position")
color <- unlist(strsplit( opt$color, split = ","))
print(color)
CMplot(
  snp,type="p", plot.type="d",  bin.size=opt$binsize, chr.den.col=color, #xlab = "SNP",
  file="jpg", dpi=300, memo=opt$name, file.output=TRUE, verbose=TRUE
)
CMplot(
  snp, type="p",plot.type="d",  bin.size=opt$binsize, chr.den.col=color,
  file="pdf", memo=opt$name, file.output=TRUE, verbose=TRUE
)
