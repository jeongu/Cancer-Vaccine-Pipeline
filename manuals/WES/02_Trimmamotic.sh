#!/bin/bash

echo "You need to assign your sample type (Normal or Tumor)."

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    home=/home/01_Neoantigen
    inputdir=${home}/00_rawdata
    trimmomatic=${home}/tools/Trimmomatic-0.36
    outdir=${home}/01_WES_${1}/02_Trimmomatic
    
    mkdir -p ${outdir}
    
    # Trimmomatic
    java -jar ${trimmomatic}/trimmomatic-0.36.jar PE \
    ${inputdir}/WES-${1}_1.fastq.gz ${inputdir}/WES-${1}_2.fastq.gz \
    ${outdir}/WES-${1}_1_P.fastq.gz ${outdir}/WES-${1}_1_U.fastq.gz \
    ${outdir}/WES-${1}_2_P.fastq.gz ${outdir}/WES-${1}_2_U.fastq.gz \
    ILLUMINACLIP:${trimmomatic}/adapters/TruSeq3-PE-2.fa:2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:80
    
    # fastqc after trimming
    inputdir=${home}/01_WES_${1}/02_Trimmomatic
    outdir=${home}/01_WES_${1}/01_FastQC
    
    fastqc –-threads 2 –o ${outdir} ${inputdir}/WES-${1}_1_P.fastq.gz
    fastqc –-threads 2 –o ${outdir} ${inputdir}/WES-${1}_2_P.fastq.gz
else
    echo "sample type error."
fi
