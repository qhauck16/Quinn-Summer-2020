scores <- read.delim("/home/quinn/code/log_lik_scores_output.txt")
head(scores)
scores<- scores %>%
  filter(log_lik_ratio<=30 & log_lik_ratio >= -30)
hist(pull(scores), breaks = 50, main = 'Log Lik Ratio Scores between -30 and 30', xlab = 'Log Lik Ratio', xlim = range(-30,30))
abline(v=-2.5, col = 'blue')
abline(v=2.5, col = 'blue')
