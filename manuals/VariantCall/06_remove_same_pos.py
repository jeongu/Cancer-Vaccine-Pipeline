import sys
import re

if len(sys.argv) != 2 :
    print ('#########################################################################################')
    print ('python 06_remove_same_pos.py /home/01_Neoantigen/02_VariantCall/05_union/vcf_union_normalized_vt.vcf') 
    print ('#########################################################################################')
    exit()



path = '/home/01_Neoantigen/02_VariantCall/05_union/'

infile = sys.argv[1]
fn = infile.split('/')[-1]
fo_ = re.search(r'([\w_]+).vcf', fn).group(1)

fo = open(path+fo_+'_removed.vcf', 'w')


out=''
chrno=''
tmp=''

count = 0
for line in open(infile) :
    line = line.strip()
    if line.startswith('#') :
        out += line + '\n'
    else :
        ch = line.split('\t')[0]
        pos = int(line.split('\t')[1])
        if (chrno == ch) and (tmp == pos) :
            chrno = ch
            tmp = pos
            count += 1
        else :
            out += line + '\n'
            chrno = ch
            tmp = pos

fo.write(out)
fo.close()
