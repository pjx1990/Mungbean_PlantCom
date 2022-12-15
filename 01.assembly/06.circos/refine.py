#!/usr/bin/env python

for line1, line2 in zip(open('gc.win.xls'), open('n.win.xls')):
    info1 = line1.strip().split()
    info2 = line2.strip().split()
    print '%s\t%s\t%s\t%.2f' % (info1[0], info1[1], info1[2], 100 * float(info1[3]) / (int(info1[2]) - int(info1[1]) - int(info2[3])))
