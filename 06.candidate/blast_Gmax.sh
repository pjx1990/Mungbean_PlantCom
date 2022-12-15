#/data/software/soft/ncbi-blast-2.7.1+/bin/makeblastdb -in /project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/blast/Glycine_max.Glycine_max_v2.1.cds.all.fa -dbtype nucl -parse_seqids
/data/software/soft/ncbi-blast-2.7.1+/bin/blastn -db /project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/blast/Glycine_max.Glycine_max_v2.1.cds.all.fa -query ../cds.fa -outfmt 6 -max_target_seqs 1 -evalue 1e-5 -out Glycine_max_cds_blast.out -num_threads 6
grep '>' /project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/blast/Glycine_max.Glycine_max_v2.1.cds.all.fa |sed 's/^>//' >Glycine_max.gene
awk  '{if(NR==FNR){a[$1]=$0}else if($2 in a)print $1"\t"a[$2]}' FS="" Glycine_max.gene FS="\t" Glycine_max_cds_blast.out >gene2Glycine_max.xls
/data/software/soft/ncbi-blast-2.7.1+/bin/blastp -db /project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/blast/Glycine_max.Glycine_max_v2.1.pep.all.fa -query ../protein.fa -outfmt 6 -max_target_seqs 1 -evalue 1e-5 -out Glycine_max_pep.out -num_threads 6

grep '>' /project/pengjx/mungbean/tidy4paper/gwas/MTAs_reannot/blast/Glycine_max.Glycine_max_v2.1.pep.all.fa |sed 's/^>//' >Glycine_max.protein
awk  '{if(NR==FNR){a[$1]=$0}else if($2 in a)print $1"\t"a[$2]}' FS=" " Glycine_max.protein  FS="\t" Glycine_max_pep.out >protein2Glycine_max.xls
sed 's/\(KR.*\) pep chromosome:\(.*\) gene:\(.*\) transcript:\(.*\) transcript_biotype:protein_coding \(.*\)/\1\t\3\t\5/g' protein2Glycine_max.xls |sort -u >protein2Glycine_max2.xls
