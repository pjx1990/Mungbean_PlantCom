cut -f 1,3,12 /project/pengjx/mungbean/03.gwas/gemma/filtersnp/Raw_phenotype/output/CSC_2018SJZ_summer.assoc.txt |awk '{if($1=="7") print $0}' >jg24043.gwas.pvalue
#cut -f 1,3,12 /project/pengjx/mungbean/03.gwas/gemma/filtersnp/Raw_phenotype/output/CPC_2018SJZ_summer.assoc.txt |awk '{if($1=="7") print $0}' >gwas.pvalue
/project/pengjx/biosoft/LDBlockShow/bin/LDBlockShow -InVCF ../../allsnp.vcf -OutPut CSC_CPC_Manha -Region 7:55978873:56811756 -OutPng -SeleVar 2 -InGWAS jg24043.gwas.pvalue -Cutline 6.5 -InGFF /project/pengjx/mungbean/00.genome/final.gff3


/project/pengjx/biosoft/LDBlockShow/bin/ShowLDSVG  -InPreFix CSC_CPC_Manha -OutPut label.svg -InGWAS jg24043.gwas.pvalue  -Cutline  6.5  -InGFF  /project/pengjx/mungbean/00.genome/final.gff3  -OutPng  -SpeSNPName STA  -ShowGWASSpeSNP
