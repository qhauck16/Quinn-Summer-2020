all_deg_gene_plot <- function(extend, type_of_regulation){
  if(type_of_regulation == 'up'){
  transcript_info <- full_transcript_info %>%
    filter(log2FoldChange >= 0)
  }
  else if (type_of_regulation == 'down'){
    transcript_info <- full_transcript_info %>%
      filter(log2FoldChange <= 0)
  }
  nrows <- nrow(transcript_info)
  tss_df <- data.frame(distance_from_tss = integer(),smooth = double(), bird = character())
  for (val in 1:nrow(transcript_info)){
    gene_info <- transcript_info[val,]
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
    colnames(mg96_smooth_region) <- c('smooth','bird')
    colnames(mg98_smooth_region) <- c('smooth','bird')
    
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
    full_data <- rbind(mg98_gene_meth_full, mg96_gene_meth_full) %>%
      select (distance_from_tss, smooth, bird)
    tss_df <- rbind(tss_df, full_data)
  }
  ##exited the for loop, all tss and smooth values should be in tss_df
  
 ##tss_df <- tss_df %>%
    ##group_by(distance_from_tss, bird) %>%
    ##summarize(average_meth = mean(smooth))

  ##plotting, now that we have all possible tss values associated with average methylation
  
  ggplot(tss_df, aes(x = distance_from_tss, y = smooth))+
    geom_smooth(aes(color = bird), se=FALSE)+
    labs(title = paste('Methylation for',type_of_regulation,'-regulated genes'), x = paste('distance from TSS', '(bp)'), y = 'smoothed methylation value')+
    annotate("text", label = paste("number of genes", nrows), x = 0.8* extend, y = 0.1)
}
