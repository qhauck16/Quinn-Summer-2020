gene_tss_plot <- function(gene, extend){
  
  gene_info <- full_transcript_info %>%
    filter(gene == gene_id)
  
  if (gene_info$strand == '+'){
  start_coord <- (gene_info$start - extend)
  end_coord <- (gene_info$start + extend)
  chr <- gene_info$seqname
  new_df <- data.frame(chr, start_coord, end_coord)
  colnames(new_df) <- c('chr', 'start', 'end')
  
}else {
  start_coord <- (gene_info$end- extend)
  end_coord <- (gene_info$end + extend)
  chr <- gene_info$seqname
  new_df <- data.frame(chr, start_coord, end_coord)
  colnames(new_df) <- c('chr', 'start', 'end')
}

  mg96_smooth_region <- as.data.frame(getMeth(bs_mg96_smooth, regions = new_df, type = 'smooth', what = 'perBase')) %>%
    mutate(bird = 'mg96/fed')
  mg98_smooth_region <- as.data.frame(getMeth(bs_mg98_smooth, regions = new_df, type = 'smooth', what = 'perBase')) %>%
    mutate(bird = 'mg98/fasted')
  
  colnames(mg96_smooth_region) <- (c('smooth', 'bird'))
  colnames(mg98_smooth_region) <- (c('smooth', 'bird'))
  
  chrm <- chr
  
  mg96_gene_meth_full <- mg96_bismark %>%
    filter(chr == chrm & start_coord <= coord & coord <= end_coord) %>%
    cbind(mg96_smooth_region)
  
  mg98_gene_meth_full <- mg98_bismark %>%
    filter(chr == chrm & start_coord <= coord & coord <= end_coord) %>%
    cbind(mg98_smooth_region)
 if (gene_info$strand == '+'){
  mg96_gene_meth_full <- mg96_gene_meth_full %>%
    mutate(distance_from_tss = coord - gene_info$start )
  
  mg98_gene_meth_full <- mg98_gene_meth_full %>%
    mutate(distance_from_tss = coord - gene_info$start )
 } else{
    mg96_gene_meth_full <- mg96_gene_meth_full %>%
      mutate(distance_from_tss = -(coord - gene_info$end))
    
    mg98_gene_meth_full <- mg98_gene_meth_full %>%
      mutate(distance_from_tss = -(coord - gene_info$end))
}    
  full_data <- rbind(mg98_gene_meth_full, mg96_gene_meth_full)
  
  ggplot(full_data, aes(x = distance_from_tss, y = smooth))+
    geom_line(aes(color = bird))+
    geom_point(aes(color = bird))+
    labs(title = paste('Methylation around ', gene), x = paste('distance from TSS', '(bp)'), y = 'smoothed methylation value')+
    annotate('text', label = paste('log2FC =', gene_info$log2FoldChange), x = 0.6 * extend, y = Inf, vjust = 1)
}

  