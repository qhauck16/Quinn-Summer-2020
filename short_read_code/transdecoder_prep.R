##takes all the unclassified genes in our gtf with a q-value less than .1 
##uses res table to sort, filters for completely unclassified, samples from gtf

##load HMB annotation
muscle_genes <- read.gtf('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/HMB.annotation.gtf')

##separate into just those with auto-gen gene names
unclassified_genes <- resOrdered[!grepl('\\|', rownames(resOrdered)),]
unclassified_genes <- unclassified_genes[!is.na(unclassified_genes$padj),]
unclassified_genes_df <- as.data.frame(unclassified_genes) %>%
  filter(padj <= 0.1)

subset_gtf <- subset(muscle_genes, gene_id %in% rownames(unclassified_genes_df))

genes_of_interest <- subset_gtf %>%
  dplyr::select(gene_id, transcript_id)
genes_of_interest <- distinct(genes_of_interest)

##file now stores overall gene_ids that are unclassified and potentially statistically significant
write(genes_of_interest$transcript_id, '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/unclassified_genes_2/transcripts_of_interest')