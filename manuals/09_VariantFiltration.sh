cd ~/projects

mkdir 11_VariantFiltration

gatk VariantFiltration --R ~/datasets/Homo_Sapiens/ucsc.hg19.fasta \
--V 10_GenotypeGVCF/NIST7035_haplocall.vcf \
--filter-name "FS" --filter "FS > 30.0" --filter-name "QD" --filter "QD < 2.0" \
-O 11_VariantFiltration/NIST7035_haplocall_filt.vcf

