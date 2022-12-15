 sed 's/\.[0-9] \(.*\)//g' /project/pengjx/mungbean/00.genome/Glymax_Wm82.a2.v1/annotation/Gmax_275_Wm82.a2.v1.cds.fa >gmax.cds.fa
 seqtk subseq gmax.cds.fa gene.lst >gene.fa
 grep -c '>' gene.fa
 blat /project/pengjx/mungbean/00.genome/final.cds.fa gene.fa -out=blast8 gmax2vard.out
 cut -f 1-2 gmax2vard.out  |sort -u >gmax2vrad.gene
cut -f 2 gmax2vard.out |sort -u>vrad.gene
