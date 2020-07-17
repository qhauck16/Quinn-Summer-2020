df <- read.gtf('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/stringtie2/illumina/stringtie2/stringtie2_1st/m96_S2_2_out_paired/m96_S2_2_out_paired_ST2_1st.gtf')
head(df)
df <- df %>%
  mutate(length = end - start) %>%
  filter(feature == 'transcript') %>%
  select(reference_id, FPKM, length)
ggplot(df, aes(x = length, y = FPKM)) +
  geom_point()
