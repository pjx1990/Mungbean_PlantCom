cat sample_rep_map.txt |sed -n '251,300'p |while read sample;do
#echo $sample $sample 
#echo "nohup sh single_vcf.sh $sample $sample >$sample.log &"
nohup sh single_vcf.sh $sample $sample >$sample.log &
done
