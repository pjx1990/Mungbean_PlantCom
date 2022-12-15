vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../List/asia/East_Asia.list >East_Asia.vcf
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../List/asia/South_Asia.list >South_Asia.vcf
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../List/asia/Southeast_Asia.list >Southeast_Asia.vcf
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../List/asia/West_Asia.list >West_Asia.vcf
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../List/asia/Other.list >Other.vcf
vcftools --vcf East_Asia.vcf --TajimaD 1000 --out East_Asia
vcftools --vcf South_Asia.vcf --TajimaD 1000 --out South_Asia
vcftools --vcf Southeast_Asia.vcf --TajimaD 1000 --out Southeast_Asia
vcftools --vcf West_Asia.vcf --TajimaD 1000 --out West_Asia
vcftools --vcf Other.vcf --TajimaD 1000 --out Other

Rscript plot_asia.r
