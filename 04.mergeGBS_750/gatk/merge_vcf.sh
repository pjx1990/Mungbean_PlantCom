# conda activate bcftools
bcftools index -t phos144.snp.vcf.gz
bcftools index -t wvc296.snp.vcf.gz
bcftools index -t gwas.snp.vcf.gz
bcftools index -t seed93.snp.vcf.gz

bcftools merge gwas.snp.vcf.gz phos144.snp.vcf.gz wvc296.snp.vcf.gz seed93.snp.vcf.gz -o allsample_bcftools.vcf

bcftools view allsample_bcftools.vcf -Oz -o allsample_bcftools.vcf.gz
bcftools index allsample_bcftools.vcf.gz
tabix -p vcf allsample_bcftools.vcf.gz
