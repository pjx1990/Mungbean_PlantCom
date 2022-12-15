gmap_build -D ./ -d Vrad_JL7 /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa
gmap -D ./ -t 30 -d Vrad_JL7 -S /project/pengjx/mungbean/00.genome/Glymax_Wm82.a2.v1/annotation/Gmax_275_Wm82.a2.v1.cds.fa >JL7-Gmax_gmap.out
gmap -D ./ -t 30 -d Vrad_JL7 -f gff3_gene /project/pengjx/mungbean/00.genome/Glymax_Wm82.a2.v1/annotation/Gmax_275_Wm82.a2.v1.cds.fa >JL7-Gmax_gmap.gff3
