#!/bin/bash

path='/home/00_TeamProject/01_WES_Normal'
hg38_bundle='/home/00_TeamProject/reference/hg38_bundle'
gatk='/home/00_TeamProject/tools/gatk-4.0.12.0/gatk'
inputdir=$path/07_Haplotypecall
outdir=$path/08_GenotypeGVCF

mkdir -p $outdir

$gatk GenotypeGVCFs --variant $inputdir/Normal_haplocall.vcf -R $hg38_bundle/hg38.fa -O $outdir/Normal_haplocall.vcf

