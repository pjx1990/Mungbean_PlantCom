#!/usr/bin/env python
import os
import re
import argparse
#import ConfigParser #python2
import configparser as ConfigParser #python3
import sys


def ArgParse():
    parser = argparse.ArgumentParser()
    help = 'vcf or plink bed file. prefix only if bed format file used.'
    parser.add_argument('--geno', required=True, help=help)
    help = 'out directory and out file prefix. ./output defaulted'
    parser.add_argument('--output', default='./output', help=help)
    help = ' Neighbor-Joining algorithm or UPAGMA method build tree, UPAGMA defaulted'
    #parser.add_argument('--tree',type=str, default='UPAGMA', help=help)
    parser.add_argument('--tree',type=str, default='NJ', help=help)
    args = parser.parse_args()
    return args


def ParseAppConfig():
    Spath = os.path.split(os.path.realpath(__file__))[0]
    cf = ConfigParser.ConfigParser()
    cf.read("%s/AppCfg.ini" % (Spath))
    return cf


def vcf2plinkped(cf, geno, outdir, outpre):
    out = outdir + '/' + outpre
    #xx = os.system('%s --vcf %s --double-id --make-bed --mind 0.5 --allow-extra-chr --out %s'
    xx = os.system('%s --vcf %s --double-id --make-bed --allow-extra-chr --out %s'
                   % (cf.get('app', 'Plink'), geno, out))
    if xx != 0:
        sys.exit(111)


def ibspair(cf, geno, outdir, outpre):
    out = outdir + '/' + outpre
    xx = os.system('%s --bfile %s --genome --out %s --allow-extra-chr'
                   % (cf.get('app', 'Plink'), geno, out))
    if xx != 0:
        sys.exit(111)


def ibsMartrix(infile, outfile):
    dic1 = {}
    lis1 = []
    vls = []
    outfile = open(outfile, 'w')
    for line in open(infile):
        if re.search(r'^\s*FID', line):
            pass
        else:
            info = re.split(r'\s+', line.strip())
            if info[1] not in lis1:
                lis1.append(info[1])
            if info[3] not in lis1:
                lis1.append(info[3])
            dic1[info[1] + '_' + info[3]] = info[-3]
            dic1[info[3] + '_' + info[1]] = info[-3]
            vls.append(float(info[-3]))

    rg = max(vls) - min(vls)
    maxv = max(vls)

    outfile.write('Sample\t' + '\t'.join(lis1) + '\n')

    for i in lis1:
        outline = [i]
        for j in lis1:
            if i == j:
                outline.append('0')
            else:
                # tv = 1 - float(dic1[i + '_' + j])
                tv = (maxv - float(dic1[i + '_' + j])) / rg
                outline.append(str(tv))
        outfile.write('\t'.join(outline) + '\n')


def bionj(cf, infile, outfile, tree):
    Rcmd = """
library(ape)
df <- read.table("{infile}", header=TRUE, row.names=1)
df <- data.matrix(df)
if("{method}"=="NJ"){{tr <- bionj(df)}}else{{
    tr <- as.phylo(stats::hclust(dist(df),method="average"))
}}
write.tree(tr, file="{outfile}")"""
    Rcmd = Rcmd.format(infile=infile, outfile=outfile,method=tree)
    os.system('echo \'%s\'|%s --vanilla --slave' % (Rcmd, cf.get('app', 'R')))


def renameM(oldm, cpdic, newm):
    fh = open(newm, 'w')
    for line in open(oldm):
        info = line.strip().split()
        if line.startswith('Sample'):
            fh.write('\t'.join(['Sample'] + [cpdic[i] for i in info[1:]]) + '\n')
        else:
            info[0] = cpdic[info[0]]
            fh.write('\t'.join(info) + '\n')


def renametree(oldt, cpdic, newt):
    text = open(oldt).read()
    for each in cpdic:
        text = re.sub(each + ':', cpdic[each] + ':', text)
    fh = open(newt, 'w')
    fh.write(text)
    fh.close()


def main():
    args = ArgParse()
    cf = ParseAppConfig()
    outdir = os.path.dirname(args.output)
    outpre = os.path.basename(args.output)
    if outdir == '.' or outdir == '':
        outdir = os.getcwd()
    cpdic = {}
    if os.path.isfile(args.geno + '.cp'):
        for line in open(args.geno + '.cp'):
            info = line.strip().split('\t')
            cpdic[info[1]] = info[0]

    if re.search(r'\.vcf$', args.geno):
        vcf2plinkped(cf, args.geno, outdir, outpre)
        args.geno = args.output
    else:
        pass
    ibspair(cf, args.geno, outdir, outpre)
    ibsMartrix(args.output + '.genome', args.output + '.ibdM0')
    bionj(cf, args.output + '.ibdM0', args.output + '.tree0',tree=str(args.tree))
#    renameM(args.output + '.ibdM0', cpdic, args.output + '.ibdM')
#    renametree(args.output + '.tree0', cpdic, args.output + '.tree')


if __name__ == '__main__':
    main()


