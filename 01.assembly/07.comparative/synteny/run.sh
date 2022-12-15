#!/bin/bash
query=../vigna_radiata.genome.fa
target=/project/pengjx/mungbean/00.genome/Novogene/novogene-genome.fa
outname="our_novogene_minimap2.paf"
#minimap2 -x asm5 -t 24 $target $query > ${outname}

/project/pengjx/biosoft/dotPlotly-master/pafCoordsDotPlotly.R -i ${outname} -o ${outname} -m 2000 -s -t -l
