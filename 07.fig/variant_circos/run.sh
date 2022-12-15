bedtools makewindows -g /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa -w 100000 >window.bed
bedtools makewindows -g /project/pengjx/mungbean/00.genome/mungbean_chr.txt -w 100000 >window.bed
cat /project/pengjx/mungbean/03.gwas/02-filterIndel/DP5miss09maf005.indels.recode.vcf | bedtools coverage -a window.bed -b stdin -counts > indel.win.xls
zcat /project/pengjx/mungbean/03.gwas/01-filterSNP/DP5miss09.recode.vcf.gz | bedtools coverage -a window.bed -b stdin -counts > snp.win.xls
cat /project/pengjx/mungbean/07-sv-gwas/sv/sv.vcf | bedtools coverage -a window.bed -b stdin -counts > sv.win.xls
vcftools --gzvcf /project/pengjx/mungbean/03.gwas/01-filterSNP/DP5miss09.recode.vcf.gz --window-pi 100000 --out Pi_100k.win
vcftools --gzvcf /project/pengjx/mungbean/03.gwas/01-filterSNP/DP5miss09.recode.vcf.gz --window-pi 10000 --out pi_10k
cut -f 1-3,5 pi_10k.windowed.pi |sed '1d' >pi_10k.win.xls
awk '{print $1"\t"$2-1"\t"$3"\t"$4}' pi_10k.win.xls >pi_10k.win0.xls
Rscript ROD.r


zcat /project/pengjx/mungbean/03.gwas/snpEff/DP5miss09.anno.vcf.gz |head -584 >head
zcat /project/pengjx/mungbean/03.gwas/snpEff/DP5miss09.anno.vcf.gz |grep "synonymous_variant" >syn.snp
cat head syn.snp >tmp
bedtools coverage -a window.bed -b tmp -counts >syn.snp.win.xls
zcat /project/pengjx/mungbean/03.gwas/snpEff/DP5miss09.anno.vcf.gz |grep "missense_variant" >nonsys.snp
cat head nonsys.snp >tmp
bedtools coverage -a window.bed -b tmp -counts >nonsyn.snp.win.xls
rm tmp


Rscript nonsyn_syn.r
perl circosplot/g_karyotype.pl /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa.fai |head -11 >karyotype.txt
sort -k3 -n karyotype.txt |cut -f 1-6 |awk '{print $0"\t"$3}' >karyotype_order.txt
cut -f 1-3,6 /project/pengjx/mungbean/04.sweep/gwas-217-allsnp/sweep/landrace-cultivar.windowed.weir.fst >Fst_10.win.xls
