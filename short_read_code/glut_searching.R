anna_gtf <- read.gtf('/uru/Data/Nanopore/Analysis/gmoney/hbird/reference/GCF_003957555.1_bCalAnn1_v1.p_genomic.gff')
#function to search anna's hbird gtf for a specific gene
#first narrows gtf to just genes, then selects
#can also search for partial gene name, make sure to specify case

desired_gene_anna <- function(gene_name){
  just_gene_anna <- anna_gtf %>%
    filter(feature == 'gene')
  temp_gene_df <- just_gene_anna[grepl(gene_name, just_gene_anna$gene),]
  view(temp_gene_df)
}