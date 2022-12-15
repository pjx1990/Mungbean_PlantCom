count = 2

for line in open('sample.info'):
    info = line.strip().split()
    if info[0] in ['lz-100', 'lz-116']:
        continue
    count += 1
    print 'python create.py %s %s' % (count, info[0])
