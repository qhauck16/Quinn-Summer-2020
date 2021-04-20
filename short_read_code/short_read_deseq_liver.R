library(DESeq2)

##import prepde gene matrices
countData <- as.matrix(read.csv("/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/liver_gtfs_210114/genes/all_liver.csv", row.names="gene_id"))
colData <- read.csv('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/pheno_data_liver', sep=" ", row.names=1)
dds <- DESeqDataSetFromMatrix(countData = countData, colData = colData, design = ~condition)
dds <- DESeq(dds)
res<- results(dds)


##order by adjusted p value
resOrdered <- res[order(res$padj), ]
head(resOrdered)
head(as.data.frame(countData))
test <- as.data.frame(countData)[grepl('G0S2', rownames(countData)),]