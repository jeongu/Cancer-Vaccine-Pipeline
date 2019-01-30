#!/bin/bash

path='/home/00_TeamProject/01_WES_Normal'
inputdir='/home/00_TeamProject/00_raw_data/02_Normal'
filename='ERR2303645'
trimmomatic='/home/greatitem/tool/Trimmomatic-0.36'
outdir=$path/01_Trimmomatic

mkdir -p $outdir

# Trimmomatic
java -jar $trimmomatic/trimmomatic-0.36.jar PE \
$inputdir/$filename'_1.fastq' $inputdir/$filename'_2.fastq' \
$outdir/$filename'_R1_P.fastq' $outdir/$filename'_R1_U.fastq' \
$outdir/$filename'_R2_P.fastq' $outdir/$filename'_R2_U.fastq' \
ILLUMINACLIP:$trimmomatic/adapters/TruSeq3-PE-2.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:80
