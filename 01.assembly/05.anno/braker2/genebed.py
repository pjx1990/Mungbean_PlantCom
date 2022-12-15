for line in open('augustus.hints.gff3'):
    if line.startswith('#'):
        continue
    info = line.strip().split()
    if len(info) < 3:
        continue
    if info[2] == "gene":
        gn = info[8].split(';')[0].split('=')[1]
        print '\t'.join([info[0], str(int(info[3]) - 1), info[4]])
