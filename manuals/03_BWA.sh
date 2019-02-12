#!/bin/bash

path='/home/00_TeamProject/01_WES_Normal'
ref='/home/00_TeamProject/reference/hg38.fa.gz'
inputdir=$path/01_Trimmomatic
outdir=$path/02_BWA

mkdir -p $outdir
Tumor_sample
Normal_sample
bwa mem -M -t 3 -R '@RG\tID:Sample\tLB:Sample\tPL:ILLUMINA\tPM:HISEQ2500\tPU:Patient16\tSM:Sample' \
$ref $inputdir/ERR2303645_R1_P.fastq $inputdir/ERR2303645_R2_P.fastq > $outdir/Normal.sam

