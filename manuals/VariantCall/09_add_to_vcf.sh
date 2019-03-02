#!/bin/bash

path=/home/01_Neoantigen
cov_indir=${path}/02_VariantCall/07_Variant_coverage
vcf_indir=${path}/02_VariantCall/06_annotate_VEP
rna_dir=${path}/01_RNA/04_StringTie


outdir=${path}/02_VariantCall/08_add_coverage_vcf
outfn1=01_cov_Nor_indel.vcf
outfn2=02_cov_Nor_snp.vcf
outfn3=03_cov_Nor_Tum_indel.vcf
outfn4=04_cov_Nor_Tum_snp.vcf
outfn5=05_cov_Nor_Tum_RNA_indel.vcf
outfn6=06_cov_Nor_Tum_RNA_snp_final.vcf
outfn7=07_somatic.vcf

#mkdir -p ${outdir}


# add coverage information to vcf
#vcf-readcount-annotator ${vcf_indir}/union_annotated.vcf ${cov_indir}/Normal_WES_indel_readcount DNA -s NORMAL -t indel -o ${outdir}/${outfn1}
#vcf-readcount-annotator ${outdir}/${outfn1} ${cov_indir}/Normal_WES_snp_readcount DNA -s NORMAL -t snv -o ${outdir}/${outfn2}
#vcf-readcount-annotator ${outdir}/${outfn2} ${cov_indir}/Tumor_WES_indel_readcount DNA -s TUMOR -t indel -o ${outdir}/${outfn3}
#vcf-readcount-annotator ${outdir}/${outfn3} ${cov_indir}/Tumor_WES_snp_readcount DNA -s TUMOR -t snv -o ${outdir}/${outfn4}
#vcf-readcount-annotator ${outdir}/${outfn4} ${cov_indir}/Tumor_RNA_indel_readcount RNA -s TUMOR -t indel -o ${outdir}/${outfn5}
#vcf-readcount-annotator ${outdir}/${outfn5} ${cov_indir}/Tumor_RNA_snp_readcount RNA -s TUMOR -t snv -o ${outdir}/${outfn6}

# add expression information to vcf
vcf-expression-annotator -s TUMOR -o ${outdir}/${outfn7} ${outdir}/${outfn6} ${rna_dir}/transcripts.gtf stringtie transcript

bgzip -c ${outdir}/07_somatic.vcf > ${outdir}/07_somatic.vcf.gz
tabix -p vcf ${outdir}/07_somatic.vcf.gz
