sample=$1    # sample name
fastq1=$2    # gzipped raw fastq file of read 1
fastq2=$3    # gzipped raw fastq file of read 2

ref=/project/fujun/02.pan/04.bwa/ref/merge.fa

bwa mem -t 8 -M -R "@RG\tID:$sample\tLB:$sample\tSM:$sample" $ref $fastq1 $fastq2 | samtools fixmate -m -O bam - - | samtools sort -@ 1 -O bam - | samtools markdup -@ 8 - - > $sample.rmdup.bam
