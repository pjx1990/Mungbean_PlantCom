#./KMC3/kmc -k31 -t16 -m64 -ci1 -cs10000 @fq.lst reads tmp/
./KMC3/kmc_tools transform reads histogram reads.histo -cx10000
/data/software/miniconda2/envs/genomescope2/bin/genomescope2 -i reads.histo -o ./ -k 31

