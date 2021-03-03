library(ggvenn)
#run short_read_deseq muscle then this
res_filtered <- as.data.frame(res) %>%
  filter(padj <= 0.1)
gene_list_muscle <- rownames(res_filtered)

#now run short_read_deseq_liver then this (I know its a stupid setup, but all other plots allow for both)

res_filtered <- as.data.frame(res) %>%
  filter(padj <= 0.1)
gene_list_liver <- rownames(res_filtered)

both <- list(`Muscle` = gene_list_muscle,
          `Liver` = gene_list_liver)
ggvenn(both, fill_color = c('blue', 'green'))