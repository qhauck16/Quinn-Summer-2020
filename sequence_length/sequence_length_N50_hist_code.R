#a_lengths <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg96_a_lengths')
#bc_lengths <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg96_bc_lengths')
abcd_lengths <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg98_abcd_lengths')
efg_lengths <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/mg98_efg_lengths')
all_lengths <- rbind(abcd_lengths, efg_lengths)
all_lengths <- all_lengths %>%
  arrange(sequence_length_template)%>%
  mutate(bases_up_to = cumsum(sequence_length_template))
N50 <- which.min(abs(all_lengths$bases_up_to - max(all_lengths$bases_up_to)/2))
N50_length <- all_lengths$sequence_length_template[N50]
print(ggplot(all_lengths, aes(x=sequence_length_template))+geom_histogram(bins=100, fill="dark blue")+scale_x_log10()+geom_vline(xintercept=N50_length, color="red", size=1)+
        annotate("text", label =paste0("N50= ",N50_length/1e3," kb"), x=N50_length, y= Inf, vjust=2,  hjust=-0.1, color="blue")+theme_bw())+ggtitle('Read lengths for mg98 hbird')+xlab('read length(bp)')

