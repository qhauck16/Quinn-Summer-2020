#!/bin/bash

in_illumina=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/*.bam
in_nanopore=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/deSALT/*.bam

for file in $in_illumina
do
	base=$(basename ${file})
	/home/roham/software/stringtie/stringtie ${file} -G /dilithium/Data/Nanopore/Analysis/quinn/SIRV/SIRV_isoforms_multi-fasta-annotation_C_170612a.gtf --conservative -o /dilithium/Data/Nanopore/Analysis/quinn/SIRV/quantification/illumina/${base}.gtf  -p 50 -e -A /dilithium/Data/Nanopore/Analysis/quinn/SIRV/quantification/${base}_abun.txt -v
done

for file in $in_nanopore
do
        base=$(basename ${file})
        /home/roham/software/stringtie/stringtie ${file} -G /dilithium/Data/Nanopore/Analysis/quinn/SIRV/SIRV_isoforms_multi-fasta-annotation_C_170612a.gtf --conservative -o /dilithium/Data/Nanopore/Analysis/quinn/SIRV/quantification/nanopore/${base}.gtf  -p 50 -e -A /dilithium/Data/Nanopore/Analysis/quinn/SIRV/quantification/${base}_abun.txt -v
done

