##assumes either liver or muscle short_read_deseq script has been run for environment
sig_genes_df <- as.data.frame(res) %>%
  filter(padj<=0.1)
rownames(sig_genes_df)<- str_split_fixed(rownames(sig_genes_df),'\\|',2)[,2]
panther_genes <- rownames(sig_genes_df)
write_tsv(as.data.frame(panther_genes), '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/GO_analysis/muscle_gene_ids.tsv')