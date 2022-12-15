vcftools --gzvcf ../DP5miss09.recode.vcf.gz --weir-fst-pop ../NonChina.lst --weir-fst-pop ../Landrace.lst --out NonChina_Landrace --fst-window-size 10000
vcftools --gzvcf ../DP5miss09.recode.vcf.gz --weir-fst-pop ../NonChina.lst --weir-fst-pop ../Cultivar.lst --out NonChina_Cultivar --fst-window-size 10000
vcftools --gzvcf ../DP5miss09.recode.vcf.gz --weir-fst-pop ../Cultivar.lst --weir-fst-pop ../Landrace.lst --out Cultivar_Landrace --fst-window-size 10000
