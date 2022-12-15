# get merge shell
echo "/data/software/soft/gatk-4.1.0.0/gatk CombineGVCFs \\" >s1-merge_gvcf.sh
echo ' -R /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa \'>>s1-merge_gvcf.sh
ls gvcf/*g.vcf.gz |while read i;do
#echo " --variant $i \ " >>gvcf_list
echo ' --variant ' ${i}  ' \' >>s1-merge_gvcf.sh
done
echo " -O merge.g.vcf.gz ">>s1-merge_gvcf.sh
