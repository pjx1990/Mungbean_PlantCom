# conda activate cnv
# ll /project/pengjx/mungbean/01.callvcf/gwas/gvcf/lz*.rmdup.bam |awk -F' ' '{print $8}' >sample.info
cat sample.info |while read id;do
sample=`basename $id |sed 's/.rmdup.bam//'`
echo $sample
cnvnator -root file.root -tree $id
cnvnator -root file.root -his 1000 -d genome/
cnvnator -root file.root -stat 1000
cnvnator -root file.root -partition 1000
cnvnator -root file.root -call 1000  > cnv.call.txt
/project/pengjx/biosoft/CNVnator/cnvnator2VCF.pl cnv.call.txt genome >${sample}.cnv.vcf
sed  -i "22s/cnv/${sample}/" ${sample}.cnv.vcf
bgzip ${sample}.cnv.vcf
tabix -p vcf ${sample}.cnv.vcf.gz

done
