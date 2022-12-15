vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --weir-fst-pop ../East_Asia.lst--weir-fst-pop ../South_Asia.lst --out east-south --fst-window-size 1000
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --weir-fst-pop ../East_Asia.lst--weir-fst-pop ../Southeast_Asia.lst --out east-southeast --fst-window-size 1000
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --weir-fst-pop ../East_Asia.lst--weir-fst-pop ../West_Asia.lst --out east-west --fst-window-size 1000
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --weir-fst-pop ../South_Asia.lst --weir-fst-pop ../West_Asia.lst --out south-west --fst-window-size 1000
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --weir-fst-pop ../South_Asia.lst --weir-fst-pop ../Southeast_Asia.lst --out south-southeast --fst-window-size 1000
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --weir-fst-pop ../West_Asia.lst--weir-fst-pop ../Southeast_Asia.lst --out west-southeast --fst-window-size 1000

#Rscript plot_asia_fst.r
