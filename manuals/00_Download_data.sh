#!/bin/bash

fastq_dump='/home/00_TeamProject/tools/sratoolkit.2.9.2-ubuntu64/bin/fastq-dump'
refdir='/home/00_TeamProject/reference'
outdir='/home/00_TeamProject/00_raw_data'
RNAdir=$outdir/00_RNA
Tumordir=$outdir/01_Tumor
Normaldir=$outdir/02_Normal

RNA='ERR2303646'
Tumor='ERR2303647'
Normal='ERR2303645'

# download patient's data
mkdir -p $outdir
mkdir -p $RNAdir
mkdir -p $Tumordir
mkdir -p $Normaldir

#prefetch='/home/00_TeamProject/tools/sratoolkit.2.9.2-ubuntu64/bin/prefetch'

#$prefetch -f all $RNA
#$prefetch -f all $Tumor
#$prefetch -f all $Normal

$fastq_dump --split-files $RNA -O $RNAdir
$fastq_dump --split-files $Tumor -O $Tumordir
$fastq_dump --split-files $Normal -O $Normaldir

# download reference data and indexing
wget -P $refdir/ http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz
bwa index -a bwtsw $refdir/hg38.fa.gz
