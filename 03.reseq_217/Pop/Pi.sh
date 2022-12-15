vcftools --gzvcf /project/pengjx/mungbean/03.gwas/01-filterSNP/SNP.vcf.gz --recode --recode-INFO-all --stdout  --keep ../NonChina.lst >NonChina.vcf
vcftools --gzvcf /project/pengjx/mungbean/03.gwas/01-filterSNP/SNP.vcf.gz --recode --recode-INFO-all --stdout  --keep ../Landrace.lst >Landrace.vcf
vcftools --gzvcf /project/pengjx/mungbean/03.gwas/01-filterSNP/SNP.vcf.gz --recode --recode-INFO-all --stdout  --keep ../Cultivar.lst >Cultivar.vcf


vcftools --vcf NonChina.vcf --window-pi 10000 --out NonChina_10K
vcftools --vcf Landrace.vcf --window-pi 10000 --out Landrace_10K
vcftools --vcf Cultivar.vcf --window-pi 10000 --out Cultivar_10K

rm *.vcf
