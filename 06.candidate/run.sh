export PATH=$PATH:/project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/iTools_Code/
#iTools Gfftools AnoVar -Var uniq_MTAs.txt -Gff /project/pengjx/mungbean/00.genome/final.gff3 -OutPut MTAs
iTools Gfftools AnoVar -Var uniq_MTAs.txt -Gff /project/pengjx/mungbean/00.genome/final.gff3 -OutPut MTAs -PrintNA
zcat MTAs.gz |cut -f 3 |sort -r |sort -u >uniq_gene
len MTAs.gz  |grep -v 'intergenic' |cut -f 1-2 |sort -u >uniq_coding_region.list
seqtk subseq /project/pengjx/mungbean/00.genome/final.cds.fa uniq_gene >cds.fa
seqtk subseq /project/pengjx/mungbean/00.genome/final.protein.fa uniq_gene >protein.fa
