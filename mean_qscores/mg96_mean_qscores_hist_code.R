a_scores <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg96_ruby_mean_qscores.txt')
bc_scores <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg96_bc_mean_qscores.txt')
d_scores <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg96_d_mean_qscores.txt')
efg_scores <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg96_efg_mean_qscores.txt')

mg96_all_mean_qscores <- a_scores %>%
    rbind(bc_scores) %>%
    rbind(efg_scores) %>%
    rbind(d_scores)
head(mg96_all_mean_qscores)
ggplot(mg96_all_mean_qscores, aes(x=mean_qscore_template))+
  geom_histogram(binwidth = 0.666667, fill = 'dark blue')+
  labs(x = 'Mean qscores of reads')+
  ggtitle('Mean qscores of mg96 Nanopore Runs')