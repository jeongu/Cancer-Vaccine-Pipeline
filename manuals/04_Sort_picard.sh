#!/bin/bash

echo "You need to assign your sample type (Normal or Tumor)."

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    path="/home/00_TeamProject/01_WES_${1}"
    picard="/home/00_TeamProject/tools/picard/build/libs/picard.jar"
    inputdir=${path}/03_BWA
    outdir=${path}/04_Sort

    mkdir -p ${outdir}

    # convert sam to bam
    java -jar ${picard} SamFormatConverter INPUT=${inputdir}/${1}.sam OUTPUT=${inputdir}/${1}.bam

    # sort bam file
    java -jar ${picard} SortSam INPUT=${inputdir}/${1}.bam OUTPUT=${outdir}/${1}_sort.bam SORT_ORDER=coordinate
else
    echo "sample type error."
fi
