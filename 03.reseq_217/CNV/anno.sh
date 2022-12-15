#java -jar snpEff/snpEff.jar build -gff3 mungbean
java -jar snpEff/snpEff.jar -v mungbean cnv.vcf >cnv.anno.vcf
#bgzip DP5miss09maf005.indel.anno.vcf
#tabix -p vcf DP5miss09maf005.indel.anno.vcf.gz
