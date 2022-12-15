#!/usr/bin/env python

for line in open('pav.tsv'):
    if line.startswith('Sam'):
        continue
    info = line.strip().split()
    print '%s\t%s' % (info[0], sum(map(int, info[1:])))
