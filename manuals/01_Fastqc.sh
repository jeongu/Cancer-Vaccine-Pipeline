#!/bin/bash

path=/home/00_TeamProject/01_WES_$1
inputdir=/home/00_TeamProject/00_raw_data/WES_$1
fastqc='/home/greatitem/tool/FastQC-0.11.8/fastqc'
outdir=$path/00_FASTQC

mkdir -p $outdir

# fastqc
$fastqc –t 2 –o $outdir $inputdir/$2
$fastqc –t 2 –o $outdir $inputdir/$3
