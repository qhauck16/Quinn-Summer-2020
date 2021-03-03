library(EnhancedVolcano)

##assumes environment has res loaded from short_read_deseq.R (liver or muscle)
rownames(res) <- (str_split_fixed(rownames(res),'\\|',2)[, 2])
EnhancedVolcano(res,
                lab = rownames(res),
                x = 'log2FoldChange',
                y = 'padj',
                title = 'Hbird muscle genes', 
                pCutoff = 0.1,
                selectLab = c('G0S2', 'ANGPTL4', 'PPP1R3B')
                )

res <- res[!is.na(res$pvalue),]
res <- res[!is.na(res$log2FoldChange)]
res_filtered <- res[res$pvalue <= 10e-6,]
res_filtered_2 <- res_filtered[abs(res_filtered$log2FoldChange) >= 1,]
view(res_filtered_2)

##write.xlsx(as.data.frame(res_filtered_2), file = '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/diff_genes.xlsx', row.names = TRUE)