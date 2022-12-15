perl below50bp.pl DP5miss09maf005.indels.recode.vcf >below50bp.vcf
#gatk call indel <50 bp
perl below50bp.pl DP5miss09maf005.indels.recode.vcf >below15bp.vcf
perl below5bp.pl DP5miss09maf005.indels.recode.vcf >below5bp.vcf
