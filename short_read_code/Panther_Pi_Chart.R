library(ggplot2)
library(readr)

##function to take in a filename that represents a tsv output by panther 
pie_chart_tsv <- function(filename){
  breakdown <- read_tsv(filename, col_names = c('number', 'type','skip', 'match', 'percent'))
  breakdown <- breakdown %>%
    dplyr::select(type, percent)
  
  for (i in 1:nrow(breakdown)){
  breakdown$percent[i] <- str_split_fixed(breakdown$percent[i], '%',2)[1]
  }
  
  breakdown$percent <- as.numeric(breakdown$percent)
  
  bp<- ggplot(breakdown, aes(x="", y=percent, fill=type))+
    geom_bar(width = 1, stat = "identity")
  bp
  pie <- bp + coord_polar("y", start=0)
  pie
  
  bar_plot<- ggplot(breakdown, aes(x="", y=percent, fill= fct_reorder(breakdown$types, breakdown$percent)))+
    geom_bar(width = 1, stat = "identity",color="black")
  bar_plot
  
}


  