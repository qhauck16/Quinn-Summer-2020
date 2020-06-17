mg96_bismark <- read_tsv('/uru/Data/Nanopore/Analysis/gmoney/hbird/methylation/nanopolish_v11/mg96_bismark.out')
colnames(mg96_bismark) <- c('chr', 'coord','*', 'meth', 'unmeth', 'type', 'seq')
mg98_bismark <- read_tsv('/uru/Data/Nanopore/Analysis/gmoney/hbird/methylation/nanopolish_v11/mg98_bismark.out')
colnames(mg98_bismark) <- c('chr', 'coord','*', 'meth', 'unmeth', 'type', 'seq')
plot_meth <- function(bismark_96, bismark_98, chrm, start, end, gene, gene_start, gene_end){
  
  ##filtering to only the desired section of the genome
  
  bismark1 <- bismark_96 %>%
    filter(chr == chrm & start <= coord & coord <= end)
  bismark1 <- bismark1 %>%
    mutate(percent_meth = meth/(meth+unmeth)) %>%
    mutate(bird = 'mg96/fed')
  
  ##doing the same for bismark from mg98
  
  bismark2 <- bismark_98 %>%
    filter(chr == chrm & start <= coord & coord <= end)
  bismark2 <- bismark2 %>%
    mutate(percent_meth = meth/(meth+unmeth)) %>%
    mutate(bird = 'mg98/fasted')
  
  #joining dataframes and plotting
  
  bismark <- rbind(bismark1, bismark2)
  
  ggplot(bismark, aes(x = coord, y = percent_meth))+
    geom_line(aes(color = bird))+
    geom_vline(xintercept = gene_start, color = 'dark blue')+ annotate("text", label = "gene start", x = gene_start, y = 0.7)+
    geom_vline(xintercept = gene_end, color = 'dark blue')+ annotate("text", label = "gene end", x = gene_end, y = 0.7)+
    labs(title = paste('Methylation around ', gene), x = paste('position in chromosome: ', chrm, '(bp)'), y = 'percent of reads methylated')
}