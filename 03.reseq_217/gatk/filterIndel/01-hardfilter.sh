gatk=/data/software/soft/gatk-4.1.0.0/gatk
vcf=/project/pengjx/mungbean/01.callvcf/gwas/merge.indel.vcf.gz
$gatk VariantFiltration \
    -V $vcf  \
    -filter "QD < 2.0" --filter-name "QD2" \
    -filter "QUAL < 30.0" --filter-name "QUAL30" \
    -filter "FS > 200.0" --filter-name "FS200" \
    -filter "ReadPosRankSum < -20.0" --filter-name "ReadPosRankSum-20" \
    -O indels_hardfiltered.vcf.gz
