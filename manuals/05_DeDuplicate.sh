#!/bin/bash

echo "You need to assign your sample type (Normal or Tumor)."

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    path=/home/00_TeamProject/01_WES_${1}
    inputdir=${path}/04_Sort
    outdir=${path}/05_DeDuplicate
    picard=/home/00_TeamProject/tools/picard/build/libs/picard.jar
    
    mkdir -p ${outdir}

    # remove PCR duplication
    java -jar ${picard} MarkDuplicates INPUT=${inputdir}/${1}_sort.bam OUTPUT=${outdir}/${1}_dedup.bam METRICS_FILE=${outdir}/${1}_dedup.metrics VALIDATION_STRINGENCY=LENIENT

    # indexing dedup.bam
    java -jar ${picard} BuildBamIndex INPUT=${outdir}/${1}_dedup.bam
else
    echo "sample type error."
fi
