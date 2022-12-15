#java -jar beagle.21Apr21.304.jar gt=meanDP3.miss0.5.maf0.01.vcf.recode.vcf out=meanDP3.miss0.5.maf0.01.impute
#java -jar beagle.21Apr21.304.jar gt=meanDP3.miss0.5.maf0.01.vcf.recode.vcf out=meanDP3.miss0.5.maf0.01.impute.ne750 ne=750
#zcat meanDP3.miss0.5.maf0.01.impute.ne750.vcf.gz |sed '9s/_/-/g' >meanDP3.miss0.5.maf0.01.impute.ne750.rename.vcf
java -jar beagle.21Apr21.304.jar gt=meanDP3.miss0.6.maf0.01.recode.vcf out=meanDP3.miss0.6.maf0.01.impute.ne750 ne=750
zcat meanDP3.miss0.6.maf0.01.impute.ne750.vcf.gz |sed '9s/_/-/g' >meanDP3.miss0.6.maf0.01.impute.ne750.rename.vcf
java -jar beagle.21Apr21.304.jar gt=meanDP3.miss0.6.maf0.01.recode.vcf out=meanDP3.miss0.6.maf0.01.impute
zcat meanDP3.miss0.6.maf0.01.impute.vcf.gz |sed '9s/_/-/g' >meanDP3.miss0.6.maf0.01.impute.rename.vcf
