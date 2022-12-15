cat final.gff3 /project/fujun/01.assembly/05.latest_ref/pan_anno/support_utr.gff3 >all.gff3
awk '{if($3=="gene")print $9"\t"$4"\t"$5}' all.gff3 |sed 's/ID=\(.*\);/\1/g' >gff_gene_pos.txt
