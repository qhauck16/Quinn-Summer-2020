library(EnhancedVolcano)

##assumes environment has res loaded from short_read_deseq.R
EnhancedVolcano(res,
                lab = rownames(res),
                x = 'log2FoldChange',
                y = 'pvalue',
                title = 'Hbird muscle genes')

res <- res[!is.na(res$pvalue),]
res <- res[!is.na(res$log2FoldChange)]
res_filtered <- res[res$pvalue <= 10e-6,]
res_filtered_2 <- res_filtered[abs(res_filtered$log2FoldChange) >= 1,]
view(res_filtered_2)

##write.xlsx(as.data.frame(res_filtered_2), file = '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/diff_genes.xlsx', row.names = TRUE)