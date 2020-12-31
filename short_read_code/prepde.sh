#!/bin/bash 

directory_bam=/uru/Data/Nanopore/Analysis/gmoney/hbird/nanopore_rna/bam/hisat2_scoremin_k/primary/m*.bam

for bam in directory_bam
do
	base=$(basename ${bam})
	echo ${base}
	/home/software/stringtie/stringtie ${bam} -G /dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/HMB.annotation.gtf -p 10 -A /dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/${base}.txt -e -o /dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/muscle_gtfs/${base}.gtf
	echo done with stringtie 
	echo ${base} /dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/muscle_gtfs/${base}.gtf > temp.txt
	/home/software/stringtie/prepDE.py -i temp.txt -g /dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/genes/${base}_genes.txt -t /dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/transcripts/${base}_genes.txt
	echo done with prepDE, moving to next file
	
