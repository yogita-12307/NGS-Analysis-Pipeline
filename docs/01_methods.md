# Methods

## Dataset
This project analyzes Whole Exome Sequencing (WES) data from a human sample (SRR24555538). The data consists of paired-end Illumina reads.

## Reference Genome
The GRCh38/hg38 reference genome is used for alignment and is accessed from a shared server via symbolic linking.

## Workflow
The analysis pipeline includes:
- Data retrieval (SRA Toolkit)
- Quality control (FastQC)
- Trimming (fastp)
- Alignment (Bowtie2)
- BAM processing (SAMtools)
- Variant calling (BCFtools)

## Alignment Status
Bowtie2 alignment is currently in progress and under troubleshooting.

## Goal
To identify SNPs and indels from exome sequencing data.
