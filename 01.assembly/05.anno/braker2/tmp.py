import sys

lendic = {}
longest = {}

tmplen = 0
tmptxt = ''
gn = ''

for line in open(sys.argv[1]):
    if len(line.strip()) == 0:
        continue
    if line.startswith('>'):
        if not ((gn in lendic and tmplen <= lendic[gn]) or gn == ''):
            longest[gn] = tmptxt
            lendic[gn] = tmplen
        gn = line.strip()[1:].split('.')[0]
        tmplen = 0
        tmptxt = line
    else:
        tmplen += len(line.strip())
        tmptxt += line

if not (gn in lendic and tmplen <= lendic[gn]):
    longest[gn] = tmptxt
    lendic[gn] = tmplen

for each in longest:
    print longest[each],
