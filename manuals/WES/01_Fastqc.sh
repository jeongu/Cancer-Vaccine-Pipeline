#!/bin/bash

echo "You need to assign your sample type (Normal or Tumor)."

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    home=/home/01_Neoantigen
    inputdir=${home}/00_rawdata
    outdir=${home}/01_WES_${1}/01_FastQC
    
    mkdir -p ${home} ${outdir}
    
    # fastqc
    fastqc –t 2 –o ${outdir} ${inputdir}/WES-${1}_1.fastq.gz
    fastqc –t 2 –o ${outdir} ${inputdir}/WES-${1}_2.fastq.gz
else
    echo "sample type error."
fi
