samtools mpileup ../bam/lz-50.rmdup.bam |awk '{print $4}' | perl test.pl
