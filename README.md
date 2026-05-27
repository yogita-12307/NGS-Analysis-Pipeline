# 🧬 Whole Exome Sequencing (WES) Variant Calling Workflow

## Overview

This project presents a **Linux-based bioinformatics workflow** for processing and analyzing **Whole Exome Sequencing (WES) paired-end DNA data**. The pipeline covers data retrieval, quality control, preprocessing, alignment, and variant calling using widely used open-source tools.

The workflow is designed to be reproducible, modular, and suitable for human exome variant analysis.

---

## 📊 Dataset Information

- **Accession ID:** SRR24555538  
- **Organism:** Homo sapiens  
- **Data Type:** Genomic DNA (Whole Exome Sequencing)  
- **Sequencing Platform:** Illumina short-read sequencing  
- **Layout:** Paired-end (R1 / R2)  
- **Study Context:** Exome-Seq of lower lung SCM clone of cystic fibrosis patient 4 at stem cell level  

---

## 🧬 Sequencing Type

- Whole Exome Sequencing (WES)
- DNA sequencing (not RNA-seq)
- Paired-end reads for improved alignment accuracy

---

## ⚙️ Workflow Summary

The pipeline follows the standard NGS analysis flow:

```
Raw FASTQ → QC → Trimming → Alignment → BAM Processing → Variant Calling
```

---

## 🛠️ Tools Used

| Tool | Purpose |
|------|--------|
| SRA Toolkit | Download sequencing data |
| FastQC | Quality control |
| fastp | Adapter trimming & filtering |
| Bowtie2 | Read alignment |
| SAMtools | BAM processing |
| BCFtools | Variant calling |

---

## 📁 Repository Structure

```
WXS-Variant-Calling/
│
├── README.md
├── commands.sh
├── environment.yml
├── .gitignore
│
├── config/
│   ├── config.yaml
│   └── samplesheet.csv
│
├── docs/
│   ├── methodology.md
│   └── benchmark_results.md
│
├── results/
│   ├── qc/
│   ├── alignment/
│   ├── variants/
│   └── reports/
│
├── screenshots/
└── scripts/
```

---

## 🚀 How to Run the Workflow

### 1. Create environment

```bash
conda env create -f environment.yml
conda activate wxs_env
```

---

### 2. Execute pipeline

All steps are included in a single script:

```bash
bash commands.sh
```

---

## 🧪 Detailed Workflow Steps

### 1. Download sequencing data

```bash
fasterq-dump SRR24555538
```

---

### 2. Quality control

```bash
fastqc SRR24555538_1.fastq SRR24555538_2.fastq
```

---

### 3. Read trimming

```bash
fastp \
-i SRR24555538_1.fastq \
-I SRR24555538_2.fastq \
-o SRR24555538_1_trimmed.fastq \
-O SRR24555538_2_trimmed.fastq
```

---

### 4. Alignment to reference genome

```bash
bowtie2 \
-x hg38_index \
-1 SRR24555538_1_trimmed.fastq \
-2 SRR24555538_2_trimmed.fastq \
-S SRR24555538.sam
```

---

### 5. Convert, sort, and index BAM

```bash
samtools view -bS SRR24555538.sam > SRR24555538.bam

samtools sort SRR24555538.bam -o SRR24555538_sorted.bam

samtools index SRR24555538_sorted.bam
```

---

### 6. Variant calling

```bash
bcftools mpileup \
-Ou \
-f hg38.fa \
SRR24555538_sorted.bam | \
bcftools call \
-mv \
-Ov \
-o SRR24555538.vcf
```

---

## 📈 Output Files

The pipeline generates:

- Quality control reports (FastQC)
- Trimmed FASTQ files
- SAM/BAM alignment files
- Sorted and indexed BAM files
- Variant call file (VCF)

---

## 🧠 Key Features

- Paired-end WES data processing
- Human genome alignment (hg38)
- Standardized Linux-based workflow
- Reproducible command-line pipeline
- Modular project structure

---

## 📊 Performance Notes

Execution time depends on:

- Sequencing depth
- System CPU and RAM
- Disk I/O speed
- Reference genome indexing

---

## 📦 Future Improvements

- Variant annotation (ANNOVAR / VEP)
- Structural variant detection
- Multi-sample analysis
- Workflow automation using Snakemake or Nextflow
- Docker containerization


