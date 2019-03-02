#!/bin/bash

home=/home/01_Neoantigen
gatk=${home}/tools/gatk-4.1.0.0/gatk 
refdir=${home}/reference
gatk_bundle=${refdir}/gatk_bundle
inputdir=${home}/02_WES_Merge/02_Sort
outdir=${home}/02_VariantCall/HaplotypeCall_merge

mkdir -p ${outdir}

# HaplotypeCall
${gatk} HaplotypeCaller \
        -I ${inputdir}/Merge_sorted.bam \
        -O ${outdir}/germline_haplotypecall.vcf \
        --emit-ref-confidence GVCF \
        -R ${gatk_bundle}/hg38.fa \

# GenotypeGVCFs
${gatk} GenotypeGVCFs \
    --variant ${outdir}/germline_haplotypecall.vcf \
    -R ${gatk_bundle}/hg38.fa \
    -O ${outdir}/germline_haplotypecall_gvcf.vcf

# Variant Filtration
${gatk} VariantFiltration \
    --R ${gatk_bundle}/hg38.fa \
    --V ${outdir}/germline_haplotypecall_gvcf.vcf \
    --filter-name "FS" --filter "FS > 30.0" --filter-name "QD" --filter "QD < 2.0" \
    -O ${outdir}/germline_haplotypecall_filt.vcf
