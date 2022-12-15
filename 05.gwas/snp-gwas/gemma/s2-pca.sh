#cut -f 58 ../phe_order.txt |sed '1d' >p.txt
plink --bfile test --pca 50 --out pca --allow-extra-chr
twstats -t twtable -i pca.eigenval -o pca_number
Rscript pc.R #PC10

Rscript phe.R
