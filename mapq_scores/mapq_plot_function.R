mapq_plot <- function(tsv, hbird){
  df <- read_tsv(tsv)
  colnames(df) <- 'mapq_score'
ggplot(df, aes(x = mapq_score))+
  geom_histogram(fill = 'dark blue')+theme_bw()+
  labs(title = paste('Log10 count of ', hbird, 'methylation mapq scores'), xlab = 'mapq score', ylab = 'log10 count')+scale_y_log10()
}