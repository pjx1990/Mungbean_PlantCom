import os
import sys
import time

worktemp = """#!/bin/sh
masurca config.sh
./assemble.sh
"""
count = sys.argv[1]
sample = sys.argv[2]


count = int(sys.argv[1])
tmp = '/project/fujun/02.pan/01.assembly/config.sh'

wkd = '%02d.%s/insertsize' % (count, sample)
os.makedirs(wkd)
os.chdir(wkd)
fh = open('../config.sh', 'w')
for line in open(tmp):
    if line.startswith('PE'):
        idx = -1
        for line in open('../../sample.info'):
            info = line.strip().split()
            if info[0] != sample:
                continue
            idx += 1
            print('sh /project/fujun/02.pan/01.assembly/insert.sh %s %s' % (info[1], info[2]))
            os.system('sh /project/fujun/02.pan/01.assembly/insert.sh %s %s' % (info[1], info[2]))
            while not os.path.exists('insert_size_metrics.txt'):
                time.sleep(5)
            flag = 0
            for line in open('insert_size_metrics.txt'):
                if line.startswith('MEDIAN_INSERT_SIZE'):
                    flag = 1
                elif flag == 1:
                    insize = line.split()[0]
                    indev = line.split()[1]
                    flag = 0
            fh.write('PE= p%s %s %s %s %s\n' % (idx, insize, indev, info[1], info[2]))
            os.rename('insert_size_metrics.txt', 'insert_size_metrics%s.txt' % idx)
    else:
        fh.write(line)
fh.close()
os.chdir('../')
fh = open('work.sh', 'w')
fh.write(worktemp)
fh.close()
os.system('sh work.sh 2>&1 > log.txt')
