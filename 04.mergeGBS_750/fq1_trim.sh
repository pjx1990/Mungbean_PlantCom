ls /project/pengjx/rawdata/public/Phosphorus_use_efficiency_144_GBS/fq/SRR*_1.fastq.gz |while read i;do
#echo $i
sample=`echo $i |sed 's#.*/##g'`
echo $sample
seqtk trimfq -b 10 $i | gzip >trim_fq/${sample}
done
