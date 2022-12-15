#for i in `seq 1 20`;do
for i in `ls ../bam/*.rmdup.bam`;do
sample=`basename $i |sed 's/.rmdup.bam//'`
echo $sample
bedtools coverage -a floweringGenes.bed -b $i -mean >${sample}.meanCov 
done
