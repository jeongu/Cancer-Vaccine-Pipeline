#!/bin/bash

echo "You need to assign your sample type (Normal or Tumor)."

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    home=/home/01_Neoantigen
    gatk=${home}/tools/gatk-4.1.0.0/gatk
    inputdir=${home}/01_WES_${1}/03_BWA
    outdir=${home}/01_WES_${1}/04_Sort

    mkdir -p ${outdir}

    # sort bam file
    ${gatk} SortSam --INPUT ${inputdir}/WES-${1}.sam --OUTPUT ${outdir}/WES-${1}_sort.bam --SORT_ORDER coordinate
else
    echo "sample type error."
fi
