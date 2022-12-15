#!/bin/sh

read1=$1
read2=$2
ref=/project/fujun/02.pan/ref/mungbean-genome.fa

zcat $read1 | head -1000000 > read1.fq
zcat $read2 | head -1000000 > read2.fq

bwa mem -t 16 $ref read1.fq read2.fq | samtools sort -@4 > temp.bam

picard CollectInsertSizeMetrics I=temp.bam O=insert_size_metrics.txt M=0.5 H=insert_size_histogram.pdf
