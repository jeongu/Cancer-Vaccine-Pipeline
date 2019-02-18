#!/bin/bash

sam_path=/home/01_Neoantigen/01_RNA/03_Align_hisat2
output_path=/home/01_Neoantigen/01_RNA/04_Cufflinks

samtools sort -o ${sam_path}/Cufflinks_RNA-Tumor.sorted.sam ${sam_path}/Cufflinks_RNA-Tumor.sam

cufflinks \
        --output-dir ${output_path} \
        --num-threads 8 \
        --library-type fr-unstranded \
        --GTF-guide /home/01_Neoantigen/reference/hg38.gtf \
        --mask-file /home/01_Neoantigen/reference/hg38.masked.gtf \
        --multi-read-correct \
        --frag-bias-correct /home/01_Neoantigen/reference/RNA/hg38.fa \
        ${sam_path}/Cufflinks_RNA-Tumor.sorted.sam
