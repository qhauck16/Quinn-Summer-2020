#!/bin/bash

for gz in /uru/Data/Nanopore/projects/hummingbird/RNA/fastq/*.gz
do
	zcat ${gz} > /dilithium/Data/Nanopore/Analysis/quinn/SIRV/test_of_zcat_1
done
