ruby_gtf <- read.gtf('/uru/Data/Nanopore/Analysis/gmoney/hbird/210114_aliana_annotation/acolubris_masurca_ragoo_v2.gff')
anna_gtf <- read.gtf('/uru/Data/Nanopore/Analysis/gmoney/hbird/reference/GCF_003957555.1_bCalAnn1_v1.p_genomic.gff')
#HMB_gtf <- read.gtf('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/HMB.annotation.gtf')

ruby_gtf_genes <- ruby_gtf %>%
  filter(feature=='gene')
  ruby_gene_count <- nrow(ruby_gtf_genes)
ruby_gtf_transcripts <- ruby_gtf %>%
  filter(feature == 'mRNA')
ruby_transcript_count <- nrow(ruby_gtf_transcripts)

ruby_transcript_per_gene <- ruby_transcript_count/ruby_gene_count


anna_gtf_genes <- anna_gtf %>%
  filter(feature=='gene')
anna_gene_count <- nrow(anna_gtf_genes)
anna_gtf_transcripts <- anna_gtf %>%
  filter(feature == 'mRNA')
anna_transcript_count <- nrow(anna_gtf_transcripts)

anna_transcript_per_gene <- anna_transcript_count/anna_gene_count

labels <- c('ruby genes', 'ruby transcripts', 'anna genes', 'anna transcripts')
counts <- c(ruby_gene_count, ruby_transcript_count, anna_gene_count, anna_transcript_count)

bar_chart <- data.frame(labels, counts)

plot<-ggplot(data=bar_chart, aes(x=labels, y=counts)) +
  geom_bar(stat="identity", fill="steelblue")+
  xlab('Feature Type')+
  ylab('Number')+
  geom_text(aes(label=counts), vjust=1.2, size=3.5)
  theme_minimal()
  
plot

HMB_gtf_transcripts <- HMB_gtf %>%
  filter(feature=='transcript')
HMB_gene_count <- nrow(distinct(HMB_gtf_transcripts, gene_id))
HMB_transcript_count <- nrow(HMB_gtf_transcripts)

HMB_transcript_per_gene <- HMB_transcript_count/HMB_gene_count