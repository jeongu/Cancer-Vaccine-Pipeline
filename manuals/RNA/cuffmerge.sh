#!/bin/bash 

cuffmerge \
    -p 8 \
    -g /home/00_TeamProject/resources/hg38.gtf \
    -s /home/00_TeamProject/resources/rna/hg38.fa \
    -o 04_Cuffmerge \
    04_Cuffmerge/gtf_list.txt
