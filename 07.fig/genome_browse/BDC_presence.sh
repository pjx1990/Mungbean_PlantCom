#samtools faidx /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa 4:51015000-51016000 >left.fa
#samtools faidx /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa 4:51150000-51151000 >right.fa

samtools faidx /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa 4:51010000-51016000 >left.fa
samtools faidx /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa 4:51151000-51156000 >right.fa

/data/software/soft/ncbi-blast-2.7.1+/bin/makeblastdb -in lz-4.fa -dbtype nucl -parse_seqids
/data/software/soft/ncbi-blast-2.7.1+/bin/blastn -db lz-4.fa -query left.fa -outfmt 6 -evalue 1e-5 -out blast_lz-4_left.out
/data/software/soft/ncbi-blast-2.7.1+/bin/blastn -db lz-4.fa -query right.fa -outfmt 6 -evalue 1e-5 -out blast_lz-4_right.out

samtools faidx /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa 4:51017000-51151000 >presence.fa
/data/software/soft/ncbi-blast-2.7.1+/bin/blastn -db lz-4.fa -query presence.fa -outfmt 6 -evalue 1e-5 -out blast_lz-4_presence.out
