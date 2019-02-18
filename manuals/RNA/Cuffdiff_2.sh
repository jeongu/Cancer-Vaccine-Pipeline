#!/bin/bash 

cuffdiff \
    --output-dir 04_Cuffdiff \
    --labels rna \
    --frag-bias-correct /home/00_TeamProject/reference/rna/hg38.fa \
    --multi-read-correct \
    --num-threads 8 \
    --library-type fr-unstranded \
    --library-norm-method classic-fpkm \
    --dispersion-method pooled \
    04_Cuffmerge/merged.gtf \
    05_Cuffquant/abundances.cxb
