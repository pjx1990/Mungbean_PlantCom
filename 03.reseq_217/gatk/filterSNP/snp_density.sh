#grep -v "^scaffold" ../win50s5r0.5.ld_filter.vcf >snp_nosaffold_test.vcf
#Rscript snp.density.map.R -i snp_nosaffold_test.vcf -n out -s 1000000 -c "grey,orangered,red"  -n "test"
Rscript snp.density.map.R -i snp_nosaffold_test.vcf -n out -s 500000 -c "grey,red"  -n "test"
