#!/bin/bash 
#takes in a gtf and fasta and outputs a transdecoder file 

name="${1:0:-4}"

/home/gmoney/repos/TransDecoder-TransDecoder-v5.5.0/util/gtf_genome_to_cdna_fasta.pl $1 $2 > ${name}.fasta
/home/gmoney/repos/TransDecoder-TransDecoder-v5.5.0/util/gtf_to_alignment_gff3.pl $1 > ${name}.gff3
/home/gmoney/repos/TransDecoder-TransDecoder-v5.5.0/TransDecoder.LongOrfs -t ${name}.fasta
/home/gmoney/repos/TransDecoder-TransDecoder-v5.5.0/TransDecoder.Predict -t ${name}.fasta 
/home/gmoney/repos/TransDecoder-TransDecoder-v5.5.0/util/cdna_alignment_orf_to_genome_orf.pl \
     ${name}.fasta.transdecoder.gff3 \
     ${name}.gff3 \
     ${name}.fasta > ${name}.fasta.transdecoder.genome.gff3
