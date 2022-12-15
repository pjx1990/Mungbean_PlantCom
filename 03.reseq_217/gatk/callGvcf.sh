sample=$1    # sample name
fastq1=$2    # gzipped raw fastq file of read 1
fastq2=$3    # gzipped raw fastq file of read 2

## software
ref=/project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa
picard=/data/software/soft/picard.jar
gatk=/data/software/soft/gatk-3.8-1/GenomeAnalysisTK.jar
bwa=/data/software/soft/bwa-0.7.17/bwa
samtools=/data/software/miniconda2/envs/masurca/bin/samtools
java=/data/software/miniconda2/bin/java

# step1: 
# please use raw fastq data for bwa alignment directly instead of clean data.
$bwa mem  -t 8 -k 19 -M -R "@RG\tID:$sample\tLB:$sample\tSM:$sample" $ref $fastq1 $fastq2|$samtools view -b -t ${ref}.fai - > ${sample}.bam

# step2: sort
$samtools sort -@ 8 ${sample}.bam -o ${sample}.sorted.bam
rm -f ${sample}.bam

# step3: mark duplications
$java -XX:ParallelGCThreads=8 -Xmx14g -jar $picard MarkDuplicates INPUT=${sample}.sorted.bam  MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=800 TMP_DIR=./temp OUTPUT=${sample}.rmdup.bam METRICS_FILE=${sample}.rmdup.metrics
rm -f ${sample}.sorted.bam
$samtools index ${sample}.rmdup.bam

## step4: bam to gvcf, please use GATK version 3.7+
##$java -jar -XX:ParallelGCThreads=2 -Xmx10g $gatk -T HaplotypeCaller --variant_index_type LINEAR --variant_index_parameter 128000 -R $ref -I ${sample}.rmdup.bam --emitRefConfidence GVCF -o ${sample}.g.vcf.gz

#java=/usr/bin/java
#gatk=/data/software/soft/gatk-4.1.0.0/gatk-package-4.1.0.0-local.jar
#$java -jar -XX:ParallelGCThreads=2 -Xmx10g $gatk HaplotypeCaller -R $ref -I ${sample}.rmdup.bam --emit-ref-confidence  GVCF -O ${sample}.g.vcf.gz
#$java -jar -XX:ParallelGCThreads=2 -Xmx10g $gatk HaplotypeCaller -R $ref -I ${sample}.rmdup.bam -O ${sample}.g.vcf.gz
#$java -jar -XX:ParallelGCThreads=2 -Xmx10g $gatk HaplotypeCaller -R $ref -I ${sample}.rmdup.bam -stand_call_conf 30 -O ${sample}.g.vcf.gz

/data/software/soft/gatk-4.1.0.0/gatk HaplotypeCaller -R $ref -I ${sample}.rmdup.bam --emit-ref-confidence GVCF -O ${sample}.g.vcf.gz
