#!/bin/bash



echo 'Index built'

echo 'Running Aligner'

for fastq in /dilithium/Data/Nanopore/projects/ruby/200426_rebasecall/fastq/*_all.fastq
do
	$index = "acolubris_masurca_ragoo"
	base=$(basename $fastq "*.fastq")
        echo $base
	~/build/maCMD -t 36 -x $index -i $fastq -o | samtools view -S -b | samtools sort -o /uru/Data/Nanopore/Analysis/quinn/hbird/MA/${base}.bam
	samtools index /uru/Data/Nanopore/Analysis/quinn/hbird/MA/${base}.bam

done
