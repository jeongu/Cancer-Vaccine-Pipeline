#!/bin/bash

path='/home/00_TeamProject/01_WES_Normal'
gatk='/home/00_TeamProject/tools/gatk-4.0.12.0/gatk'
inputdir=$path/03_BWA
outdir=$path/04_Srot

mkdir -p $outdir

# sorting bam file using GATK
$gatk SortSam --INPUT $inpurdir/Normal.sam --OUTPUT $outdir/Normal_sort.bam --SORT_ORDER coordinate
