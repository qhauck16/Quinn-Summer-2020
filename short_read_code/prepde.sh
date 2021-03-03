#!/bin/bash 
directory_bam=/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/nanopore_bams/*primary*.bam

for bam in $directory_bam
do
        base=$(basename ${bam})
        echo ${base}
        echo beginning stringtie with ${base}
        ~/software/stringtie/stringtie ${bam} -G /uru/Data/Nanopore/Analysis/gmoney/hbird/210114_aliana_annotation/acolubris_masurca_ragoo_v2.gff -p 48 -e -o /dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/long_read_gtfs/${base}.gtf
        echo done with stringtie
done

