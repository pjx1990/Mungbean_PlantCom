## 需要注释位点，增加ID列
#bcftools annotate --set-id +'%CHROM\_%POS\_%REF\_%FIRST_ALT' snps_popfilter.recode.vcf -Oz -o snp_tmp_anno.vcf.gz
## --indep-pairwise 窗口大小 步长 R2筛选位点
plink --vcf snp_tmp_anno.vcf.gz --const-fid --allow-extra-chr --indep-pairwise 50 10 0.2 --out ld_filter
plink --allow-extra-chr --extract ld_filter.prune.in --make-bed --out ld_filter --recode vcf-iid --vcf snp_tmp_anno.vcf.gz
