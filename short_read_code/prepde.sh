#!/bin/bash 
directory_bam=/uru/Data/Nanopore/Analysis/gmoney/hbird/nanopore_rna/bam/hisat2_scoremin_k/primary/L*.bam

for bam in $directory_bam
do
        base=$(basename ${bam})
        echo ${base}
        echo beginning stringtie with ${base}
        ~/software/stringtie/stringtie ${bam} -G /uru/Data/Nanopore/Analysis/gmoney/hbird/210114_aliana_annotation/acolubris_masurca_ragoo_v2.gff -p 48 -e -o /dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/liver_gtfs_210114/${base}.gtf
        echo done with stringtie
done

