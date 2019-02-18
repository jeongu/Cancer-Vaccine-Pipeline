#!/bin/bash

echo "You need to assign your sample type (Normal or Tumor)."

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    home=/home/01_Neoantigen
    gatk=${home}/tools/gatk-4.1.0.0/gatk
    inputdir=${home}/01_WES_${1}/04_Sort
    outdir=${home}/01_WES_${1}/05_DeDuplicate
    
    mkdir -p ${outdir}

    # remove PCR duplication
    ${gatk} MarkDuplicates --INPUT ${inputdir}/WES-${1}_sort.bam --OUTPUT ${outdir}/WES-${1}_dedup.bam --METRICS_FILE ${outdir}/WES-${1}_dedup.metrics

    # indexing dedup.bam
    ${gatk} BuildBamIndex --INPUT ${outdir}/WES-${1}_dedup.bam
else
    echo "sample type error."
fi
