#!/usr/bin/env python

for line in open('../05.latest_ref/vigna_radiata.genome.fa'):
    if line.startswith('>'):
        chrn = line.strip()[1:]
        count = 0
    else:
        for bs in line.strip():
            if bs in ['N', 'n']:
                print '%s\t%s\t%s' % (chrn, count, count + 1)
            count += 1
