#!/usr/bin/env python
# -*- coding: utf-8 -*-
import glob

fls = glob.glob('/media/绿豆重测序数据/原始数据/*gz')

for fl in fls:
    fl = '/project/fujun/02.pan/ref/' + fl.split('/')[-1]
    if fl.endswith('_1.fq.gz'):
        sn = fl.split('/')[-1].split('_')[0]
        fq2 = fl.replace('_1.fq.gz', '_2.fq.gz')
        print '%s\t%s\t%s' % (sn, fl, fq2)
    elif fl.endswith('_1.clean.fq.gz'):
        sn = fl.split('/')[-1].split('_')[0]
        fq2 = fl.replace('_1.clean.fq.gz', '_2.clean.fq.gz')
        print '%s\t%s\t%s' % (sn, fl, fq2)
