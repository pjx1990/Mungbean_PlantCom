#/data/software/soft/juicer/scripts/juicer.sh -g genome -s MboI -z reference/genome.fa -y reference/genome_MboI.txt -p reference/genome.chrom.size -D /data/software/soft/juicer -t 36 -S early &> juicer.log 
/data/software/soft/3d-dna/run-asm-pipeline.sh -r 2 reference/genome.fa aligned/merged_nodups.txt &> 3d.log

