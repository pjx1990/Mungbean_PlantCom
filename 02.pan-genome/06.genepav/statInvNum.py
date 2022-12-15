panidx = []
refidx = []

for line in open('pav.tsv'):
    info = line.strip().split()
    if line.startswith('Sample'):
        for idx, each in enumerate(info[1:]):
            if each.startswith('P'):
                panidx.append(idx)
            else:
                refidx.append(idx)
        print 'Sample\tRef\tPan'
    else:
        pannum = sum([int(info[i + 1]) for i in panidx])
        refnum = sum([int(info[i + 1]) for i in refidx])
        print '%s\t%s\t%s' % (info[0], refnum, pannum)
