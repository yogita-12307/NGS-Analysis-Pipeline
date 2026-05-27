#!/bin/bash

# WES Variant Calling Pipeline
# Sample: SRR24555538
# =========================

set -e

echo "Starting WES pipeline..."

# 1. Download data
# -------------------------
echo "Downloading SRA data..."
fasterq-dump SRR24555538

# 2. Quality Control
# -------------------------
echo "Running FastQC..."
fastqc SRR24555538_1.fastq SRR24555538_2.fastq

# 3. Trimming
# -------------------------
echo "Running fastp..."
fastp \
-i SRR24555538_1.fastq \
-I SRR24555538_2.fastq \
-o SRR24555538_1_trimmed.fastq \
-O SRR24555538_2_trimmed.fastq

# 4. Alignment
# -------------------------
echo "Aligning with Bowtie2..."
bowtie2 \
-x hg38_index \
-1 SRR24555538_1_trimmed.fastq \
-2 SRR24555538_2_trimmed.fastq \
-S SRR24555538.sam

# 5. SAM to BAM
# -------------------------
echo "Converting SAM to BAM..."
samtools view -bS SRR24555538.sam > SRR24555538.bam

# 6. Sorting BAM
# -------------------------
echo "Sorting BAM..."
samtools sort SRR24555538.bam -o SRR24555538_sorted.bam

# 7. Indexing BAM
# -------------------------
echo "Indexing BAM..."
samtools index SRR24555538_sorted.bam

# 8. Variant Calling
# -------------------------
echo "Calling variants..."
bcftools mpileup \
-Ou \
-f hg38.fa \
SRR24555538_sorted.bam | \
bcftools call \
-mv \
-Ov \
-o SRR24555538.vcf

echo "Pipeline completed successfully!"
