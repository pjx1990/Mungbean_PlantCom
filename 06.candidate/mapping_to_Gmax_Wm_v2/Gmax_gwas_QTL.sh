blat vrad_flank2k.fa snp_flank2k.fa -out=blast8 gmax2vard.out
perl extractSNPflankSeq.pl /project/pengjx/mungbean/00.genome/Glymax_Wm82.a2.v1/assembly/Gmax_275_v2.0.fa snp.lst 2000 >snp_flank2k.fa
perl extractSNPflankSeq_vrad.pl /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa uniqe_MTAs.lst 2000 >vrad_flank2k.fa
#cut -f 2-3 gwas.qtl |sort -u |sed 's/Gm/Chr/g' >uniq_gwas.pos

export PATH=$PATH:/project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/iTools_Code/
iTools Gfftools AnoVar -Var uniq_gwas.pos -Gff /project/pengjx/mungbean/00.genome/Glymax_Wm82.a2.v1/annotation/Gmax_275_Wm82.a2.v1.gene.gff3 -OutPut gwas_gene.anno
#iTools Gfftools AnoVar -Var uniq_gwas.pos -Gff /project/pengjx/mungbean/00.genome/Glymax_Wm82.a2.v1/annotation/Gmax_275_Wm82.a2.v1.gene.gff3 -OutPut gwas_allsnp.anno -PrintNA


zcat gwas_gene.anno.gz |sed 's/.[0-9].Wm82.a2.v1//g' |sed 's/Chr/Gm/g' |sort -u >gwas_gene.anno
cut -f 3 gwas_gene.anno |sort -u >gwas_uniq.gene
