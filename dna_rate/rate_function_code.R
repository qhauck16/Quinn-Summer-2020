speed = function(tsv){
df = read_tsv(tsv)
df <- df%>%  
  arrange(start_time) %>%
  mutate(time=(start_time-(((min(start_time)-.01))))) %>%
  mutate(time=(time/3600))

df$timechunk=ceiling(df$time)
df = df %>%
  group_by(timechunk) %>%
  mutate(rate=(sequence_length_template/template_duration)) %>%
  summarise(smax=max(rate),smin=min(rate),smedian=median(rate),s25=quantile(rate, .25),s75=quantile(rate, .75))
print(ggplot(df, aes(timechunk))+geom_line(aes(y=smedian))+geom_ribbon(aes(ymin=s25, ymax=s75), fill="red", col="red", alpha=0.5)+theme_bw()+theme(legend.position="none")+labs(title="Rate of DNA through pore for mg96 hbird", y="Bases per Second", x="hours"))
}