pores_occupied_plot <- function(ex_df, string){
  df <- ex_df
df <- df%>%  
  arrange(start_time) %>%
    mutate(time=(start_time-(((min(start_time)-.01))))) %>%
    mutate(time=(time/3600))

df$timechunk=ceiling(df$time)
occup=df %>%
  group_by(channel, timechunk, file_id) %>%
  summarize(full=sum(duration), count=n()) %>%
  mutate(occupy=(full/3600)) 

print(ggplot(occup, aes(x = timechunk, y = occupy))+
  geom_smooth(aes(color = file_id))+
  theme_bw()+labs(title=paste("fraction of time pores occupied", string), x="hour",y="fraction occupied"))
}