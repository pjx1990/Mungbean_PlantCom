/data/software/soft/bcftools/bcftools merge -m id -Ob -o merged.bcf ../03.call/lz-*.bcf
delly filter -f germline -o germline.bcf merged.bcf
