plink --vcf snp.vcf --recode --out snp --double-id -allow-extra-chr
plink --file snp  --make-bed --out snp --double-id --allow-extra-chr
plink --threads 8 --bfile snp --pca 10 --out pca --allow-extra-chr
twstats -t twtable -i pca.eigenval -o eigenvaltw.out
