#!/bin/bash

path=/home/01_Neoantigen/02_VariantCall
gatk=/home/01_Neoantigen/tools/gatk-4.1.0.0/gatk
gatk_bundle=/home/01_Neoantigen/reference/gatk_bundle
outdir=${path}/05_union

mkdir -p ${outdir}

cp ${path}/01_mutect2/03_mutect2_filtered_PASS.vcf.gz* ${outdir}
cp ${path}/02_varscan/01_varscan.Somatic.hc.sorted.vcf.gz* ${outdir}
cp ${path}/04_strelka/results/variants/strelka_PASS.vcf.gz* ${outdir}


${gatk} MergeVcfs -I ${outdir}/01_varscan.Somatic.hc.sorted.vcf.gz -I ${outdir}/03_mutect2_filtered_PASS.vcf.gz -I ${outdir}/strelka_PASS.vcf.gz -O ${outdir}/vcf_union.vcf -D ${gatk_bundle}/hg38.dict




