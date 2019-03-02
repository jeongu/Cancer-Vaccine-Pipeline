#!/bin/bash
path=/home/01_Neoantigen
gatk_bundle=${path}/reference/gatk_bundle
gatk=${path}/tools/GenomeAnalysisTK-3.8.1/GenomeAnalysisTK.jar
picard=/home/01_Neoantigen/tools/picard/build/libs/picard.jar

germline_dir=${path}/02_VariantCall/HaplotypeCall
somatic_dir=${path}/02_VariantCall/08_add_coverage_vcf

tumor_dir=/home/01_Neoantigen/01_WES_Tumor/06_BQSR
outdir=${path}/02_VariantCall/09_pvacseq


# combine somatic and germline variants using gatk 3.*
java -jar ${gatk} -T CombineVariants \
-R ${gatk_bundle}/hg38.fa \
--variant ${germline_dir}/Germline_haplotypecall_PASS_vep_CDS.vcf \
--variant ${somatic_dir}/07_somatic.vcf \
-o ${outdir}/00_combined_germline_somatic.vcf \
--assumeIdenticalSamples


# Sort combiend vcf using picard
java -jar ${picard} SortVcf \
I=${outdir}/00_combined_germline_somatic.vcf \
O=${outdir}/01_combined_germline_somatic_sorted.vcf \
SEQUENCE_DICTIONARY=${gatk_bundle}/hg38.dict

# Phase variants using gatk's ReadBackedPhasing
java -jar ${gatk} -T ReadBackedPhasing \
-R ${gatk_bundle}/hg38.fa \
-I ${tumor_dir}/WES-Tumor_dedup_bqsr.bam \
--variant ${outdir}/01_combined_germline_somatic_sorted.vcf \
-L ${outdir}/01_combined_germline_somatic_sorted.vcf \
-o ${outdir}/02_phased.vcf


bgzip -c ${outdir}/02_phased.vcf > ${outdir}/02_phased.vcf.gz
tabix -p vcf ${outdir}/02_phased.vcf.gz

