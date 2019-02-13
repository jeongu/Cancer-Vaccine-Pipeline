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
    inputdir=/home/00_TeamProject/00_raw_data/WES_${1}
    trimmomatic=/home/greatitem/tool/Trimmomatic-0.36
    outdir=${path}/01_Trimmomatic
    
    mkdir -p ${outdir}
    
    # Trimmomatic
    java -jar ${trimmomatic}/trimmomatic-0.36.jar PE \
    ${inputdir}/${sra_num}_1.fastq ${inputdir}/${sra_num}_2.fastq \
    ${outdir}/${sra_num}_R1_P.fastq ${outdir}/${sra_num}_R1_U.fastq \
    ${outdir}/${sra_num}_R2_P.fastq ${outdir}/${sra_num}_R2_U.fastq \
    ILLUMINACLIP:${trimmomatic}/adapters/TruSeq3-PE-2.fa:2:30:10 \
    LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:80
else
    echo "sample type error."
fi
