for line in open('depth.txt'):
    info = line.strip().split()
    if info[1] != '0':
        frac = lastv - float(info[2])
        print '%s\t%s' % (lastd, frac)
    lastd = info[1]
    lastv = float(info[2])


