export GENEMARK_PATH=/data/software/soft/gmes_linux_64
export PATH=/data/software/soft/gmes_linux_64/ProtHint/bin:/project/fujun/01.assembly/06.anno/braker2/GUSHR:$PATH
#braker.pl --species=brakerVigna --genome=/project/fujun/01.assembly/05.latest_ref/vigna_radiata.genome.sm.fa --bam=../JL7_1.bam,../JL7_3.bam,../JL7_SE_2.bam,../JL7_2.bam,../JL7_SE_1.bam,../JL7_SE_3.bam --softmasking --cores=40
braker.pl --species=brakerVigna2 --genome=/project/fujun/01.assembly/05.latest_ref/vigna_radiata.genome.sm.fa --bam=../JL7_1.bam,../JL7_3.bam,../JL7_SE_2.bam,../JL7_2.bam,../JL7_SE_1.bam,../JL7_SE_3.bam --softmasking --cores=40 --prot_seq proteins.fasta --etpmode --gff3 --workingdir=braker2 --addUTR=on
#braker.pl --species=brakerVigna3 --genome=/project/fujun/01.assembly/05.latest_ref/vigna_radiata.genome.sm.fa --bam=../JL7_1.bam,../JL7_3.bam,../JL7_SE_2.bam,../JL7_2.bam,../JL7_SE_1.bam,../JL7_SE_3.bam --softmasking --cores=60 --prot_seq proteins.fasta --etpmode --gff3 --workingdir=braker3 --UTR=on


#getAnnoFastaFromJoingenes.py -g ../../../05.latest_ref/vigna_radiata.genome.fa -o check -f augustus.hints.gtf -s True
python /project/fujun/01.assembly/06.anno/pan/braker/check/selectSupportedSubsets.py augustus.hints.gtf hintsfile.gff --fullSupport full.txt --anySupport any.txt --noSupport no.txt
