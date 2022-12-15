gatk=/data/software/soft/gatk-4.1.0.0/gatk
# gz格式需要用tabix索引
vcf=../merge_plus_seed95/allsample_bcftools.vcf.gz
out_prefix=snp_hardfilter

$gatk VariantFiltration \
    -V $vcf \
    -filter "QD < 2.0" --filter-name "QD2" \
    -filter "MQ < 40.0" --filter-name "MQ40" \
    -filter "QUAL < 30.0" --filter-name "QUAL30" \
    -filter "FS > 60.0" --filter-name "FS60" \
    -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
    -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \
    -O ${out_prefix}.vcf.gz


