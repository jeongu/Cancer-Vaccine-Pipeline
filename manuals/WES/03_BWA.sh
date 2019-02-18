#!/bin/bash

echo "You need to assign your sample type. (Normal or Tumor)"
echo "You need to activate conda virtual environment. (vaccine)"

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    home=/home/01_Neoantigen
    ref=${home}/reference/hg38.fa.gz
    inputdir=${home}/01_WES_${1}/02_Trimmomatic
    outdir=${home}/01_WES_${1}/03_BWA
    
    mkdir -p ${outdir}
    
    bwa mem -M -t 3 -R "@RG\tID:${1}\tLB:${1}\tPL:ILLUMINA\tPM:HISEQ2500\tSM:${1}" \
    ${ref} ${inputdir}/WES-${1}_1_P.fastq.gz ${inputdir}/WES-${1}_2_P.fastq.gz > ${outdir}/WES-${1}.sam
else
    echo "sample type error."
fi
