#conda activate jcvi
grep '^chr' /project/pengjx/mungbean/00.genome/VC1973A_v2/Vradi.pacbio.gapfilled.final.all.gff >VC1973A_v2_chr11.gff3

python -m jcvi.formats.gff bed --type=mRNA --key=ID VC1973A_v2_chr11.gff3 -o VC1973A_v2.bed

python -m jcvi.formats.fasta format /project/pengjx/mungbean/00.genome/VC1973A_v2/Vradi.pacbio.gapfilled.final.all.maker.proteins.fasta VC1973A_v2.pep
python -m jcvi.compara.catalog ortholog Vrad_JL7 VC1973A_v2 --no_strip_names --dbtype=prot
python -m jcvi.graphics.dotplot Vrad_JL7.VC1973A_v2.anchors
python -m jcvi.compara.synteny screen --minspan=30 --simple Vrad_JL7.VC1973A_v2.anchors Vrad_JL7.VC1973A_v2.anchors.new
vi seqid
vi layout
python -m jcvi.graphics.karyotype seqid layout

mv karyotype.pdf Vrad_JL7.VC1973A_v2.synteny.pdf
