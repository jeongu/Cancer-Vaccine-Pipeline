samtools sort -o /home/01_Neoantigen/01_RNA/03_Align_hisat2/Cufflinks_RNA-Tumor.sortd.sam /home/01_Neoantigen/01_RNA/03_Align_hisat2/Cufflinks_RNA-Tumor.sam
samtools view -Su /home/01_Neoantigen/01_RNA/03_Align_hisat2/Cufflinks_RNA-Tumor.sortd.sam > /home/01_Neoantigen/01_RNA/03_Align_hisat2/Cufflinks_RNA-Tumor.sorted.bam
