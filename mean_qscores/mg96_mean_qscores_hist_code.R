mg96_all_mean_qscores <- a_scores %>%
    rbind(bc_scores) %>%
    rbind(efg_scores) %>%
    rbind(d_scores)
head(mg96_all_mean_qscores)
ggplot(mg96_all_mean_qscores, aes(x=mean_qscore_template))+
  geom_histogram(binwidth = 0.666667)+
  labs(x = 'Mean qscores of reads')+
  ggtitle('Mean qscores of mg96 Nanopore Runs')