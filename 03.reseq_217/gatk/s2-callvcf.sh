/data/software/soft/gatk-4.1.0.0/gatk GenotypeGVCFs -R /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa -V merge.g.vcf.gz -O merge.vcf.gz
/data/software/soft/gatk-4.1.0.0/gatk SelectVariants -R /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa -V merge.vcf.gz -O merge.snp.vcf.gz --select-type-to-include SNP
/data/software/soft/gatk-4.1.0.0/gatk SelectVariants -R /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa -V merge.vcf.gz -O merge.indel.vcf.gz --select-type-to-include INDEL
