import os
import sys
import glob

tgd = sys.argv[1]

sn = tgd.split('.')[1]

flag = 0

logf = '%s/log.txt' % (tgd)
if os.path.isfile(logf) and 'N50' in open(logf).read() and os.path.exists('%s/CA' % (tgd)):
    flag = 1

if flag:
    os.system('mv %s/CA/final.genome.scf.fasta finished/%s.fa' % (tgd, sn))
    os.chdir(tgd)
    fls = glob.glob('./*')
    fls.remove('./config.sh')
    fls.remove('./work.sh')
    fls.remove('./log.txt')
    fls.remove('./insertsize')
    if './nohup.out' in fls:
        fls.remove('./nohup.out')

    for fl in fls:
        os.system('rm -r %s' % fl)

    os.chdir('insertsize')
    os.system('rm *.fq')
    os.system('rm *.out')
    os.system('rm *.bam')

