library(pheatmap)
library(DESeq2)

##assumes environment has res and countData loaded from short_read_deseq.R

res <- res[!is.na(res$padj),]

res_filtered <- res[res$padj <= 0.008496075,]
res_filtered_2 <- res_filtered[abs(res_filtered$log2FoldChange) >= 1,]
genes <- rownames(res_filtered_2)

countData_filtered <- countData[match(genes, rownames(countData)),]
countData_filtered <- countData_filtered[!row.names(countData_filtered) %in% c('XLOC_017221|LOC115600345', 'XLOC_015093|G0S2'), ]
view(countData_filtered)



pheatmap(countData_filtered)