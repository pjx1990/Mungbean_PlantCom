#gmap_build -D ./ -d Vrad_JL7 /project/pengjx/mungbean/00.genome/vigna_radiata.genome.fa
#gmap -D ./ -t 30 -d Vrad_JL7 -S /project/pengjx/mungbean/00.genome/2014NC/Vigna_radiata.Vradiata_ver6.cds.all.fa >JL7-VC1973Av1_gmap.out
gmap -D ./ -t 30 -d Vrad_JL7 -f gff3_gene /project/pengjx/mungbean/00.genome/2014NC/Vigna_radiata.Vradiata_ver6.cds.all.fa >JL7-VC1973Av1_gmap.gff3
gmap -D ./ -t 30 -d Vrad_JL7 -f gff3_gene --max-intronlength-middle=100000 /project/pengjx/mungbean/00.genome/2014NC/Vigna_radiata.Vradiata_ver6.cds.all.fa >JL7-VC1973Av1_gmap2.gff3
