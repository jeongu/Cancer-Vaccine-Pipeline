#!/bin/bash

home=/home/01_Neoantigen
gatk=${home}/tools/gatk-4.1.0.0/gatk 
refdir=${home}/reference
gatk_bundle=${refdir}/gatk_bundle
inputdir=${home}/01_WES_Normal/06_BQSR
outdir=${home}/02_VariantCall/HaplotypeCall

mkdir -p ${outdir}

${gatk} HaplotypeCaller \
-I ${inputdir}/WES-Normal_dedup_bqsr.bam \
-O ${outdir}/WES-Normal_haplotypecall.vcf \
--emit-ref-confidence GVCF -R ${gatk_bundle}/hg38.fa
