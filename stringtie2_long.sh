#!/bin/bash

$in_bam=/uru/Data/Nanopore/Analysis/gmoney/hbird/nanopore_rna/nanopore_desalt2-1.5.4_XS/$1
$in_guide=/uru/Data/Nanopore/Analysis/gmoney/hbird/annotation/unmasked/braker/augustus.hints.gtf
$out_gtf=/uru/Data/Nanopore/Analysis/quinn/hbird/$2
$test=~/code/hello_world.sh
~/software/stringtie/stringtie --conservative -L -G $in_guide -o $out_gtf $in_bam
