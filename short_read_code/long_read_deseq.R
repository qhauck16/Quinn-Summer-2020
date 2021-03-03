library(DESeq2)

##import prepde gene matrices
countData <- as.matrix(read.csv("/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/long_read_gtfs/genes/all_muscle.csv", row.names="gene_id"))
colData <- read.csv('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/pheno_data_liver', sep=" ", row.names=1)
dds <- DESeqDataSetFromMatrix(countData = countData, colData = colData, design = ~condition)
dds <- DESeq(dds)
long_read_res<- results(dds)


##order by adjusted p value
long_read_resOrdered <- long_read_res[order(long_read_res$padj), ]
head(long_read_resOrdered)