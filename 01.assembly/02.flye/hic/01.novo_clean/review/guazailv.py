total = 0
guaz = 0

for line in open('vigna_radiata.genome.fa'):
    if line.startswith('>'):
        seqn = line.strip()[1:]
    else:
        nonlen = len(line.strip().replace('N', ''))
        total += nonlen
        if not seqn.startswith('scaf'):
            guaz += nonlen

print total 
print guaz
print '%.2f' % (float(guaz) / total * 100)
