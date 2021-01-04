top30_padj <- resOrdered[1:30,]
write.xlsx(top30_padj, '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/padj_genes.xlsx', row.names = TRUE)