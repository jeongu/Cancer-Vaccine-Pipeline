#!/bin/bash

VEP=/home/01_Neoantigen/tools/ensembl-vep/vep
path=/home/01_Neoantigen/02_VariantCall
indir=${path}/05_union
outdir=${path}/06_annotate_VEP

mkdir -p ${outdir}
${VEP} -i ${indir}/vcf_union_removed.vcf -o ${outdir}/union_annotated.vcf --fork 3 --cache

