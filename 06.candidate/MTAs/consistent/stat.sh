ls *.csv |while read i;do cut -d, -f 6 $i |sed '1d'|sort -u >>all;done
wc -l all
sort -u all |wc -l
