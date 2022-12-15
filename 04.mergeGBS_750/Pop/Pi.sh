vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../East_Asia.lst >East_Asia.vcf
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../South_Asia.lst >South_Asia.vcf
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../Southeast_Asia.lst >Southeast_Asia.vcf
vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../West_Asia.lst >West_Asia.vcf
#vcftools --vcf ../meanDP3.miss0.6.maf0.01.impute.rename.vcf --recode --recode-INFO-all --stdout --keep ../Other.lst >Other.vcf
vcftools --vcf East_Asia.vcf --window-pi 1000 --out East_Asia
vcftools --vcf South_Asia.vcf --window-pi 1000 --out South_Asia
vcftools --vcf Southeast_Asia.vcf --window-pi 1000 --out Southeast_Asia
vcftools --vcf West_Asia.vcf --window-pi 1000 --out West_Asia
#vcftools --vcf Other.vcf --window-pi 1000 --out Other
