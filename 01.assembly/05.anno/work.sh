#ls /project/pengjx/rawdata/RNAseq/mungbean_RNASeq-reads/*_1.fq.gz|while read a;do b=`dirname $a`;c=`basename $a`;d=${c/_1.fq.gz/};echo /data/software/soft/hisat2-2.1.0/hisat2 -p 8 --dta -x /project/fujun/01.assembly/05.latest_ref/vigna_radiata.genome.fa -1 $a -2 $b/${d}_2.fq.gz 2">"$d.mapstat ">" ${d}.nosort.bam ";"/data/software/miniconda2/envs/masurca/bin/samtools sort -@ 8 ${d}.nosort.bam ">" ${d}.bam >> hisat.sh;done
#ls /project/pengjx/rawdata/RNAseq/mungbean_flower_RNAseq_cleandata/*_1.clean.fq.gz |while read a;do b=`dirname $a`;c=`basename $a`;d=${c/_1.clean.fq.gz/};echo /data/software/soft/hisat2-2.1.0/hisat2 -p 8 --dta -x /project/fujun/01.assembly/05.latest_ref/vigna_radiata.genome.fa -1 $a -2 $b/${d}_2.clean.fq.gz 2">"$d.mapstat ">"${d}.nosort.bam ";"/data/software/miniconda2/envs/masurca/bin/samtools sort -@ 8 ${d}.nosort.bam ">" ${d}.bam >> hisat.sh;done
#cut -d' ' -f 18 hisat.sh |while read a;do b=${a/.bam/};echo /data/software/soft/stringtie-2.1.5/stringtie $a -l $b -p 8 -o ${b}.gtf;done
/data/software/miniconda2/bin/parallel -j 10 < hisat.sh
/data/software/miniconda2/bin/parallel -j 10 < stringtie.sh

