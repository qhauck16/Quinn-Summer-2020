log_lik_plot =function(tsv){
scores <- read_tsv(tsv)
scores <- scores %>%
    filter(log_lik_ratio <=20 & log_lik_ratio >= -20)
scores <- sample_n(scores, 100000)
ggplot(scores, aes(x = log_lik_ratio))+
  geom_histogram(binwidth = 0.666667, color = 'blue', fill = 'blue')+
  geom_vline(xintercept = -1.5, color = 'red')+
  geom_vline(xintercept = 1.5, color = 'red')+ theme_bw()+ ggtitle('log_lik_ratios for mg98 methylation')+ 
  annotate("text", label ='-1.5', x= -1.5 , y= Inf, vjust=1, hjust = 1, color="red")+ annotate("text", label ='1.5', x= 1.5 , y= Inf, vjust= 1, hjust = -0.2, color="red")
}