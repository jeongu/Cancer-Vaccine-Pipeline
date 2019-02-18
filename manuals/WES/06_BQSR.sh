#!/bin/bash

echo "You need to assign your sample type (Normal or Tumor)."

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    home=/home/01_Neoantigen
    gatk=${home}/tools/gatk-4.1.0.0/gatk 
    refdir=${home}/reference
    gatk_bundle=${refdir}/gatk_bundle
    inputdir=${home}/01_WES_${1}/05_DeDuplicate
    outdir=${home}/01_WES_${1}/06_BQSR
    
    mkdir -P ${gatk_bundle}
    mkdir -p ${outdir}
    
    # download dbsnp_146.hg38.vcf.gz
    #wget -P ${gatk_bundle}/ ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/dbsnp_146.hg38.vcf.gz
    
    # download Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
    #wget -P ${gatk_bundle}/ ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
    
    # make hg38.dict & hg38.fa.fai to recalibrate
    #${gatk} CreateSequenceDictionary -R ${gatk_bundle}/hg38.fa -O ${gatk_bundle}/hg38.dict
    #samtools faidx ${gatk_bundle}/hg38.fa
    
    # or download .dict & .fai files 
    #wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/ucsc.hg38.dict.gz -O ${gakt_bundle}/hg38.dict.gz
    #wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/ucsc.hg38.fasta.fai.gz -O ${gatk_bundle}/hg38.fa.fai.gz
    
    # generate index for vcf.gz files
    #tabix -p vcf ${gatk_bundle}/af-only-gnomad.hg38.vcf.gz
    #tabix -p vcf ${gatk_bundle}/CosmicCodingMuts.vcf.gz
    #tabix -p vcf ${gatk_bundle}/dbsnp_146.hg38.vcf.gz
    #tabix -p vcf ${gatk_bundle}/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
    
    # need  vcf.idx
    #${gatk} IndexFeatureFile -F Mills_and_1000G_gold_standard.indels.hg19.sites.vcf
    #${gatk} IndexFeatureFile -F dbsnp_138.hg19.vcf
    
    # or download vcf.idx
    #wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg19/dbsnp_138.hg19.vcf.idx.gz
    #wget ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg19/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf.idx.gz   
    
    # gatk BaseRecalibrator
    #${gatk} BaseRecalibrator -R ${gatk_bundle}/hg38.fa \
    #--known-sites ${gatk_bundle}/dbsnp_146.hg38.vcf.gz \
    #--known-sites ${gatk_bundle}/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz \
    #-I ${inputdir}/WES-${1}_dedup.bam -O ${outdir}/WES-${1}_dedup_bqsr.table
    
    # apply recalibrated base quality to deduplicated bam file
    ${gatk} ApplyBQSR -bqsr ${outdir}/WES-${1}_dedup_bqsr.table -I ${inputdir}/WES-${1}_dedup.bam \
    -O ${outdir}/WES-${1}_dedup_bqsr.bam -R ${gatk_bundle}/hg38.fa
    
    # create bam file index for gatk
    ${gatk} BuildBamIndex -I ${outdir}/WES-${1}_dedup_bqsr.bam
else
    echo "sample type error."
fi
