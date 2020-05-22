#!/bin/bash 

#up there is the shebang line, it tells the computer what language this script is in (in this case the language is bash)
# make this file executable by running chmod +x bowtie_example on the command line, this file will turn green
# to run the file type ./bowtie_example on the command line 

echo "running bowtie2 alignment" # when you run this scrip it will print this text `

# run bowtie2 give path to your files and output the sam to your analysis directory in uru
bowtie2 -x example/index/lambda_virus -1 example/reads/reads_1.fq -2 example/reads/reads_2.fq -S /path/to/output/filename.sam 

# next you need to make the sam into a bam using samtools (lookup samtools commands to figure out how to do this)

# then you will need to use samtools sort to put the bam in order 

# then samtools index to index the bam file 

# then you can use other samtools commands to get statistics about the alignment 

# see if you can figure out what percent of the reads aligned to the data (do all this with samtools)
