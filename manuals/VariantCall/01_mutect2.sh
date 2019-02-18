#!/bin/bash

path=/home/01_Neoantigen
gatk_bundle=${path}/reference/gatk_bundle
gatk=/home/01_Neoantigen/tools/gatk-4.1.0.0/gatk
normaldir=${path}/01_WES_Normal/06_BQSR
tumordir=${path}/01_WES_Tumor/06_BQSR
outdir=/home/01_Neoantigen/02_VariantCall/01_mutect2



mkdir -p ${outdir}

# replace read groups of normal and tumor WES bam file
#$gatk AddOrReplaceReadGroups -I $normaldir -O $outdir/normal_reheader.bam -RGID Normal_sample -RGLB Normal_sample -RGPL ILLUMINA -RGPM HISEQ2500 -RGSM Normal_sample -RGPU Patient16
#$gatk AddOrReplaceReadGroups -I $tumordir -O $outdir/tumor_reheader.bam -RGID Tumor_sample -RGLB Tumor_sample -RGPL ILLUMINA -RGPM HISEQ2500 -RGSM Tumor_sample -RGPU Patient16

# check replaced bam file header
#samtools_0.1.18 view -H $outdir/normal_reheader.bam
#samtools_0.1.18 view -H $outdir/tumor_reheader.bam

# indexing
#samtools_0.1.18 index $outdir/normal_reheader.bam
#samtools_0.1.18 index $outdir/tumor_reheader.bam



## clean reads from bam file
#java -jar ${picard} CleanSam I=${tumordir}/Tumor_dedup_bqsr.bam O=${tumordir}/Tumor_dedup_bqsr_cleaned.bam
#java -jar ${picard} BuildBamIndex I=${tumordir}/Tumor_dedup_bqsr_cleaned.bam

#java -jar ${picard} CleanSam I=${normaldir}/Normal_dedup_bqsr.bam O=${normaldir}/Normal_dedup_bqsr_cleaned.bam
#java -jar ${picard} BuildBamIndex I=${normaldir}/Normal_dedup_bqsr_cleaned.bam


# run MuTect2

${gatk} Mutect2 \
-I ${tumordir}/WES-Tumor_dedup_bqsr.bam -tumor Tumor \
-I ${normaldir}/WES-Normal_dedup_bqsr.bam -normal Normal \
--germline-resource ${gatk_bundle}/af-only-gnomad.hg38.vcf.gz \
-R ${gatk_bundle}/hg38.fa \
-O ${outdir}/01_mutect2.vcf.gz


# GetPileupSummaries
${gatk} GetPileupSummaries \
-I ${tumordir}/WES-Tumor_dedup_bqsr.bam \
-V ${gatk_bundle}/small_exac_common_3.hg38.vcf.gz \
-O ${outdir}/mutect2_mpileup_table -L ${outdir}/interval.list

# Calculate Contamination
${gatk} CalculateContamination -I ${outdir}/mutect2_mpileup_table -O ${outdir}/mutect2_contamination_table

# Filter the variants
/home/01_Neoantigen/tools/gatk-4.1.0.0/gatk FilterMutectCalls -V ${outdir}/01_mutect2.vcf.gz --contamination-table ${outdir}/mutect2_contamination_table -O 02_mutect2_filtered.vcf.gz

# Filter Non-pass variants
bcftools view -f "PASS" ${outdir}/02_mutect2_filtered.vcf.gz > ${outdir}/03_mutect2_filtered_PASS.vcf

bgzip -c ${outdir}/03_mutect2_filtered_PASS.vcf > ${outdir}/03_mutect2_filtered_PASS.vcf.gz
tabix -p vcf ${outdir}/03_mutect2_filtered_PASS.vcf.gz

