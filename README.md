# 🧬 WES-BioPipeline: Human Whole Exome Sequencing Workflow

[![Linux](https://img.shields.io/badge/Platform-Linux-luc.svg?style=flat-shiled&logo=linux)](https://www.linux.org/)
[![Bioinformatics](https://img.shields.io/badge/Domain-Bioinformatics-lightblue.svg)](#)
[![Workflow](https://img.shields.io/badge/Pipeline-Manual--CLI-orange.svg)](#)

A reproducible, production-ready bioinformatics pipeline for analyzing human Whole Exome Sequencing (WES) data. This workflow processes raw Next-Generation Sequencing (NGS) reads from a Linux command-line environment, taking data from raw FASTQ format all the way to high-confidence Variant Call Files (VCF).

---

## 📊 Dataset Information

The pipeline is validated using a public dataset associated with stem cell-derived exome research in cystic fibrosis.

| Attribute | Details |
| :--- | :--- |
| **Accession ID** | `SRR24555538` |
| **Organism** | *Homo sapiens* |
| **Data Type** | Whole Exome Sequencing (WES) |
| **Sequencing Platform** | Illumina |
| **Layout** | Paired-end |

---

## 🔄 Workflow Summary

```text
  [ FASTQ ] ──> [ Quality Control ] ──> [ Trimming & Filtering ] 
                                                   │
  [ Variant Calling ] <── [ BAM Processing ] <── [ Alignment (hg38) ]
          │
      [ VCF ]

# 2️⃣ Quality Control

fastqc SRR24555538_1.fastq SRR24555538_2.fastq

3️⃣ Read Trimming & Filtering
fastp \
  -i SRR24555538_1.fastq \
  -I SRR24555538_2.fastq \
  -o SRR24555538_1_trimmed.fastq \
  -O SRR24555538_2_trimmed.fastq

4️⃣ Alignment to Reference Genome
bowtie2 \
  -x hg38_index \
  -1 SRR24555538_1_trimmed.fastq \
  -2 SRR24555538_2_trimmed.fastq \
  -S SRR24555538.sam

5️⃣ BAM Processing
samtools view -bS SRR24555538.sam > SRR24555538.bam
samtools sort SRR24555538.bam -o SRR24555538_sorted.bam
samtools index SRR24555538_sorted.bam

6️⃣ Variant Calling
bcftools mpileup -Ou -f hg38.fa SRR24555538_sorted.bam | bcftools call -mv -Ov -o SRR24555538.vcf
🧬 Reference Genome

GRCh38 / hg38 (centrally indexed for reproducibility and storage efficiency in shared compute environments)

📁 Repository Structure
.
├── config/
├── data/metadata/
├── docs/
├── results/
└── workflow/

📦 Outputs

FastQC quality reports
Trimmed FASTQ files
SAM/BAM alignment files
Sorted & indexed BAM files
Final VCF variant calls

🧠 Reproducibility & Portability

Linux/Unix native execution
Modular stepwise pipeline design
HPC-ready (Slurm/SGE compatible)
Easy migration to Nextflow/Snakemake
Clear input/output separation for each stage

##🚀 *Future Roadmap*
Variant annotation (VEP / ANNOVAR)
Structural variant detection (Manta, DELLY)
Cohort-scale joint genotyping
Full workflow automation (Nextflow / Snakemake)
Containerization (Docker / Singularity)

🏷️ Keywords

#Bioinformatics #NGS #Genomics #VariantCalling #VCF #BAM #SAMtools #BCFtools #Bowtie2 #FastQC #Fastp #SRA #GRCh38 #WES #WholeExomeSequencing #ComputationalBiology #Pipeline #ReproducibleResearch #Linux #HPC #OpenSource










      
