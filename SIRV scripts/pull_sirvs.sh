#!/bin/bash

in_1=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/*.bam
in_2=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/deSALT/*.bam

for file in $in_1
do
	base=$(basename ${file})
	samtools view ${file} | awk '$3 != "*"{print $3}' >> /dilithium/Data/Nanopore/Analysis/quinn/SIRV/analysis/${base}_illumina_chrms.txt
done

for file in $in_2
do
	base=$(basename ${file})
        samtools view ${file} | awk  '$3 != "*"{print $3}' >> /dilithium/Data/Nanopore/Analysis/quinn/SIRV/analysis/${base}_nanopore_chrms.txt
done

