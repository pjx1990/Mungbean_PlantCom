#plink --vcf pav_gene.vcf --recode --allow-extra-chr --double-id --out test
plink --vcf pav_gene_remove_novariant.vcf --recode --allow-extra-chr --double-id --out test
plink --file test --make-bed --recode --allow-extra-chr --double-id --out test
