#cat cloud.lst shell.lst |grep 'jg' |sort -u >variable_jg_gene.lst
cat cloud.lst shell.lst  |sort -u >variable_gene.lst

cat final.gff3 pan.gff3 >all.gff3
awk '{if($3=="gene")print $9"\t"$1"\t"$4"\t"$5}' all.gff3 |sed 's/ID=\(.*\);/\1/g' >all_gene_pos.txt
awk 'NR==FNR {a[$1]=$0;next}{if($1 in a)print a[$1]}' all_gene_pos.txt variable_gene.lst >variable_gene_pos.txt


awk 'NR==FNR {a[$1]=$0;next}{if($1 in a)print a[$1]}' all_gene_pos.txt cloud.lst >cloud_gene_pos.txt
awk 'NR==FNR {a[$1]=$0;next}{if($1 in a)print a[$1]}' all_gene_pos.txt shell.lst >shell_gene_pos.txt
awk 'NR==FNR {a[$1]=$0;next}{if($1 in a)print a[$1]}' all_gene_pos.txt hardCore.lst >hardCore_gene_pos.txt
awk 'NR==FNR {a[$1]=$0;next}{if($1 in a)print a[$1]}' all_gene_pos.txt softCore.lst >softCore_gene_pos.txt
cat hardCore.lst softCore.lst >Core.lst
awk 'NR==FNR {a[$1]=$0;next}{if($1 in a)print a[$1]}' all_gene_pos.txt Core.lst >Core_gene_pos.txt
