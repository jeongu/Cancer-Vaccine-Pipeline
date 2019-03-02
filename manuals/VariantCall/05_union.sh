#!/bin/bash

path=/home/01_Neoantigen/02_VariantCall
gatk=/home/01_Neoantigen/tools/gatk-4.1.0.0/gatk
vt=/home/01_Neoantigen/tools/vt/vt
gatk_bundle=/home/01_Neoantigen/reference/gatk_bundle
outdir=${path}/05_union


mkdir -p ${outdir}

cp ${path}/01_mutect2/03_mutect2_filtered_PASS.vcf.gz* ${outdir}
cp ${path}/02_varscan/01_varscan.Somatic.hc.sorted.vcf.gz* ${outdir}
cp ${path}/04_strelka/results/variants/strelka_PASS.vcf.gz* ${outdir}


${gatk} MergeVcfs -I ${outdir}/01_varscan.Somatic.hc.sorted.vcf.gz -I ${outdir}/03_mutect2_filtered_PASS.vcf.gz -I ${outdir}/strelka_PASS.vcf.gz -I ${outdir}/indel.filter.output.vcf.gz -I ${outdir}/snp.filter.output.vcf.gz -O ${outdir}/vcf_union.vcf -D ${gatk_bundle}/hg38.dict

#Normalization
${gatk} LeftAlignAndTrimVariants -V ${outdir}/vcf_union.vcf -R ${gatk_bundle}/hg38.fa -O ${outdir}/vcf_union_normalized.vcf

#split multi-allelic variants to biallelic
${vt} decompose ${outdir}/vcf_union_normalized.vcf -o ${outdir}vcf_union_normalized_vt.vcf
