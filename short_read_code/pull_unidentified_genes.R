##takes the top 4 unidentified genes from res object and pulls sequences
##generates file to be processed and examined further, pull from fasta using samtools faidx
muscle_genes <- read.gtf('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/HMB.annotation.gtf')

unidentified <- top30_padj[c(5,9,16,30),]

unidentified_gtf <- subset(muscle_genes, gene_id %in% rownames(unidentified))

unidentified_gtf <- unidentified_gtf %>%
  filter(feature == 'exon')
unidentified_gtf <- distinct(unidentified_gtf)


storage <- c()
for (i in 1:length(unidentified_gtf$transcript_id)){
  identifier <- paste0(unidentified_gtf$seqname[i], ":", unidentified_gtf$start[i], "-", unidentified_gtf$end[i])
  storage[i] <- identifier
}

write(storage, '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/uncharacterized_sig_genes_exons')