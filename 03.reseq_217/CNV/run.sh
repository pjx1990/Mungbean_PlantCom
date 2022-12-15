#conda activate cnv
#cnvnator -root file.root -tree /project/pengjx/mungbean/01.callvcf/gwas/gvcf/lz-1.rmdup.bam 
cnvnator -root file.root -tree /project/pengjx/mungbean/01.callvcf/gwas/gvcf/lz-2.rmdup.bam 
# cd genome;sh run.sh
cnvnator -root file.root -his 1000 -d genome/  
cnvnator -root file.root -stat 1000 
cnvnator -root file.root -partition 1000 
cnvnator -root file.root -call 1000  > cnv.call.txt
#/project/pengjx/biosoft/CNVnator/cnvnator2VCF.pl cnv.call.txt genome >lz-1.cnv.vcf
/project/pengjx/biosoft/CNVnator/cnvnator2VCF.pl cnv.call.txt genome >lz-2.cnv.vcf
#sed  -i '22s/cnv/lz-1/' lz-1.cnv.vcf
sed  -i '22s/cnv/lz-2/' lz-2.cnv.vcf
#bgzip lz-1.cnv.vcf
#tabix -p vcf lz-1.cnv.vcf.gz
bgzip lz-2.cnv.vcf
tabix -p vcf lz-2.cnv.vcf.gz
#vcf-merge lz-1.cnv.vcf.gz lz-2.cnv.vcf.gz >mrege.vcf
