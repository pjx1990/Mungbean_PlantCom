#!/usr/bin/env python
# -*- coding: utf-8 -*-

#import ConfigParser
import configparser as ConfigParser
import os
from collections import defaultdict
import argparse
import re
import sys


def ArgParse():
    parser = argparse.ArgumentParser()
    help = 'vcf or plink ped file. prefix only if ped format file used.'
    parser.add_argument('--geno', required=True, help=help)
    help = 'output directory. [current path]'
    parser.add_argument('--outdir', default=os.getcwd(), help=help)
    help = 'population information.[unkown]'
    parser.add_argument('--pop', default='', help=help)
    args = parser.parse_args()
    return args


def ParseAppConfig():
    Spath = os.path.split(os.path.realpath(__file__))[0]
    cf = ConfigParser.ConfigParser()
    cf.read("%s/AppCfg.ini" % (Spath))
    return cf


def vcf2plinkped(cf, geno, outdir, outpre):
    out = outdir + '/' + outpre
    xx = os.system('%s --vcf %s --double-id --make-bed --mind 0.5 --allow-extra-chr --out %s'
                   % (cf.get('app', 'Plink'), geno, out))
    if xx != 0:
        sys.exit(111)

    xx = os.system('%s --bfile %s --allow-extra-chr --recode --out %s'
                   % (cf.get('app', 'Plink'), out, out))
    if xx != 0:
        sys.exit(111)


cf = ParseAppConfig()
args = ArgParse()
outdir = os.path.abspath(args.outdir)

smartpca = cf.get('app', 'smartpca')
rscript = cf.get('app', 'rscript')

parfile = outdir + '/smartpca.par'
pcalog = outdir + '/pca.log'
vec = outdir + '/pca.vec'
val = outdir + '/pca.val'

popinfo = args.pop
popdict = defaultdict(lambda: 'unassigned')

chrdict = {}


if os.path.isfile(popinfo):
    for line in open(popinfo):
        info = line.strip().split('\t')
        popdict[info[1]] = info[0]

cpdic = {}
if os.path.isfile(args.geno + '.cp'):
    for line in open(args.geno + '.cp'):
        info = line.strip().split('\t')
        cpdic[info[1]] = info[0]

if re.search(r'\.vcf$', args.geno):
    vcf2plinkped(cf, args.geno, outdir, 'plink')
    args.geno = args.outdir + '/plink'
else:
    os.system('ln -s %s %s' % (args.geno + '.ped', outdir + '/plink.ped'))


pedind = open(outdir + '/plink.pedind', 'w')
pedsnp = open(outdir + '/plink.pedsnp', 'w')

for line in open(args.geno + '.ped'):
    info = line.split()[0:6]
    info[0] = 'pop'
    info[5] = 'pop'
    pedind.write('\t'.join(info) + '\n')

count = 1
for line in open(args.geno + '.map'):
    info = line.split()
    if info[0] not in chrdict:
        chrdict[info[0]] = str(count)
        count += 1
    info[0] = chrdict[info[0]]
    info[1] = info[0] + ':' + info[3].strip()
    pedsnp.write('\t'.join(info) + '\n')

pedind.close()
pedsnp.close()


ss = '''
genotypename:   plink.ped
snpname:        plink.pedsnp
indivname:      plink.pedind
evecoutname:    pca.vec
evaloutname:    pca.val
numoutlieriter: 0
numchrom:       1000000
'''
ss = ss.strip('\n')
fh = open(parfile, 'w')
fh.write(ss)
fh.close()

pcaplot = os.path.split(os.path.realpath(__file__))[0] + '/pca_plot.R'

mycwd = os.getcwd()
os.chdir(outdir)
os.system('%s -p %s > %s' % (smartpca, 'smartpca.par', 'pca.log'))
os.chdir(mycwd)

pcsfile = outdir + '/pcs.txt'
fh = open(pcsfile, 'w')

for line in open(vec):
    if '#eig' in line:
        continue
    else:
        info = line.strip().split()
        tmp = info[0].split(':')
        tmp[1] = cpdic[tmp[1]]
        tmp[0] = popdict[tmp[1]]
        fh.write('\t'.join(tmp + info[1:]) + '\n')
fh.close()

#os.system('%s %s %s %s' % (rscript, pcaplot, pcsfile, outdir + '/pca'))

twfile = open(outdir + '/tw.txt', 'w')
count = 1
flag = 0

for line in open(pcalog):
    if flag and count < 12:
        info = line.strip().split()
        twfile.write('\t'.join(info) + '\n')
        count += 1
    elif line.startswith('## Tracy-Widom'):
        flag = 1

twfile.close()
