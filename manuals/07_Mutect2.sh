#!/bin/bash

path='/home/00_TeamProject'
hg38_bundle=$path/reference/hg38_bundle
gatk=$path/tools/gatk-4.0.12.0/gatk
normaldir=$path/01_WES_Normal/06_BQSR/Normal_dedup_bqsr.bam
tumordir=$path/01_WES_Tumor/03_BQSR/tumor_dedup_bqsr.bam
outdir=$path/01_WES_Normal/07_Mutect2

#mkdir -p $outdir

# replace read groups of normal and tumor WES bam file
#$gatk AddOrReplaceReadGroups -I $normaldir -O $outdir/normal_reheader.bam -RGID Normal_sample -RGLB Normal_sample -RGPL ILLUMINA -RGPM HISEQ2500 -RGSM Normal_sample -RGPU Patient16
#$gatk AddOrReplaceReadGroups -I $tumordir -O $outdir/tumor_reheader.bam -RGID Tumor_sample -RGLB Tumor_sample -RGPL ILLUMINA -RGPM HISEQ2500 -RGSM Tumor_sample -RGPU Patient16

# check replaced bam file header
#samtools_0.1.18 view -H $outdir/normal_reheader.bam
#samtools_0.1.18 view -H $outdir/tumor_reheader.bam

# indexing
samtools_0.1.18 index $outdir/normal_reheader.bam
samtools_0.1.18 index $outdir/tumor_reheader.bam

# run Mutect2
$gatk Mutect2 -I $outdir/normal_reheader.bam -I $outdir/tumor_reheader.bam --normal Normal_sample --tumor Tumor_sample -O $outdir/somatic_mutect2.vcf -R $hg38_bundle/hg38.fa
