#!/bin/bash
path=/home/01_Neoantigen
indir=${path}/02_VariantCall/06_annotate_VEP
outdir=${path}/02_VariantCall/07_Variant_coverage
bam_readcount=${path}/tools/bam-readcount/bin/bam-readcount
ref=${path}/reference/gatk_bundle/hg38.fa
normal_WES=${path}/01_WES_Normal/06_BQSR/WES-Normal_dedup_bqsr.bam
tumor_WES=${path}/01_WES_Tumor/06_BQSR/WES-Tumor_dedup_bqsr.bam
tumor_RNA=${path}/01_RNA/03_Align_hisat2/Cufflinks_RNA-Tumor.sorted.bam
#tumor_RNA=${path}/01_RNA/04_StringTie/RNA-Tumor.sorted.bam


mkdir -p ${outdir}

#split snp and indel from vcf files
bcftools filter -e'%TYPE="indel"' ${indir}/union_annotated.vcf > ${outdir}/union_annotated_only_snp.vcf
bcftools filter -e'%TYPE="snp"' ${indir}/union_annotated.vcf > ${outdir}/union_annotated_only_indel.vcf

#Get position for snp, indel
sed '/^#/ d' ${outdir}/union_annotated_only_indel.vcf | awk '{print $1,$2,$2}' > ${outdir}/indel.positions
sed '/^#/ d' ${outdir}/union_annotated_only_snp.vcf | awk '{print $1,$2,$2}' > ${outdir}/snp.positions

#bam-readcount
${bam_readcount} -f ${ref} ${normal_WES} -i -b 20 -l ${outdir}/indel.positions > ${outdir}/Normal_WES_indel_readcount
${bam_readcount} -f ${ref} ${normal_WES} -b 20 -l ${outdir}/snp.positions > ${outdir}/Normal_WES_snp_readcount
${bam_readcount} -f ${ref} ${tumor_WES} -i -b 20 -l ${outdir}/indel.positions > ${outdir}/Tumor_WES_indel_readcount
${bam_readcount} -f ${ref} ${tumor_WES} -b 20 -l ${outdir}/snp.positions > ${outdir}/Tumor_WES_snp_readcount
${bam_readcount} -f ${ref} ${normal_WES} -i -b 20 -l ${outdir}/indel.positions > ${outdir}/Tumor_RNA_indel_readcount
${bam_readcount} -f ${ref} ${normal_WES} -b 20 -l ${outdir}/snp.positions > ${outdir}/Tumor_RNA_snp_readcount


