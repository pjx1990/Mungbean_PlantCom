samtools faidx genome.fa
faidx genome.fa -i chromsizes >sizes.genome
head -11 sizes.genome |bedtools makewindows -g stdin -w 1000000 >genome_1M.bed

cut -f 2-4 all_gene_pos.txt |bedtools coverage -a genome_1M.bed  -b stdin -counts >all_gene_density.xls
cut -f 2-4 variable_gene_pos.txt |bedtools coverage -a genome_1M.bed  -b stdin -counts >variable_gene_density.xls
cut -f 2-4 Core_gene_pos.txt |bedtools coverage -a genome_1M.bed  -b stdin -counts >core_gene_density.xls

#cut -f 4 variable_gene_density.xls >variable
#cut -f 4 core_gene_density.xls >core
#paste all_gene_density.xls core variable >tmp
#echo -e "#Chr\tStart\tEnd\tAll\tCore\tVariable" >header
#cat header tmp >gene_density.xls
#!/bin/sh
#$ -S /bin/sh
#Version1.0	hewm@genomics.org.cn	2020-11-09
echo Start Time : 
date
/project/pengjx/biosoft/RectChr-1.30/bin/RectChr	-InConfi	in.cofi	-OutPut	pav_gene_density	
#../../bin/RectChr	-InConfi	in2.cofi	-OutPut	OUT2	
echo End Time : 
date
