a_lengths <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/mg96_a_lengths')
bc_lengths <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/mg96_bc_lengths')
d_lengths <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/mg96_d_lengths')
efg_lengths <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/mg96_efg_lengths')
all_lengths <- a_lengths %>%
  rbind(bc_lengths) %>%
  rbind(d_lengths) %>%
  rbind(efg_lengths)
all_lengths <- all_lengths %>%
  arrange(sequence_length_template)%>%
  mutate(bases_up_to = cumsum(sequence_length_template))
N50 <- which.min(abs(all_lengths$bases_up_to - max(all_lengths$bases_up_to)/2))
N50_length <- all_lengths$sequence_length_template[N50]
ggplot(all_lengths, aes(x = sequence_length_template))+
  geom_histogram(binwidth = 0.6666667, aes(fill = 'blue'))+
  ggtitle('Read Lengths for mg96 Hbird')
  geom_vline(N50_length, aes(color = 'red'))
head(all_lengths)
