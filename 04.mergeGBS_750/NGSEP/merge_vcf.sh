##合并不同染色体
#java -jar /project/pengjx/biosoft/NGSEPcore_4.1.0/NGSEPcore_3.0.2.jar MergeVariants /project/pengjx/mungbean/01.callvcf/SNP_Calling_NGSEP/Wvc293/00genome/sequenceNames.txt merge_variants.vcf bam_vcf/*_NGSEP.vcf
##合并不同样本
java -jar /project/pengjx/biosoft/NGSEPcore_4.1.0/NGSEPcore_3.0.2.jar MergeVCF /project/pengjx/mungbean/01.callvcf/SNP_Calling_NGSEP/Wvc293/00genome/sequenceNames.txt bam_vcf/*_NGSEP.vcf 1>merge_population.vcf
