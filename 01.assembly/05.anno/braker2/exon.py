import re

for line in open('final.gtf'):
    info = line.strip().split()
    if info[2] == 'CDS':
        gn = re.search(r'gene_id "(\S+)"', line).group(1)
        print '%s\t%s\t%s\t%s' % (info[0], int(info[3]) - 1, info[4], gn)
