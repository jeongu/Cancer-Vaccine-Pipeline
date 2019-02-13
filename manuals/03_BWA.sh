#!/bin/bash

echo "You need to assign your sample type (Normal or Tumor)."

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    if [ ${1} = "Normal" ]
    then
        sra_num="ERR2303645"
    else
        sra_num="ERR2303647"
    fi
    
    path=/home/00_TeamProject/01_WES_${1}
    ref=/home/00_TeamProject/reference/hg38.fa.gz
    inputdir=${path}/01_Trimmomatic
    outdir=${path}/02_BWA
    
    mkdir -p ${outdir}

    bwa mem -M -t 3 -R "@RG\tID:${1}_sample\tLB:${1}_sample\tPL:ILLUMINA\tPM:HISEQ2500\tPU:Patient16\tSM:${1}_sample" \
    ${ref} ${inputdir}/${sra_num}_R1_P.fastq ${inputdir}/${sra_num}_R2_P.fastq > ${outdir}/${1}.sam
else
    echo "sample type error."
fi
