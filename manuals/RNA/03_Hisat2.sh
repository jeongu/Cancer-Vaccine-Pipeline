#!/bin/bash
reference_path=/home/01_Neoantigen/reference/RNA
input_path=/home/01_Neoantigen/01_RNA/02_Trimmomatic
output_path=/home/01_Neoantigen/01_RNA/03_Align_hisat2


#hisat ${1}[Stringtie | Cufflinks ]  ${2}[Stringtie : --dta | Cufflinks : --dta-cufflinks]

hisat2 -p 4 ${2} -x ${reference_path}/hg38.fa \
           -1 ${input_path}/RNA-Tumor_1_P.fastq.gz \
           -2 ${input_path}/RNA-Tumor_2_P.fastq.gz \
           -S ${output_path}/${1}_RNA-Tumor.sam \
           --summary-file ${output_path}/${1}_hisat2_summary.txt


      
