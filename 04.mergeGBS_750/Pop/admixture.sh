sed 's/scaffold_//g' ../snp.vcf >snp4pop.vcf
plink --vcf snp4pop.vcf --recode --out snp --double-id -allow-extra-chr
plink --file snp  --make-bed --out snp --double-id --allow-extra-chr

#for K in {2..10};do
#echo $K
##2 3 4 5 6 7 8 9 10分成的群体结构数 hapmap3.bed 输入文件
#admixture --cv snp.bed $K | tee log${K}.out;
##admixture --cv snp $K | tee log${K}.out;
#done
#for K in {11..15};do
for K in {2..25};do
echo $K
admixture --cv snp.bed $K | tee log${K}.out;
done
grep -h 'CV'  log*.out >CV.log

