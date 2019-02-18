#!/bin/bash

project = /home/01_Neoantigen
Data_path = ${project}/00_rawdata
Output_path = ${project}/01_RNA/02_Flexbar

#Run Flexbar
flexbar -r ${Data_path}/RNA-Tumor_1.fastq.gz -p ${Data_path}/RNA-Tumor_2.fastq.gz --pre-trim-left 13 --qtrim-format sanger --adapter-preset TruSeq -ap ON -n 8 -t Output_path

