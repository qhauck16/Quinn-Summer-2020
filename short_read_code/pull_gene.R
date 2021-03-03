#run after short_read_deseq, will display stats about any gene you want
rownames(res) <- (str_split_fixed(rownames(res),'\\|',2)[, 2])
pull_gene <- function(gene_name){
  specific_gene_df <- res[grepl(gene_name, rownames(res)),]
  print(specific_gene_df)
}