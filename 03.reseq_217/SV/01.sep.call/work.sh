ls /project/pengjx/mungbean/01.callvcf/gwas/bam/*.bam|while read a;do b=`basename $a`;c=${b/.rmdup.bam/};echo delly call -g /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa -o $c.bcf $a >> worklist.sh;done

