java -jar /project/pengjx/biosoft/NGSEPcore_4.1.0/NGSEPcore.jar GenomeIndexer -i vigna_radiata.genome.fa -o test
samtools faidx vigna_radiata.genome.fa 
nohup bowtie2-build vigna_radiata.genome.fa index & 
