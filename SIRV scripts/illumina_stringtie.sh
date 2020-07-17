#!/bin/bash

#First stringtie alignment for illumina hisat runs using SIRV gtf as a guide

in_muscle=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/muscle/*.bam
in_liver=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/liver/*.bam
guide=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/SIRV_isoforms_multi-fasta-annotation_C_170612a.gtf

for bam in $in_muscle
do 
	~/software/stringtie/stringtie ${bam} -o /dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/muscle/$(basename ${bam})_1.gtf --conservative -L -G $guide -p 24 -B -A /dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/muscle/$(basename ${bam})_1.abun -v 
done	

for bam in $in_liver
do
	~/software/stringtie/stringtie ${bam} -o /dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/liver/$(basename ${bam})_1.gtf --conservative -L  -G $guide -p 24 -B -A /dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/liver/$(basename ${bam})_1.abun -v
done
