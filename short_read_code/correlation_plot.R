#Assumes we have run either liver or muscle short_read_deseq

rlog_dds <- rlog(dds)
rld_mat <- assay(rlog_dds)
rld_cor <- cor(rld_mat)
pheatmap(rld_cor)