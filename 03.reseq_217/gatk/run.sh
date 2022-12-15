#nohup sh bwaGvcf.sh lz-100 /project/fujun/02.pan/ref/lz-100_H33W2DMXX_L1_1.clean.fq.gz /project/fujun/02.pan/ref/lz-100_H33W2DMXX_L1_2.clean.fq.gz >g100.log &
##sh test.sh lz-100 /project/fujun/02.pan/ref/lz-100_H33W2DMXX_L1_1.clean.fq.gz /project/fujun/02.pan/ref/lz-100_H33W2DMXX_L1_2.clean.fq.gz
#nohup sh bwaGvcf.sh lz-101  /project/fujun/02.pan/ref/lz-101_H33W2DMXX_L1_1.clean.fq.gz     /project/fujun/02.pan/ref/lz-101_H33W2DMXX_L1_2.clean.fq.gz >g101.log &
#nohup sh bwaGvcf.sh lz-102  /project/fujun/02.pan/ref/lz-102_H33W2DMXX_L1_1.clean.fq.gz     /project/fujun/02.pan/ref/lz-102_H33W2DMXX_L1_2.clean.fq.gz >g102.log &


cat sample.info |sed -n '173'p |while read sample r1 r2;do
#echo $sample $r1 $r2
#echo "nohup sh bwaGvcf.sh $sample $r1 $r2 >$sample.log &"
nohup sh bwaGvcf.sh $sample $r1 $r2 >$sample.log &
done
