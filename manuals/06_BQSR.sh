#!/bin/bash

echo "You need to assign your sample type (Normal or Tumor)."

if [ ${1} = "Normal" ] || [ ${1} = "Tumor" ]
then
    path=/home/00_TeamProject/01_WES_${1}
    refdir=/home/00_TeamProject/reference
    RNAdir=${refdir}/rna
    hg38_bundle=${refdir}/hg38_bundle
    gatk_bundle=${refdir}/gatk_bundle
    inputdir=${path}/05_DeDuplicate
    outdir=${path}/06_BQSR
    picard=/home/00_TeamProject/tools/picard/build/libs/picard.jar
    gatk=/home/00_TeamProject/tools/gatk-3.8.1/GenomeAnalysisTK.jar
    
    mkdir -P ${gatk_bundle}
    mkdir -p ${outdir}
    
    # download dbsnp_146.hg38.vcf.gz
    #wget -P ${gatk_bundle}/ ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/dbsnp_146.hg38.vcf.gz
    
    # download Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
    #wget -P ${gatk_bundle}/ ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
    
    # make hg38.dict & hg38.fa.fai to recalibrate
    #cp ${RNAdir}/hg38.fa ${gatk_bundle}/
    #cp ${RNAdir}/hg38.fa.fai ${gatk_bundle}/
    #java -jar ${picard} CreateSequenceDictionary -R ${gatk_bundle}/hg38.fa -O ${gatk_bundle}/hg38.dict
     
    # generate idx for 
    #tabix -p vcf ${gatk_bundle}/af-only-gnomad.hg38.vcf.gz
    #tabix -p vcf ${gatk_bundle}/CosmicCodingMuts.vcf.gz
    #tabix -p vcf ${gatk_bundle}/dbsnp_146.hg38.vcf.gz
    #tabix -p vcf ${gatk_bundle}/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
    
    # gatk BaseRecalibrator
    java -jar ${gatk} -T BaseRecalibrator -R ${hg38_bundle}/hg38.fa \
    -knownSites ${gatk_bundle}/dbsnp_146.hg38.vcf.gz \
    -knownSites ${gatk_bundle}/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz \
    -I ${inputdir}/${1}_dedup.bam -o ${outdir}/${1}_dedup_bqsr.table
    
    # apply recalibrated base quality to deduplicated bam file
    java -jar ${gatk} -T PrintReads -BQSR ${outdir}/${1}_dedup_bqsr.table -I ${inputdir}/${1}_dedup.bam \
    -o ${outdir}/${1}_dedup_bqsr.bam -R ${hg38_bundle}/hg38.fa
    
    # create bam file index for gatk
    java -jar ${picard} BuildBamIndex I=${outdir}/${1}_dedup_bqsr.bam
else
    echo "sample type error."
fi
