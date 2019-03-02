#!/bin/bash 
ref='/home/01_Neoantigen/reference/RNA/hg38.fa'
config='/home/01_Neoantigen/02_VariantCall/03_pindel/pindel_config.txt'
pindel_output='/home/01_Neoantigen/02_VariantCall/03_pindel/variant_pindel'
vcf_SI='/home/01_Neoantigen/02_VariantCall/03_pindel/variant_pindel_SI.vcf'
vcf_D='/home/01_Neoantigen/02_VariantCall/03_pindel/variant_pindel_D.vcf'

#samtools faidx ${ref}
pindel -f ${ref} -i ${config} -c ALL -o ${pindel_output} -T 3 
