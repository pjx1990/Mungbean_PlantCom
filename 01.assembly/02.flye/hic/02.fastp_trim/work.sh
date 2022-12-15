#/data/software/soft/fastp -i /media/绿豆基因组测序HIC原始数据/HIC/raw/RHC01185_L4_1.fq.gz -I /media/绿豆基因组测序HIC原始数据/HIC/raw/RHC01185_L4_2.fq.gz -o L4_R1.fastq.gz -O L4_R2.fastq.gz --detect_adapter_for_pe --trim_poly_g --poly_g_min_len 5 --cut_front --cut_tail --thread 18 
/data/software/soft/fastp -i /media/绿豆基因组测序HIC原始数据/HIC/raw/RHC01185_L5_1.fq.gz -I /media/绿豆基因组测序HIC原始数据/HIC/raw/RHC01185_L5_2.fq.gz -o L5_R1.fastq.gz -O L5_R2.fastq.gz --detect_adapter_for_pe --trim_poly_g --poly_g_min_len 5 --cut_front --cut_tail --thread 18 


python /data/software/soft/juicer/misc/generate_site_positions.py MboI genome genome.fa
awk 'BEGIN{OFS="\t"}{print $1, $NF}' genome_MboI.txt > genome.chrom.size

/data/software/soft/juicer/scripts/juicer.sh -g genome -s MboI -z reference/genome.fa -y reference/genome_MboI.txt -p reference/genome.chrom.size -D /data/software/soft/juicer -t 36 -S early &> juicer.log
