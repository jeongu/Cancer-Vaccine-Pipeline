# download snpEff
cd ~/tool
wget http://sourceforge.net/projects/snpeff/files/snpEff_latest_core.zip



# unzip snpeff
unzip snpEff_latest_core.zip



# run snpEff
cd ~/projects

mkdir 12_Annotation

java -jar -Xmx10g ~/tool/snpEff/snpEff.jar -v hg19 \-s 12_Annotation/NIST7035_summary.html \
11_VariantFiltration/NIST7035_haplocall_filt.vcf > 12_Annotation/NIST7035_haplocall_ann.vcf 

