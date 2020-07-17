#!/bin/bash

in=/uru/Data/NGS/Raw/200225_hbird_liver/200225_hbird_liver/200225_hbird_liver/trim/*2_out_paired.fq.gz
out=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/liver
index=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/index
string="1_out"
for gz in $in 
do
	base=$(basename ${gz})
	echo $base
	base_paired=${base/2_out/$string}
	paired=/uru/Data/NGS/Raw/200225_hbird_liver/200225_hbird_liver/200225_hbird_liver/trim/${base_paired}
	echo $paired
	~/software/hisat2-2.2.0/hisat2 --threads 36 -x /dilithium/Data/Nanopore/Analysis/quinn/SIRV/hisat2/index/hbird -1 $paired -2 ${gz} -S ${out}/temp.sam
	samtools view -S -b ${out}/temp.sam | samtools sort -o ${out}/${base}.bam
        rm ${out}/temp.sam	


done	
echo "finished"
