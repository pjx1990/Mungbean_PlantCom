namecp = {}

for line in open('cp.name'):
    info = line.strip().split()
    namecp[info[1]] = info[0]

count = 100
for line in open('tt'):
    info = line.strip().split()
    if info[0] in namecp:
        continue
    namecp[info[0]] = 'scaffold_%s' % count
    count += 1

for line in open('genome.FINAL.fasta'):
    if line.startswith('>'):
        seqn = namecp[line.strip()[1:]]
        print '>%s' % seqn
    else:
        print line,

