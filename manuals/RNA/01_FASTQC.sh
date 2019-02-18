#/bin/bash

project = /home/01_Neoantigen
Data_path = ${project}/00_rawdata
FASTQC_path = ${project}/01_RNA/01_FASTQC

#fastqc
fastqc -t 2 -o ${FASTQC_path}/RNA-Tumor_1.fastq.gz
fastqc -t 2 -o ${FASTQC_path}/RNA-Tumor_2.fastq.gz
