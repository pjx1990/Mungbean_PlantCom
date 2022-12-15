ls /project/pengjx/rawdata/public/Phosphorus_use_efficiency_144_GBS/fq/SRR*_2.fastq.gz |while read i;do
#echo $i
sample=`echo $i |sed 's#.*/##g'`
echo $sample
seqtk trimfq -b 5 $i | gzip >trim_fq/${sample}
done
