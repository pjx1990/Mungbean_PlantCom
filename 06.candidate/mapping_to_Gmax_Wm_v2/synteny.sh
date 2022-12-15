#only keep chromosome
#grep -v '^scaffold' vigna_radiata.gff3 >Vrad_JL7_chr11.gff3
#grep -v '^scaffold' Gmax_275_Wm82.a2.v1.gene.gff3 >Gmax_Wm82_chr20.gff3

#gff convert to bed
#python -m jcvi.formats.gff bed --type=mRNA --key=Name Vrad_JL7_chr11.gff3 -o Vrad_JL7.bed
#python -m jcvi.formats.gff bed --type=mRNA --key=Name Gmax_Wm82_chr20.gff3 -o Gmax_Wm82.bed
python -m jcvi.formats.gff bed --type=mRNA --key=ID Vrad_JL7_chr11.gff3 -o Vrad_JL7.bed
#sed -i 's/^/Chr/g' Vrad_JL7.bed
#sed -i 's/Chr1$/Chr01/;s/Chr2/Chr02/;s/Chr3/Chr03/;s/Chr4/Chr04/;s/Chr5/Chr05/;s/Chr6/Chr06/;s/Chr7/Chr07/;s/Chr8/Chr08/;s/Chr9/Chr09/' Vrad_JL7.bed
python -m jcvi.formats.gff bed --type=mRNA --key=Name Gmax_Wm82_chr20.gff3 -o Gmax_Wm82.bed

#reformat fasta
python -m jcvi.formats.fasta format /project/pengjx/mungbean/00.genome/final.cds.fa Vrad_JL7.cds
python -m jcvi.formats.fasta format /project/pengjx/mungbean/00.genome/Glymax_Wm82.a2.v1/annotation/Gmax_275_Wm82.a2.v1.cds.fa.gz Gmax_Wm82.cds

#identify blocks
python -m jcvi.compara.catalog ortholog Vrad_JL7 Gmax_Wm82 --no_strip_names


#plot dotplot
python -m jcvi.graphics.dotplot Vrad_JL7.Gmax_Wm82.anchors

#plot synteny
python -m jcvi.compara.synteny screen --minspan=30 --simple Vrad_JL7.Gmax_Wm82.anchors Vrad_JL7.Gmax_Wm82.anchors.new

##prepare for seqid and layout file

# run plot
python -m jcvi.graphics.karyotype seqid layout
