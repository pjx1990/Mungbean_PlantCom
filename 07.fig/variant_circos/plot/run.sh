perl g_karyotype.pl /data/biouser1/SOYBEAN/genomes/Glycine_max.Glycine_max_v2.0.chr.fa.fai >karyotype.txt
grep 'protein_coding' /data/biouser1/SOYBEAN/genomes/Glycine_max.Glycine_max_v2.0.40.chr.gtf|awk '{if($3=="exon"){print $0}}'|perl  /storage/PUBLIC/pipeline/RNAseq/MYscripts/oldDell/bin/gff2gtf/gtf2bed.pl - gene.bed
cut -f 4 gene.bed >gene.bed.1
cut -f 1,6 gene.bed >gene.bed.2
cut -f 2,3 gene.bed >gene.bed.3
paste gene.bed.1 gene.bed.2 gene.bed.3 >gene.bed.input
rm gene.bed.?
perl g_gene_density.pl  karyotype.txt gene.bed.input >gene_density.txt
awk '{print $1"\t"$4"\t"$4"\t1"}' ../../03.imputation/soybean.hapmap.map >snp.input
perl g_snp_density.pl karyotype.txt snp.input >snp.txt
cat ../../02.annovar/*.indel.anno.bed | grep -v 'Chr' | awk '{print $1"\t"$2"\t"$3"\t1"}' > indel.input
perl g_snp_density.pl karyotype.txt indel.input >indel.txt

awk '{a=$2+10000;print $1"\t"$2"\t"a"\t"$3}' ../../05.diversity/splitWinPi/CvsL.Windows.FST >C.pi.input
perl g_gc_density.pl karyotype.txt C.pi.input >C.pi.txt
awk '{a=$2+10000;print $1"\t"$2"\t"a"\t"$4}' ../../05.diversity/splitWinPi/CvsL.Windows.FST >L.pi.input 
perl g_gc_density.pl karyotype.txt L.pi.input >L.pi.txt
awk '{a=$2+10000;print $1"\t"$2"\t"a"\t"$5}' ../../05.diversity/splitWinPi/CvsL.Windows.FST >Fst.input
grep -v NA Fst.input|perl g_gc_density.pl karyotype.txt - >Fst.txt
awk '{a=$2+10000;print $1"\t"$2"\t"a"\t"$3}' ../../05.diversity/All.Windows.PI >tajimaD.input
grep -v NA tajimaD.input|perl g_gc_density.pl karyotype.txt - >tajimaD.txt
awk '{a=$2+10000;print $1"\t"$2"\t"a"\t"$9}' ../../05.diversity/All.Windows.PI >Gm.pi.input
perl g_gc_density.pl karyotype.txt Gm.pi.input >Gm.pi.txt
sed 's/ /\t/g' ../../06.LD/plink.ld|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/^\t//'|sed '1d'|cut -f 1,2,5,7 >ld.input
perl g_gc_density.pl karyotype.txt ld.input >ld.txt
sed 's/ /\t/g' ../../06.LD/cultivar/plink.ld|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/^\t//'|sed '1d'|cut -f 1,2,5,7 >C.ld.input
perl g_gc_density.pl karyotype.txt C.ld.input >C.ld.txt
sed 's/ /\t/g' ../../06.LD/landrace/plink.ld|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/\t\t/\t/g'|sed 's/^\t//'|sed '1d'|cut -f 1,2,5,7 >L.ld.input
perl g_gc_density.pl karyotype.txt L.ld.input >L.ld.txt
awk '{print $2"\t"$3"\t"$4}' ../ROH.merge.tsv >ROH.txt
awk '{print $1"\t"$2"\t"$3}' ../../05.diversity/select.regions.merge2 >select.txt
awk '{print $1"\t"$2"\t"$3}' ../../05.diversity/splitWinPi/Fst.select.regions.merge2 >select2.txt

