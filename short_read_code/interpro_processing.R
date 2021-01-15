post_transdecoder_genome_gff<- read.gtf('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/unclassified_genes/unclassified_threshold_genes.fasta.transdecoder.genome.gff3')
interpro_cols = c('ID', 'digest', 'length', 'analysis', 'accession', 'desc', 'start', 'end', 'score', 'status', 'date', 'interpro1', 'interpro2', 'GO', 'Pathways')
interproscan_results <- read.table('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/unclassified_genes/interproscan/unclassified_threshold_genes.fasta.transdecoder.pep_clean.pep.tsv', sep='\t', col.names = interpro_cols, fill = TRUE)

##Pull just those hit by Interpro from transdecoder genome gff, so we can find the relevant genes
just_prots_gff <- subset(post_transdecoder_genome_gff, ID %in% interproscan_results$ID)
just_prots_gff <- just_prots_gff %>%
  dplyr::select(ID, Parent)

## Add gene ID to interproscan results, filter by only what we're interested in
interproscan_results <- full_join(interproscan_results, just_prots_gff, by = 'ID')
interproscan_results <- interproscan_results %>%
  dplyr::select(-c(digest, date, Pathways))