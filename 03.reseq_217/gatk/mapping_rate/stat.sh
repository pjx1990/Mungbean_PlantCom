for i in `seq 1 219`;do
echo $i
grep "mapped (" lz-${i}.flagstat >>mapping_rate.xls
done
