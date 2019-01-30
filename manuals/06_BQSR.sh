#!/bin/bash

path='/home/00_TeamProject/01_WES_Normal'
refdir='/home/00_TeamProject/reference'
RNAdir=$refdir/rna
hg38_bundle=$refdir/hg38_bundle
gatk='/home/00_TeamProject/tools/gatk-4.0.12.0/gatk'
inputdir=$path/05_DeDuplicate
outdir=$path/06_BQSR

mkdir -P $hg38_bundle
mkdir -p $outdir

# download dbsnp_146.hg38.vcf.gz
wget -P $hg38_bundle/ ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/dbsnp_146.hg38.vcf.gz

# download Mills_and_1000G_gold_standard.indels.hg38.vcf.gz
wget -P $hg38_bundle/ ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz

# make hg38.dict & hg38.fa.fai to recalibrate
cp $RNAdir/hg38.fa $hg38_bundle/
cp $RNAdir/hg38.fa.fai $hg38_bundle/
$gatk CreateSequenceDictionary -R $hg38_bundle/hg38.fa -O $hg38_bundle/hg38.dict

# unzip vcf.gz
gunzip $hg38_bundle/Mills_and_1000G_gold_standard.indels.hg38.vcf.gz > $hg38_bundle/Mills_and_1000G_gold_standard.indels.hg38.vcf
gunzip $hg38_bundle/dbsnp_146.hg38.vcf.gz > $hg38_bundle/dbsnp_146.hg38.vcf

# generate vcf.idx
$gatk IndexFeatureFile -F $hg38_bundle/Mills_and_1000G_gold_standard.indels.hg38.vcf
$gatk IndexFeatureFile -F $hg38_bundle/dbsnp_146.hg38.vcf

# gatk BaseRecalibrator
$gatk BaseRecalibrator -I $inputdir/Normal_dedup.bam \
--known-sites $hg38_bundle/dbsnp_146.hg38.vcf \
--known-sites $hg38_bundle/Mills_and_1000G_gold_standard.indels.hg38.vcf \
-O $outdir/Normal_dedup_bqsr.table \
-R $hg38_bundle/hg38.fa

# apply recalibrated base quality to deduplicated bam file
$gatk ApplyBQSR -bqsr $outdir/Normal_dedup_bqsr.table -I $inputdir/Normal_dedup.bam \
-O $outdir/Normal_dedup_bqsr.bam -R $hg38_bundle/hg38.fa

