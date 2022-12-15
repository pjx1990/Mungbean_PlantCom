plink --vcf DP5miss09.recode.vcf.gz --recode --allow-extra-chr --double-id --out test
plink --file test --make-bed --recode --allow-extra-chr --double-id --out test
#mv test.fam test.fam.bak
#Rscript fix_fam.R BR_phe.txt test.fam.bak
