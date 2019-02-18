#!/bin/bash 

trimmomatic PE /home/00_TeamProject/00_raw_data/00_RNA/ERR2303646_1.fastq.gz /home/00_TeamProject/00_raw_data/00_RNA/ERR2303646_2.fastq.gz \
/home/00_TeamProject/01_RNA/01-2_Trim/ERR2303646_1.P.fastq.gz /home/00_TeamProject/01_RNA/01-2_Trim/ERR2303646_1.U.fastq.gz \
/home/00_TeamProject/01_RNA/01-2_Trim/ERR2303646_2.P.fastq.gz /home/00_TeamProject/01_RNA/01-2_Trim/ERR2303646_2.U.fastq.gz \
ILLUMINACLIP:/home/shinjae325/.conda/pkgs/trimmomatic-0.38-1/share/trimmomatic-0.38-1/adapters/TruSeq3-PE-2.fa:2:30:10 \
LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:80
