#!/bin/bash
project_path=/home/01_Neoantigen
Trimmomatic_path=${project_path}/tools/Trimmomatic-0.36
Data_path=${project_path}/00_rawdata
Output_path=${project_path}/01_RNA/02_Trimmomatic_2

mkdir ${Output_path}

java -jar ${Trimmomatic_path}/trimmomatic-0.36.jar PE -threads 4 \
         ${Data_path}/RNA-Tumor_1.fastq.gz ${Data_path}/RNA-Tumor_2.fastq.gz \
         ${Output_path}/RNA-Tumor_1_P.fastq.gz ${Output_path}/RNA-Tumor_1_U.fastq.gz \
         ${Output_path}/RNA-Tumor_2_P.fastq.gz ${Output_path}/RNA-Tumor_2_U.fastq.gz \
         ILLUMINACLIP:${Trimmomatic_path}/adapters/TruSeq3-PE-2.fa:2:30:10 \
         LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:80 HEADCROP:12

#mkdir ${Output_path}/Trim_fastqc

#fastqc -t 2 ${Output_path}/RNA-Tumor_1_P.fastq.gz -o ${Output_path}/Trim_fastqc
#fastqc -t 2 ${Output_path}/RNA-Tumor_2_P.fastq.gz -o ${Output_path}/Trim_fastqc

