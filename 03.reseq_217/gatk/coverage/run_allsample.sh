#for i in `ls ../bam/*.bam`;do
#sample=`basename $i |sed 's/.rmdup.bam//'`
#echo $sample
#nohup /project/pengjx/biosoft/BamDeal/bin/BamDeal_Linux statistics Coverage -i $i -r /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa -o $sample &
#done
for i in `seq 181 219`;do
nohup /project/pengjx/biosoft/BamDeal/bin/BamDeal_Linux statistics Coverage -i ../bam/lz-${i}.rmdup.bam -r /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa -o lz-${i} & 
done
