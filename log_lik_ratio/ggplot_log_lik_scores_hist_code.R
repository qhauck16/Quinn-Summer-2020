scores <- read_tsv('log_lik_scores_output.txt')
scores <- scores %>%
    filter(log_lik_ratio <=20 & log_lik_ratio >= -20)
scores <- sample_n(scores, 10000)
ggplot(scores, aes(x = log_lik_ratio))+
  geom_histogram(binwidth = 0.666667, color = 'blue', fill = 'blue')+
  geom_vline(xintercept = -2.5, color = 'red')+
  geom_vline(xintercept = 2.5, color = 'red')