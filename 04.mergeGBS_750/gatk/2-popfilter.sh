##vcftools --minDP 4 --maxDP 100 --minGQ  10 --minQ 30 --min-meanDP 3 \
##  --out aw.SNP.filter.QD2.QUAL30.SOR3.FS60.MQ40.MQRankSum-12.5.ReadPosRankSum-8.minDP4.maxDP100.minGQ10.minQ30.min-meanDP3.miss0.2.maf0.01.vcf \
##  --vcf raw.SNP.filter.QD2.QUAL30.SOR3.FS60.MQ40.MQRankSum-12.5.ReadPosRankSum-8.vcf \
##  --recode --recode-INFO-all --max-missing 0.8 --maf 0.01
# 
#vcftools --gzvcf snp_hardfilter.vcf.gz --max-missing 0.5 --mac 3 --minQ 30 --recode --recode-INFO-all --out raw.g5mac3.vcf 
vcftools \
	--minDP 4 \
	--maxDP 100 \
	--minGQ  10 \
	--minQ 30 \
	--min-meanDP 3 \
	--out meanDP3.miss0.5.maf0.01.vcf \
	--gzvcf snp_hardfilter.vcf.gz \
	--recode --recode-INFO-all \
	--max-missing 0.5 \
	--mac 3 \
	--maf 0.01
