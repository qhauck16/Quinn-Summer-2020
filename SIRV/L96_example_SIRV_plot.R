L96 <- read_tsv('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/analysis/L96_S52_out_paired_chrm.txt')
SIRV1 = 8/69
SIRV2 = 5/69
SIRV3 = 11/69 
SIRV4 = 7/69
SIRV5 = 12/69
SIRV6 = 18/69
SIRV7 = 7/69
colnames(L96) <- 'chrm'
L96 <- L96 %>%
  filter(chrm != '*')
n = nrow(L96)

L96 <- L96 %>%
  group_by(chrm) %>%
  summarize(actual =n()/n)
expected <- c(SIRV1, SIRV2, SIRV3, SIRV4, SIRV5, SIRV6, SIRV7)
L96 <- L96 %>%
  cbind(expected)
L96 <- L96 %>%
  melt(id.vars = 'chrm')
ggplot(L96, aes(chrm, value))+
  geom_col(aes(fill = variable), width = 0.6, position = position_dodge(width=0.5), stat="identity")+
  labs(title = 'L96 illumina', x = 'SIRV sequence', y = 'proportion of aligned reads')
