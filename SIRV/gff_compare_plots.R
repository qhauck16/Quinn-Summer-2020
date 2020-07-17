
sensitivity <- data.frame(base, exon, intron, intron_chain, transcript, locus)
illumina_s <- c(100, 91.5, 100, 98.4, 82.6, 100)
nanopore_s <- c(100, 89.9, 100, 98.4, 82.6, 100)
sensitivity <- data.frame(illumina_s, nanopore_s)

illumina <- c(100, 91.4, 98.3, 65.2, 57.0, 100)
nanopore <- c(57.8, 51.5, 52.1, 41.7, 37.5, 87.5)
precision <- data.frame(illumina, nanopore)

precision <- cbind(precision, c('base', 'exon', 'intron', 'intron_chain', 'transcript', 'locus'))
sensitivity<- cbind(sensitivity, c('base', 'exon', 'intron', 'intron_chain', 'transcript', 'locus'))

colnames(precision) <- c('illumina/hisat2', 'nanopore/deSALT', 'type')
colnames(sensitivity) <- c('illumina/hisat2', 'nanopore/deSALT', 'type')
rownames(precision) <- c()
rownames(sensitivity) <- c()

head(precision)

sensitivity <- sensitivity %>%
  melt(id.vars = 'type')

precision <- precision %>%
  melt(id.vars = 'type')
view(precision)

ggplot(precision, aes(type, value)) +
  geom_col(aes(fill = variable), width = 0.6, position = position_dodge(width=0.5))+
  labs(title = 'Precision', x = 'type', y = 'percent')

ggplot(sensitivity, aes(type, value)) +
  geom_col(aes(fill = variable), width = 0.6, position = position_dodge(width=0.5))+
  labs(title = 'Sensitivity', x = 'Type', y = 'percent')

