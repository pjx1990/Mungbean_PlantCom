/data/software/soft/ncbi-blast-2.7.1+/bin/blastp -db /project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/blast/Arabidopsis_thaliana.TAIR10.pep.all.fa -query ../protein.fa -outfmt 6 -max_target_seqs 1 -evalue 1e-5 -out Arabidopsis_pep.out -num_threads 6

grep '>' /project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/blast/Arabidopsis_thaliana.TAIR10.pep.all.fa |sed 's/^>//' >Arabidopsis.protein
awk  '{if(NR==FNR){a[$1]=$0}else if($2 in a)print $1"\t"a[$2]}' FS=" " Arabidopsis.protein  FS="\t" Arabidopsis_pep.out >protein2Arabidopsis.xls
sed 's/\(AT.*\) pep chromosome:TAIR10:\(.*\) gene:\(.*\) transcript:\(.*\) transcript_biotype:protein_coding \(.*\)/\1\t\3\t\5/g' protein2Arabidopsis.xls |sort -u >protein2Arabidopsis2.xls
#/data/software/soft/ncbi-blast-2.7.1+/bin/makeblastdb -in Arabidopsis_thaliana.TAIR10.cds.all.fa -dbtype nucl -parse_seqids
/data/software/soft/ncbi-blast-2.7.1+/bin/blastn -db /project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/blast/Arabidopsis_thaliana.TAIR10.cds.all.fa -query ../cds.fa -outfmt 6 -max_target_seqs 1 -evalue 1e-5 -out Arabidopsis_cds_blast.out -num_threads 6
grep '>' /project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/blast/Arabidopsis_thaliana.TAIR10.cds.all.fa |sed 's/^>//' >Arabidopsis.gene
awk  '{if(NR==FNR){a[$1]=$0}else if($2 in a)print $1"\t"a[$2]}' FS=" " Arabidopsis.gene FS="\t" Arabidopsis_cds_blast.out >gene2Arabidopsis.xls
