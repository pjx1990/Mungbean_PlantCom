# NGSEP好像不支持bwa比对结果，且不用去重？在所有文档中都没看到有去重步骤

sample=$1  #KM-16-81  #CHINA-MUNG  #KM-16-82
fq_name=$2  #SRR11210707  #SRR11210706 #SRR11210705
reference=/project/pengjx/mungbean/01.callvcf/SNP_Calling_NGSEP/Wvc293/00genome/vigna_radiata.genome.fa
bowtie2=~/miniconda3/bin/bowtie2
samtools=~/miniconda3/bin/samtools

${bowtie2} --rg-id ${sample} --rg SM:${sample} --rg PL:ILLUMINA -t -x /project/pengjx/mungbean/01.callvcf/SNP_Calling_NGSEP/Wvc293/00genome/vigna_radiata.genome.fa -U trim_fq/${fq_name}.fastq.gz |samtools view -bhS - >${sample}.bam
#${bowtie2} --rg-id ${sample} --rg SM:${sample} --rg PL:ILLUMINA -t -x /project/pengjx/mungbean/01.callvcf/SNP_Calling_NGSEP/Wvc293/00genome/vigna_radiata.genome.fa -1 trim_fq/${fq_name}_1.fastq.gz -2 trim_fq/${fq_name}_2.fastq.gz |samtools view -bhS - >${sample}.bam
#java -jar /data/software/soft/picard.jar SortSam MAX_RECORDS_IN_RAM=1000000 SO=coordinate CREATE_INDEX=true TMP_DIR=tmp I=SRR11210705_bowtie2.bam O=SRR11210705_bowtie2_sorted.bam
${samtools} sort -@ 3 ${sample}.bam -o ${sample}.sort.bam
rm ${sample}.bam
java -Xmx4g -jar /project/pengjx/biosoft/NGSEPcore_4.1.0/NGSEPcore_3.0.2.jar CoverageStats ${sample}.sort.bam ${sample}.coverage.stats
java -Xmx4g -jar /project/pengjx/biosoft/NGSEPcore_4.1.0/NGSEPcore_3.0.2.jar FindVariants -noRep -noRD -noRP  -h 0.0001 -maxBaseQS 30 -minQuality 30 -maxAlnsPerStartPos 100 -sampleId ${sample} ${reference} ${sample}.sort.bam ${sample}_NGSEP
mv ${sample}.sort.bam ${sample}.coverage.stats ${sample}_NGSEP.vcf ${sample}.log bam_vcf
