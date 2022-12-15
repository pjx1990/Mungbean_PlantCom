#cat /project/fujun/01.assembly/05.latest_ref/anno/exon.bed /project/fujun/01.assembly/06.anno/pan/braker/exon.bed > all.exon.bed
ls *.rmdup.bam|while read a;do b=${a/.rmdup.bam/}; echo /data/software/bin/mosdepth --by all.exon.bed --thresholds 1,2,4,10 -n $b $a >> split.sh;done

