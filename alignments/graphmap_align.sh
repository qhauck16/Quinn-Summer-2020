#!/bin/bash
ref=/uru/Data/Nanopore/Analysis/quinn/hbird/acolubris.fasta
in=/dilithium/Data/Nanopore/projects/ruby/200426_rebasecall/fastq/*all.fastq
out=/uru/Data/Nanopore/Analysis/quinn/hbird/graphmap


for fastq in $in;
do
        base=$(basename $fastq "*.fastq")
        echo $base
        ~/graphmap2/bin/Linux-x64/graphmap2  align -r $ref -d ${fastq} -o | samtools view -S -b  | samtools sort -o ${out}/${base}.bam
        samtools index ${out}/${base}.bam
done
