for i in `ls phenotype/*.txt`;do
phe=`basename $i |sed 's/.txt//'`
echo $phe
echo "/project/pengjx/biosoft/gemma-0.98.3-linux-static -bfile test -gk 2 -p $i -o $phe" >>run_${phe}.sh
echo "/project/pengjx/biosoft/gemma-0.98.3-linux-static -bfile test -k output/${phe}.sXX.txt -lmm 1 -p $i -c c.txt -o $phe">>run_${phe}.sh
done

#Rscript gwas_plot.R
