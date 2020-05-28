abcd_scores <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg98_abcd_mean_qscores.txt')
efg_scores_2 <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg98_efg_mean_qscores.txt')
mg98_all_mean_qscores <- abcd_scores %>%
    rbind(efg_scores_2)

ggplot(mg98_all_mean_qscores, aes(x = mean_qscore_template))+
    geom_histogram(binwidth = 0.666667, fill = 'dark blue')+
    labs(x = 'Mean qscores of Reads')+
    ggtitle('Mean qscores of mg98 Nanopore Runs')