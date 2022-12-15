#/project/pengjx/biosoft/PopLDdecay-master/bin/PopLDdecay -InVCF  impute_snp.vcf  -OutStat LDdecay -MaxDist 600 -MAF 0.05 -Het 0.9 -Miss 0.2 -OutFilterSNP#perl  /project/pengjx/biosoft/PopLDdecay-master/bin/Plot_OnePop.pl  -inFile   LDdecay.stat.gz  -output  Fig -bin1 100 -break 100 -bin2 15000 -maxX 600
#sed '9s/_/-/g' impute_snp.vcf >snp.vcf
#cut -f 1-2 allsample2.txt |sed '1d' |sed 's/_/-/g' >type.list

#cut -f 1-2 /project/pengjx/mungbean/sample/allsample_sort.txt >type.list
#awk '{if($2=="Landrace")print $1}' type.list >Landrace.list
#awk '{if($2=="Wild")print $1}' type.list >Wild.list
#awk '{if($2=="Cultivar")print $1}' type.list >Cultivar.list
/project/pengjx/biosoft/PopLDdecay-master/bin/PopLDdecay -InVCF  snp.vcf -OutStat Landrace.stat.gz -SubPop Landrace.list -MaxDist 600
/project/pengjx/biosoft/PopLDdecay-master/bin/PopLDdecay -InVCF  snp.vcf -OutStat Cultivar.stat.gz -SubPop Cultivar.list -MaxDist 600
#/project/pengjx/biosoft/PopLDdecay-master/bin/PopLDdecay -InVCF  snp.vcf -OutStat Wild.stat.gz -SubPop Wild.list -MaxDist 600
#/project/pengjx/biosoft/PopLDdecay-master/bin/PopLDdecay -InVCF  snp.vcf -OutStat Wild.stat.gz -SubPop only_aborad_wild.list -MaxDist 600
#perl /project/pengjx/biosoft/PopLDdecay-master/bin/Plot_MultiPop.pl -inList multi.list -output Type -bin1 100 -break 100 -bin2 15000
perl /project/pengjx/biosoft/PopLDdecay-master/bin/Plot_MultiPop.pl -inList land-cul.list -output landrace-cultivar -bin1 100 -break 100 -bin2 30000
