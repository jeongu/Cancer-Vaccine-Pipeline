#!/bin/bash

path='/home/00_TeamProject/01_WES_Normal'
hg38_bundle='/home/00_TeamProject/reference/hg38_bundle'
gatk='/home/00_TeamProject/tools/gatk-4.0.12.0/gatk'
inputdir=$path/06_BQSR
outdir=$path/07_Haplotypecall

mkdir -p $outdir

$gatk HaplotypeCaller -I $inputdir/Normal_dedup_bqsr.bam \
-O $outdir/Normal_haplocall.g.vcf --emit-ref-confidence GVCF \
-R $hg38_bundle/hg38.fa
