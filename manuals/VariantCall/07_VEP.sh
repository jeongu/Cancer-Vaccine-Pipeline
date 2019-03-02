#!/bin/bash

path=/home/01_Neoantigen/02_VariantCall
indir=${path}/05_union
outdir=${path}/06_annotate_VEP
ref=/home/01_Neoantigen/reference/gatk_bundle/hg38.fa

mkdir -p ${outdir}
vep \
--input_file ${indir}/vcf_union_normalized_vt_removed.vcf \
--output_file ${outdir}/union_annotated.vcf \
--format vcf \
--vcf \
--symbol \
--transcript_version \
--offline \
--terms SO \
--plugin Downstream \
--plugin Wildtype \
--dir_plugin /home/shinjae325/.conda/envs/neoantigen/share/ensembl-vep-95.2-0 \
--flag_pick \
--tsl \
--hgvs \
--fasta ${ref} \
--pick \
--cache \
--fork 6

