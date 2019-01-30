#!/bin/bash

path='/home/00_TeamProject/01_WES_Normal'
inputdir=$path/04_Sort
outdir=$path/05_DeDuplicate
gatk='/home/00_TeamProject/tools/gatk-4.0.12.0/gatk'

mkdir -p $outdir

# remove PCR duplication
$gatk MarkDuplicates --INPUT $inputdir/Normal_sort.bam --OUTPUT $outdir/Normal_dedup.bam --METRICS_FILE $outdir/Normal_dedup.metrics

# indexing dedup.bam
$gatk BuildBamIndex --INPUT $outdir/Normal_dedup.bam
