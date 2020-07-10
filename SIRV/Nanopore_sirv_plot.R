nanopore_sirvs <- read_tsv('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/analysis/nanopore_chrms.txt')
SIRV1 = 8/69
SIRV2 = 5/69
SIRV3 = 11/69 
SIRV4 = 7/69
SIRV5 = 12/69
SIRV6 = 18/69
SIRV7 = 7/69
colnames(nanopore_sirvs) <- 'chrm'
nanopore_sirvs <- nanopore_sirvs %>%
  filter(chrm != '*')
n = nrow(nanopore_sirvs)

nanopore_sirvs <- nanopore_sirvs %>%
  group_by(chrm) %>%
  summarize(actual =n()/n)
expected <- c(SIRV1, SIRV2, SIRV3, SIRV4, SIRV5, SIRV6, SIRV7)
nanopore_sirvs <- nanopore_sirvs %>%
  cbind(expected)
nanopore_sirvs <- nanopore_sirvs %>%
  melt(id.vars = 'chrm')
ggplot(nanopore_sirvs, aes(chrm, value))+
  geom_col(aes(fill = variable), width = 0.6, position = position_dodge(width=0.5), stat="identity")+
  labs(title = 'Nanopore SIRV read proportions', x = 'SIRV sequence', y = 'proportion of aligned reads')
