library(topGO)

#post_transdecoder_genome_gff<- read.gtf('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/unclassified_genes_2/HMB.annotation.fasta.transdecoder.genome.gff3')
interpro_cols = c('ID', 'digest', 'length', 'analysis', 'accession', 'desc', 'start', 'end', 'score', 'status', 'date', 'interpro1', 'interpro2', 'GO', 'Pathways')
interproscan_results <- read.table('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/GO_analysis/transcripts.fasta.transdecoder.pep_clean.pep.tsv', sep='\t', col.names = interpro_cols, fill = TRUE)

##filter just for prots with GO terms and only one per RNA/gene
interproscan_results <- interproscan_results[grepl('GO', interproscan_results$GO),]
interproscan_results <- distinct(interproscan_results, ID, .keep_all = TRUE)
interproscan_results <- interproscan_results %>%
  dplyr::select(ID, GO)

#syntax fixing to allow for joining with ruby_gtf with gene names
interproscan_results$ID <- str_split_fixed(interproscan_results$ID,'.p', 2)[,1]
ruby_gtf_filtered <- ruby_gtf[grepl('gene|rna', ruby_gtf$ID),]
ruby_gtf_filtered <- ruby_gtf_filtered %>%
  full_join(interproscan_results, by = 'ID') %>%
  dplyr::select(gene, GO) %>%
  filter(!is.na(GO))
#ruby_gtf_filtered <- distinct(ruby_gtf_filtered, gene, .keep_all = TRUE)

#syntax fix for TopGo requirement
ruby_gtf_filtered$GO <- str_replace_all(ruby_gtf_filtered$GO, '\\|', ', ')

gene_universe <- ruby_gtf_filtered#[!grepl('LOC', ruby_gtf_filtered$gene),]

#obtain list of differentially expressed genes from resOrdered
gene <- (str_split_fixed(rownames(resOrdered),'\\|',2)[, 2])
resOrdered_gene_added <- as.data.frame(resOrdered) %>%
  cbind(gene)
merged_GO_deseq <- left_join(ruby_gtf_filtered, resOrdered_gene_added, by = 'gene') %>%
  filter(padj <= 0.1)
merged_GO_deseq <- merged_GO_deseq[!grepl('LOC', merged_GO_deseq$gene),]
diff_genes <- merged_GO_deseq$gene

#establish topgo requirements
geneList <- factor(as.integer(gene_universe$gene %in% diff_genes))
names(geneList) <- gene_universe$gene

write_tsv(gene_universe, '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/GO_analysis/gene_universe.tsv')

geneID2GO <- readMappings(file = '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/GO_analysis/gene_universe.tsv')

#run topGO
myGOdata <- new("topGOdata", description="My project", ontology="BP", allGenes=geneList,  annot = annFUN.gene2GO, gene2GO = geneID2GO)

#get output we're looking for
resultFisher <- runTest(myGOdata, algorithm="classic", statistic="fisher")
allRes <- GenTable(myGOdata, classicFisher = resultFisher, orderBy = "resultFisher", ranksOf = "classicFisher", topNodes = 10)