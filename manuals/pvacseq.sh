#!/bin/bash 

pvacseq run \
00_example_data/input.vcf \
Test \
HLA-G*01:09,HLA-E*01:01,H2-IAb \
NetMHC PickPocket NNalign hycho \
-e 9,10 \
-i 00_example_data/additional_input_file_list.yaml --tdna-vaf 20 \
--net-chop-method cterm --netmhc-stab \
--top-score-metric=lowest -d full --keep-tmp-files
