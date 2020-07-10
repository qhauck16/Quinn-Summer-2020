illumina_sirvs <- read_tsv('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/analysis/illumina_chrms_1.txt')
SIRV1 = 8/69
SIRV2 = 5/69
SIRV3 = 11/69 
SIRV4 = 7/69
SIRV5 = 12/69
SIRV6 = 18/69
SIRV7 = 7/69
colnames(illumina_sirvs) <- 'chrm'
illumina_sirvs <- illumina_sirvs %>%
  filter(chrm != '*')
n = nrow(illumina_sirvs)

illumina_sirvs <- illumina_sirvs %>%
  group_by(chrm) %>%
  summarize(actual =n()/n)
expected <- c(SIRV1, SIRV2, SIRV3, SIRV4, SIRV5, SIRV6, SIRV7)
illumina_sirvs <- illumina_sirvs %>%
  cbind(expected)
illumina_sirvs <- illumina_sirvs %>%
  melt(id.vars = 'chrm')
ggplot(illumina_sirvs, aes(chrm, value))+
  geom_col(aes(fill = variable), width = 0.6, position = position_dodge(width=0.5), stat="identity")+
  labs(title = 'Illumina SIRV read proportions', x = 'SIRV sequence', y = 'proportion of aligned reads')
