library(DESeq2)

##assumes short_read_deseq has been run

rlog_dds <- rlog(dds)
plotPCA(rlog_dds)