plink --bfile test --pca 50 --out pca --allow-extra-chr
twstats -t twtable -i pca.eigenval -o pca_number
Rscript pc.R #PC3

#Rscript phe.R
