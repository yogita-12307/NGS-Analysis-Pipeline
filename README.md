🧬 Whole Exome Sequencing (WES) Variant Calling Pipeline
📌 Overview

This repository contains a reproducible bioinformatics workflow for analyzing Whole Exome Sequencing (WES) data from a human sample using standard NGS tools in a Linux environment.

The pipeline performs quality control, preprocessing, alignment, and variant calling using widely adopted command-line tools.

📊 Dataset
Accession ID: SRR24555538
Organism: Homo sapiens
Data Type: Whole Exome Sequencing (WES)
Sequencing Type: Paired-end (Illumina)
Biological Context: Stem cell-derived exome sample associated with a cystic fibrosis research context
⚙️ Pipeline Workflow

The analysis workflow includes the following steps:

Raw data retrieval (SRA Toolkit)
Quality control (FastQC)
Adapter trimming and filtering (fastp)
Read alignment to reference genome (Bowtie2)
BAM file processing (SAMtools)
Variant calling (BCFtools)
🧬 Reference Genome

The GRCh38/hg38 human reference genome is used for alignment.
It is accessed from a shared server environment and linked into the project directory to ensure reproducibility.

📁 Repository Structure
config/          → configuration files and samplesheet
docs/            → methods, parameters, and interpretation notes
workflow/        → pipeline scripts and execution commands
data/metadata/   → dataset description and sample information
results/         → generated outputs (QC, BAM, VCF, reports)
📦 Key Outputs

The pipeline generates the following results:

Raw and processed quality control reports
Trimmed FASTQ files
Aligned BAM files
Sorted and indexed BAM files
Variant call file (VCF)
🧠 Notes on Reproducibility
All tools are run in a Linux-based environment
Steps are modular and can be executed independently
Outputs are structured for downstream interpretation and extension
🚀 Future Improvements
Variant annotation (VEP / ANNOVAR)
Structural variant detection
Multi-sample comparison workflow
Pipeline automation using Snakemake or Nextflow
Containerization using Docker for full reproducibility
