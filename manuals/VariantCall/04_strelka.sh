#!/bin/bash

STRELKA_INSTALL_PATH='/home/shinjae325/.conda/envs/vaccine/share/strelka-2.9.10-0/'
ref='/home/01_Neoantigen/reference/RNA/hg38.fa'
normal='/home/01_Neoantigen/01_WES_Normal/06_BQSR/WES-Normal_dedup_bqsr.bam'
tumor='/home/01_Neoantigen/01_WES_Tumor/06_BQSR/WES-Tumor_dedup_bqsr.bam'
outdir='/home/01_Neoantigen/02_VariantCall/04_strelka'



python ${STRELKA_INSTALL_PATH}/bin/configureStrelkaSomaticWorkflow.py \
    --normalBam ${normal} \
    --tumorBam ${tumor} \
    --referenceFasta ${ref} \
    --runDir ${outdir}
    
${outdir}/runWorkflow.py -m local -j 3


# merge snp and indel vcf files
bcftools concat -a \
-Oz -o strelka.vcf.gz \
${outdir}/results/variants/somatic.snvs.vcf.gz \
${outdir}/results/variants/somatic.indels.vcf.gz

tabix -p vcf ${outdir}/result/variants/strelka.vcf.gz

#
bcftools view -f "PASS" ${outdir}/result/variants/strelka.vcf.gz > ${outdir}/result/variants/strelka_PASS.vcf

bgzip -c ${outdir}/result/variants/strelka_PASS.vcf > ${outdir}/result/variants/strelka_PASS.vcf.gz
tabix -p vcf ${outdir}/result/variants/strelka_PASS.vcf.gz
