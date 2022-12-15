## 需要注释位点，增加ID列
#bcftools annotate --set-id +'%CHROM\_%POS\_%REF\_%FIRST_ALT' snps_popfilter.recode.vcf -Oz -o snp_tmp_anno.vcf.gz
## --indep-pairwise 窗口大小 步长 R2筛选位点
#plink --vcf DP5miss09.recode.vcf.gz --const-fid --allow-extra-chr --indep-pairwise 50 5 0.5 --out win50s5r0.5.ld_filter
#plink --allow-extra-chr --extract win50s5r0.5.ld_filter.prune.in --make-bed --out win50s5r0.5.ld_filter --recode vcf-iid --vcf DP5miss09.recode.vcf.gz

plink --vcf DP5miss09.recode.vcf.gz --const-fid --allow-extra-chr --indep-pairwise 10 1 0.5 --out win10s1r0.5.ld_filter
plink --allow-extra-chr --extract win10s1r0.5.ld_filter.prune.in --make-bed --out win10s1r0.5.ld_filter --recode vcf-iid --vcf DP5miss09.recode.vcf.gz
