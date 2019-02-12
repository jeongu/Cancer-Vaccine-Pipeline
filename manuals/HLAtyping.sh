#!/bin/bash

path="/home/00_TeamProject/01_WES_Normal"
gatk="/home/00_TeamProject/tools/gatk-4.0.12.0/gatk"
tool="/home/00_TeamProject/tools/HLAminer-1.4/HLAminer_v1.4"
hlaminer=$tool/bin/HLAminer.pl
hla_ref=$tool/database/HLA_ABC_GEN.fasta
hla_pd=$tool/database/hla_nom_p.txt
inputdir=$path/03_BWA
outdir=$path/HLAtyping

mkdir -p $outdir

# rename RG of sam header
$gatk AddOrReplaceReadGroups -I $inputdir/Normal.sam -O $outdir/normal_reheader.sam -RGID Normal_sample -RGLB Normal_sample -RGPL ILLUMINA -RGPM HISEQ2500 -RGSM Normal_sample -RGPU Patient16

### Predict HLA
echo "Predicting HLA..."
$hlaminer -a $outdir/normal_reheader.sam -e 0 -h $hla_ref -p $hla_pd -z 200 -i 99 -q 30 -s 500 -n 0
