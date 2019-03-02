#!/bin/bash

path=/home/01_Neoantigen
outdir=${path}/02_VariantCall/09_pvacseq
indir=${path}/02_VariantCall/08_add_coverage_vcf
iedb=${path}/tools/IEDB
HLA=HLA-A*02:06,HLA-A*26:02,HLA-B*55:02,HLA-B*40:02,HLA-C*03:04,HLA-C*01:02

mkdir -p ${outdir}

pvacseq run ${indir}/07_somatic.vcf.gz Tumor ${HLA} NetMHC PickPocket ${outdir}/Result \
            -e 8,9,10 \
            --iedb-install-directory ${iedb} \
            -i ${outdir}/additional_input_file_list.yaml \
            -p ${outdir}/02_phased.vcf.gz
            --normal-sample-name Normal \
            --top-score-metric lowest \
            --net-chop-method cterm \
            --netmhc-stab -d full \
            -t 7


