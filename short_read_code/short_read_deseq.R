library(DESeq2)

##import prepde gene matrices
countData <- as.matrix(read.csv("/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/genes/all_muscle.csv", row.names="gene_id"))
colData <- read.csv('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/pheno_data', sep=" ", row.names=1)
dds <- DESeqDataSetFromMatrix(countData = countData, colData = colData, design = ~condition)
dds <- DESeq(dds)
res<- results(dds)

##order by adjusted p value
resOrdered <- res[order(res$padj), ]
head(resOrdered)


