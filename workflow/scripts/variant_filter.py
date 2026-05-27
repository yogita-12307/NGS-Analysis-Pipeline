# Variant Filtering Script
# =========================

input_vcf = "SRR24555538.vcf"
output_vcf = "SRR24555538_filtered.vcf"

MIN_QUAL = 30

with open(input_vcf, "r") as fin, open(output_vcf, "w") as fout:
    for line in fin:
        
        # Keep header lines
        if line.startswith("#"):
            fout.write(line)
            continue

        cols = line.strip().split("\t")

        # Quality score column in VCF
        qual = cols[5]

        # Filter missing values
        if qual == ".":
            continue

        # Apply quality filter
        if float(qual) >= MIN_QUAL:
            fout.write(line)

print("Filtering completed. Output saved to:", output_vcf)
