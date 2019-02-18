#!/bin/bash

project_path=/home/01_Neoantigen/01_RNA
sam_path=${project_path}/03_Align_hisat2
output_path=${project_path}/04_StringTie

#mkdir ${output_path}

#samtools sort -o ${output_path}/RNA-Tumor.sorted.sam ${same_path}/RNA-Tumor.sam
#samtools view -Su ${output_path}/RNA-Tumor.sorted.sam > ${output_path}/RNA-Tumor.bam


#samtools sort ${output_path}/RNA-Tumor.bam -o ${output_path}/RNA-Tumor.alns.sorted
stringtie ${output_path}/RNA-Tumor.sorted.bam \
              -p 8 -G /home/01_Neoantigen/reference/hg38.gtf \
              -o ${output_path}/treanscripts.gtf \
              -A ${output_path}/gene_abundance.tab \
              -C ${output_path}/cov_refs.gtf
