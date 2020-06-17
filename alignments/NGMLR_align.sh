#!/bin/bash

ref=/uru/Data/Nanopore/Analysis/quinn/hbird/ngmlr/acolubris.fasta
in=/dilithium/Data/Nanopore/projects/ruby/200426_rebasecall/fastq/*_all.fastq
out=/uru/Data/Nanopore/Analysis/quinn/hbird/ngmlr
for fastq in $in;
do
        base=$(basename $fastq)
        echo $base
        ~/ngmlr/bin/ngmlr  -t 36 -r $ref -q ${fastq} -o /uru/Data/Nanopore/Analysis/quinn/hbird/ngmlr/${base}.sam -x ont
        samtools view -S -b /uru/Data/Nanopore/Analysis/quinn/hbird/ngmlr/${base}.sam | samtools sort -o ${out}/${base}_final.bam
        samtools index ${out}/${base}_final.bam
done

