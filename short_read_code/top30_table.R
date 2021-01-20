##takes table from short_read_deseq.R and write it to excel file 
top30_padj <- resOrdered[1:30,]
write.xlsx(top30_padj, '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/padj_genes_updated.xlsx', row.names = TRUE)