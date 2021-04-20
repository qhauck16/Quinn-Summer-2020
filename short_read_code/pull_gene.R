#run after short_read_deseq, will display stats about any gene you want
rownames(res) <- (str_split_fixed(rownames(res),'\\|',2)[, 2])
pull_gene <- function(gene_name){
  specific_gene_df <- res[grepl(gene_name, rownames(res)),]
  print(specific_gene_df)
}
write.xlsx(pull_gene('SLC2A'), '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/muscle_glut.xlsx')
