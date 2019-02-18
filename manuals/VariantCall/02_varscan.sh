#!/bin/bash

path=/home/01_Neoantigen
normaldir=${path}/01_WES_Normal/06_BQSR
tumordir=${path}/01_WES_Tumor/06_BQSR
outdir=${path}/02_VariantCall/02_varscan
ref=${path}/reference/gatk_bundle
outfn=00_normal_tumor_mpileup


samtools mpileup -f ${ref}/hg38.fa ${normaldir}/WES-Normal_dedup_bqsr.bam ${tumordir}/WES-Tumor_dedup_bqsr.bam >  ${outdir}/${outfn}

varscan somatic ${outdir}/${outfn} ${outdir}/01_varscan.vcf --mpileup 1 --output-snp --output-indel --output-vcf 1

mv /home/01_Neoantigen/manuals/VariantCall/true.vcf ${outdir}
mv ${outdir}/true.vcf ${outdir}/01_varscan.vcf



# filter the variants
varscan processSomatic ${outdir}/01_varscan.vcf
${gatk} SortVcf -I ${outdir/}01_varscan.Somatic.hc.vcf -O ${outdir}/01_varscan.Somatic.hc.sorted.vcf -SD ${ref}/hg38.dict
bgzip -c ${outdir}/01_varscan.Somatic.hc.sorted.vcf > ${outdir}/01_varscan.Somatic.hc.sorted.vcf.gz
tabix -p vcf ${outdir}/01_varscan.Somatic.hc.sorted.vcf.gz
