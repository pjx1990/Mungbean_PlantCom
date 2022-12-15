#bgzip DP5miss09.recode.vcf
#tabix -p vcf DP5miss09.recode.vcf.gz
gatk=/data/software/soft/gatk-4.1.0.0/gatk
vcf=DP5miss09.recode.vcf.gz
$gatk VariantFiltration \
    -V $vcf \
    --cluster-window-size 5 --cluster-size 2 \
    --output DP5miss09.win5size2.vcf
#    -filter "QD < 2.0" --filter-name "QD2" \
#    -filter "QUAL < 30.0" --filter-name "QUAL30" \
#    -filter "SOR > 3.0" --filter-name "SOR3" \
#    -filter "FS > 60.0" --filter-name "FS60" \
#    -filter "MQ < 40.0" --filter-name "MQ40" \
#    -filter "MQRankSum < -12.5" --filter-name "MQRankSum-12.5" \
#    -filter "ReadPosRankSum < -8.0" --filter-name "ReadPosRankSum-8" \

vcftools --gzvcf DP5miss09.win5size2.vcf --remove-filtered-all --recode --stdout | gzip -c >DP5miss0.9Maf0.05Win5size2.vcf.gz
