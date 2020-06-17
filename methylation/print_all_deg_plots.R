for (val in 1:nrow(full_transcript_info)){ 
  print(gene_tss_plot(full_transcript_info$gene_id[val], 1200))
}