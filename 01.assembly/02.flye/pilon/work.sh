#/data/software/soft/bwa-0.7.17/bwa index assembly.fasta 
#sh bwaGvcf.sh refL1 /backup/NDES00271_L1_1_clean.rd.fq.gz /backup/NDES00271_L1_2_clean.rd.fq.gz &
#sh bwaGvcf.sh refL2 /backup/NDES00271_L2_1_clean.rd.fq.gz /backup/NDES00271_L2_2_clean.rd.fq.gz &
#wait
#/data/software/miniconda2/envs/masurca/bin/samtools merge -@8 ref.rmdup.bam refL1.rmdup.bam refL2.rmdup.bam
#/data/software/miniconda2/envs/masurca/bin/samtools index ref.rmdup.bam
#/data/software/miniconda2/envs/masurca/bin/samtools flagstat -@8 ref.rmdup.bam > aln.info 
#MOSDEPTH_PRECISION=5 ./mosdepth -t 16 ref ref.rmdup.bam
#python depth.plot.py --input depth.hist.txt --output ref.depth --sample ref
java -Xmx450G -jar /data/software/soft/pilon-1.24.jar --genome assembly.fasta --bam ref.rmdup.bam --output pilon1x --outdir pilon1x --changes --vcf --diploid --threads 8


#plot depth
#grep '^total' ref.mosdepth.global.dist.txt |tac > depth.txt
#python cal.py > depth.hist.txt
#python depth.plot.py --input depth.hist.txt --output ref.depth --sample ref

