#!/bin/bash

indir=/home/01_Neoantigen/02_VariantCall/HaplotypeCall
ref=/home/01_Neoantigen/reference/gatk_bundle/hg38.fa

vep \
--input_file ${indir}/Germline_haplotypecall_PASS.vcf \
--output_file ${indir}/Germline_haplotypecall_PASS_vep.vcf \
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

#filter non coding region variants

filter_vep \
--format vcf \
--ontology \
--filter "Consequence is coding_sequence_variant" \
-o ${indir}/Germline_haplotypecall_PASS_vep_CDS.vcf \
-i ${indir}/Germline_haplotypecall_PASS_vep.vcf

