#vcftools --gzvcf snp_hardfilter.vcf.gz --max-missing 0.5 --mac 3 --minQ 30 --recode --recode-INFO-all --out raw.g5mac3.vcf 
vcftools \
	--minDP 4 \
	--maxDP 100 \
	--minGQ  10 \
	--minQ 30 \
	--min-meanDP 3 \
	--out meanDP3.miss0.8.maf0.01 \
	--gzvcf snp_hardfilter.vcf.gz \
	--recode --recode-INFO-all \
	--max-missing 0.8 \
	--mac 3 \
	--min-alleles 2 --max-alleles 2 \
	--maf 0.01
