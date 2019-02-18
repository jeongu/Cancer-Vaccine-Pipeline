#!/bin/bash 

tophat \
        --output-dir 02_Align/trimmed \
        --num-threads 8 \
        --mate-inner-dist 250 --mate-std-dev 50 \
        --library-type fr-unstranded \
        --GTF /home/00_TeamProject/resources/hg38.gtf \
        --rg-id rna \
        --rg-sample rna_tumor \
        /home/00_TeamProject/resources/rna/hg38.fa \
        /home/00_TeamProject/01_RNA/01-2_Trim/ERR2303646_1.P.fastq.gz \
        /home/00_TeamProject/01_RNA/01-2_Trim/ERR2303646_2.P.fastq.gz
