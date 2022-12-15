bad = [i.strip() for i in open('bad.lst')]

for tt in open('any.trans.lst'):
    gn = tt.split('.')[0]
    if gn not in bad:
        print tt,
