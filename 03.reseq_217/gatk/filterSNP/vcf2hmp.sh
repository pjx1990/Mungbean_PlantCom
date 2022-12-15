/project/pengjx/biosoft/tassel-5-standalone/run_pipeline.pl -Xms10g -Xmx100g  -vcf win10s1r0.5.ld_filter.vcf -sortPositions -export out.hmp.txt -exportType HapmapDiploid
cut -f 1-126,134,145-228 out.hmp.txt >200_phe.hmp.txt
