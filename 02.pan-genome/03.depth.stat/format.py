import glob

for fn in glob.glob('*.mosdepth.summary.txt'):
    sn = fn.split('.')[0]
    print '%s\t%s' % (sn, open(fn).read().split('\n')[-2].split('\t')[3])

