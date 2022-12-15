conda activate jcvi
grep -v '^scaffold' /project/pengjx/mungbean/00.genome/2014NC/Vigna_radiata.Vradiata_ver6.50.gff3 >VC1973A_v1_chr11.gff3
python -m jcvi.formats.gff bed --type=mRNA --key=ID VC1973A_v1_chr11.gff3 -o VC1973A_v1.bed
sed -i 's/transcript://g' VC1973A_v1.bed

cp /project/pengjx/mungbean/05.candicate_gene/mapping_to_Gmax_Wm_v2/synteny/Vrad_JL7.bed .


python -m jcvi.formats.fasta format /project/pengjx/mungbean/00.genome/final.protein.fa Vrad_JL7.pep
python -m jcvi.formats.fasta format /project/pengjx/mungbean/00.genome/2014NC/Vigna_radiata.Vradiata_ver6.pep.all.fa VC1973A_v1.pep
python -m jcvi.compara.catalog ortholog Vrad_JL7 VC1973A_v1 --no_strip_names --dbtype=prot
python -m jcvi.graphics.dotplot Vrad_JL7.VC1973A_v1.anchors
python -m jcvi.compara.synteny screen --minspan=30 --simple Vrad_JL7.VC1973A_v1.anchors Vrad_JL7.VC1973A_v1.anchors.new
vi seqid
vi layout
python -m jcvi.graphics.karyotype seqid layout
