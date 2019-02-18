#!/bin/bash 

cuffquant \
    --output-dir 05_Cuffquant \
    --num-threads 8 \
    --library-type fr-unstranded \
    --frag-bias-correct /home/00_TeamProject/reference/rna/hg38.fa \
    --multi-read-correct \
    04_Cuffmerge/merged.gtf \
    02_Align/trimmed/accepted_hits.bam 
