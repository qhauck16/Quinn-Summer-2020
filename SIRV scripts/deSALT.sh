#!/bin/bash

rna=/uru/Data/Nanopore/projects/hummingbird/RNA/fastq/*.gz
#ref=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/SIRV_isoforms_multi-fasta_170612a.fasta
out=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/deSALT/deSALT-1.5.4


for gz in $rna 
do
	echo "Hey there!"
	echo ${gz}
	zcat ${gz} > /dilithium/Data/Nanopore/Analysis/quinn/SIRV/temp.fastq
	echo "Next"
	/home/gmoney/repos/deSALT-1.5.4/src/deSALT aln -t 36 -x ont1d /dilithium/Data/Nanopore/Analysis/quinn/SIRV/deSALT/SIRV_index /dilithium/Data/Nanopore/Analysis/quinn/SIRV/temp.fastq -o ${out}/$(basename ${gz}).sam 
       	echo "Boop"
	samtools view -S -b ${out}/$(basename ${gz}).sam | samtools sort -o ${out}/$(basename ${gz}).bam 
	echo "wow"
	samtools index ${out}/$(basename ${gz}).bam	
rm /dilithium/Data/Nanopore/Analysis/quinn/SIRV/temp.fastq
done	
