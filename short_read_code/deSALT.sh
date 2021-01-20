#!/bin/bash

ref=/uru/Data/Nanopore/Analysis/gmoney/hbird/genome_asm_masurca/acolubris_masurca_ragoo_change_linewidth.fasta
fastq=/uru/Data/Nanopore/projects/hummingbird/RNA/fastq/*m*.fastq.gz
out=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/nanopore_bams

#~/repos/deSALT/src/deSALT index $ref /uru/Data/Nanopore/Analysis/gmoney/hbird/genome_asm_masurca/desalt_index


for file in $fastq
do
        echo $file
        base=$(basename "$file" .fastq.gz)
        echo $base
        /home/gmoney/repos/deSALT-1.5.4/src/deSALT aln /uru/Data/Nanopore/Analysis/gmoney/hbird/genome_asm_masurca/desalt_index $file -t 48 -x ont1d -o ${out}/${base}.sam
        samtools view -Sb ${out}/${base}.sam | samtools sort -o ${out}/${base}.bam
	rm ${out}/${base}.sam
        samtools index ${out}/${base}.bam
        samtools view -F 256 -b ${out}/${base}.bam > ${out}/${base}_primary.bam
        samtools index $out/${base}_primary.bam
done

