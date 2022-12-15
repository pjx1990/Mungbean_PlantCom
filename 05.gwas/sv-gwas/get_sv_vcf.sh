~/miniconda3/envs/bcftools/bin/bcftools view -f PASS /project/fujun/02.pan/06.delly/04.merge/germline.vcf >sv.vcf
sed 's/\(.*\);SVLEN=\(.*\);PE\(.*\)/\2/g' ins.vcf |sort -n >insertion.len


conda activate bcftools
bcftools view -R sig_sv.list canno_transcript/sv.anno.vcf.gz >sig_sv.anno.vcf
grep -v '^##' sig_sv.anno.vcf |cut -f 1,2,4-5,8 |sed 's/\(PRECISE.*\);\(ANN=.*\)/\2/g' >sig_sv.anno.txt
