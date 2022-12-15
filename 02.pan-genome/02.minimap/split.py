import sys
import re

fin = sys.argv[1]
fout = open(sys.argv[1].replace('.fa', '.no.fa'), 'w')

seq = ''
count = 1
for line in open(fin):
    if line.startswith('>'):
        for each in re.split('N+', seq):
            if len(each) >= 500:
                fout.write('>contig%s\n' % count)
                fout.write(each + '\n')
                seq = ''
                count += 1
    else:
        seq += line.strip()
