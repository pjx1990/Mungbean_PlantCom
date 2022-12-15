ls ../gvcf/*.bam |while read i;do
sample=`basename $i |sed 's/.rmdup.bam//g'`
echo $sample
/data/software/miniconda2/envs/masurca/bin/samtools flagstat $i >$sample.flagstat &
done
