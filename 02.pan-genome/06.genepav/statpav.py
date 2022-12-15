import glob
import gzip

fls = glob.glob('/project/fujun/02.pan/04.bwa/bwa/*.thresholds.bed.gz')

pavdic = {}
genelist = [i.strip() for i in open('gene.lst')]

for fl in fls:
    sn = fl.split('/')[-1].replace('.thresholds.bed.gz', '')
    pavdic[sn] = {}
    for line in gzip.open(fl):
        if line.startswith('#'):
            continue
        info = line.split()
        totallen = int(info[2]) - int(info[1])
        len2x = int(info[5])
        if info[3] not in pavdic[sn]:
            pavdic[sn][info[3]] = [totallen, len2x]
        else:
            pavdic[sn][info[3]][0] += totallen
            pavdic[sn][info[3]][1] += len2x

print 'Sample\t' + '\t'.join(genelist)

for sn in sorted(pavdic.keys()):
    outl = [sn]
    for gn in genelist:
        ratio = float(pavdic[sn][gn][1]) / pavdic[sn][gn][0]
        if ratio >= 0.2:
            outl.append('1')
        else:
            outl.append('0')
    print '\t'.join(outl)
