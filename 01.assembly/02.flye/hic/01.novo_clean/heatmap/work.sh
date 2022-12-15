#bwa mem -t 16 -A1 -B4  -E50 -L0 /project/fujun/01.assembly/05.latest_ref/bwa_index/vigna_radiata.genome.fa /project/pengjx/rawdata/Genome/绿豆基因组测序HIC原始数据/HIC/raw/RHC01185_L4_1.fq.gz 2>>L4_R1.log | samtools view -Shb - > L4_R1.bam
#bwa mem -t 16 -A1 -B4  -E50 -L0 /project/fujun/01.assembly/05.latest_ref/bwa_index/vigna_radiata.genome.fa /project/pengjx/rawdata/Genome/绿豆基因组测序HIC原始数据/HIC/raw/RHC01185_L4_2.fq.gz 2>>L4_R2.log | samtools view -Shb - > L4_R2.bam

#bwa mem -t 16 -A1 -B4  -E50 -L0 /project/fujun/01.assembly/05.latest_ref/bwa_index/vigna_radiata.genome.fa /project/pengjx/rawdata/Genome/绿豆基因组测序HIC原始数据/HIC/raw/RHC01185_L5_1.fq.gz 2>>L5_R1.log | samtools view -Shb - > L5_R1.bam
#bwa mem -t 16 -A1 -B4  -E50 -L0 /project/fujun/01.assembly/05.latest_ref/bwa_index/vigna_radiata.genome.fa /project/pengjx/rawdata/Genome/绿豆基因组测序HIC原始数据/HIC/raw/RHC01185_L5_2.fq.gz 2>>L5_R2.log | samtools view -Shb - > L5_R2.bam

#samtools merge mate_R1.bam L4_R1.bam L5_R1.bam
#samtools merge mate_R2.bam L4_R2.bam L5_R2.bam

#hicFindRestSite --fasta /project/fujun/01.assembly/05.latest_ref/bwa_index/vigna_radiata.genome.fa --searchPattern GATC -o rest_site_positions.bed

#hicBuildMatrix --samFiles L4_R1.bam L4_R2.bam --binSize 10000 --restrictionSequence GATC --danglingSequence GATC --restrictionCutFile rest_site_positions.bed --threads 16 --inputBufferSize 100000 --outBam hic.L4.bam -o L4_matrix.h5 --QCfolder ./hicQC
#hicBuildMatrix --samFiles L5_R1.bam L5_R2.bam --binSize 10000 --restrictionSequence GATC --danglingSequence GATC --restrictionCutFile rest_site_positions.bed --threads 16 --inputBufferSize 100000 --outBam hic.L5.bam -o L5_matrix.h5 --QCfolder ./hicQC
#hicSumMatrices --matrices L4_matrix.h5 L5_matrix.h5 --outFileName hic_matrix.h5


#hicMergeMatrixBins --matrix hic_matrix.h5 --outFileName hic_matrix.nb5.h5 -nb 5 &
#hicMergeMatrixBins --matrix hic_matrix.h5 --outFileName hic_matrix.nb10.h5 -nb 10 &
#wait

#hicCorrectMatrix diagnostic_plot -m hic_matrix.nb10.h5 -o hic_matrix.nb10.h5.png

#hicCorrectMatrix correct -m hic_matrix.h5 --filterThreshold -1.2 3 -o hic_corrected.h5 &
#hicCorrectMatrix correct -m hic_matrix.nb5.h5 --filterThreshold -1.2 3 -o hic_corrected.nb5.h5 &
#hicCorrectMatrix correct -m hic_matrix.nb10.h5 --filterThreshold -1.2 3 -o hic_corrected.nb10.h5 &
#wait

#hicPlotMatrix -m hic_corrected.nb5.h5 -o hicPlotMatrix.png --log1p --clearMaskedBins --chromosomeOrder 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 

#hicPlotMatrix -m hic_corrected.nb10.h5 -o hicPlotMatrix.nb10.png --clearMaskedBins --chromosomeOrder 1 2 3 4 5 6 7 8 9 10 11 --log1p --vMin 100 --dpi 300 -s "Interaction intensity" --fontsize 11
hicPlotMatrix -m hic_corrected.nb10.h5 -o hicPlotMatrix.nb10.png --chromosomeOrder 1 2 3 4 5 6 7 8 9 10 11 --log1p --vMin 10 --vMax 10000 --dpi 300 -s "Interaction intensity" --fontsize 11
#hicPlotMatrix -m hic_corrected.h5 -o hicPlotMatrix.png --clearMaskedBins --chromosomeOrder 1 2 3 4 5 6 7 8 9 10 11 --log1p --vMin 10 --dpi 300 -s "Interaction intensity" --fontsize 11
