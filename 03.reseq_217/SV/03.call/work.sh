#ls /project/pengjx/mungbean/01.callvcf/gwas/bam/*.bam|while read a;do b=`basename $a`;c=${b/.rmdup.bam/};echo delly call -g /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa -v ../02.merge/sites.bcf -o $c.geno.bcf $a >> worklist.sh;done
delly call -g /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa -v ../02.merge/sites.bcf -o lz-1.geno.bcf /project/pengjx/mungbean/01.callvcf/gwas/bam/lz-1.rmdup.bam

