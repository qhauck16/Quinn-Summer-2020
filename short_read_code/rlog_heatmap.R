library(pheatmap)
library(DESeq2)

##assumes environment has res and countData loaded from short_read_deseq.R

res <- res[!is.na(res$pvalue),]
res <- res[!is.na(res$log2FoldChange)]
res_filtered <- res[res$pvalue <= 10e-6,]
res_filtered_2 <- res_filtered[abs(res_filtered$log2FoldChange) >= 1,]
genes <- rownames(res_filtered_2)

rlog_data <- as.data.frame(assay(rlog(dds)))

rlog_data_filtered <- rlog_data[match(genes, rownames(rlog_data)),]

view(as.data.frame(rlog_data_filtered))


pheatmap(rlog_data_filtered)