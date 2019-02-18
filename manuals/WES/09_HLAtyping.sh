#!/bin/bash

path=/home/00_TeamProject/01_WES_Normal
tool=/home/00_TeamProject/tools/HLAminer-1.4/HLAminer_v1.4
hlaminer=${tool}/bin/HLAminer.pl
hla_ref=${tool}/database/HLA_ABC_GEN.fasta
hla_pd=${tool}/database/hla_nom_p.txt
inputdir=${path}/03_BWA
outdir=${path}/09_HLAtyping

mkdir -p ${outdir}

### Predict HLA
echo "Predicting HLA..."
${hlaminer} -a ${outdir}/Normal.sam -e 0 -h ${hla_ref} -p ${hla_pd} -z 200 -i 99 -q 30 -s 500 -n 0


