mg96_bismark <- read_tsv('/uru/Data/Nanopore/Analysis/gmoney/hbird/methylation/nanopolish_v11/mg96_bismark.out')
colnames(mg96_bismark) <- c('chr', 'coord','*', 'meth', 'unmeth', 'type', 'seq')
mg98_bismark <- read_tsv('/uru/Data/Nanopore/Analysis/gmoney/hbird/methylation/nanopolish_v11/mg98_bismark.out')
colnames(mg98_bismark) <- c('chr', 'coord','*', 'meth', 'unmeth', 'type', 'seq')
plot_meth <- function(chrm, start, end, gene, gene_start, gene_end){
  
  gene_region <- data.frame(chrm, start, end)
  colnames(gene_region) <- c('chr', 'start', 'end')
  
  mg96_smooth_region <- as.data.frame(getMeth(bs_mg96_smooth, regions = gene_region, type = 'smooth', what = 'perBase'))
  mg98_smooth_region <- as.data.frame(getMeth(bs_mg98_smooth, regions = gene_region, type = 'smooth', what = 'perBase'))
  colnames(mg96_smooth_region) <- 'smooth'
  colnames(mg98_smooth_region) <- 'smooth'
  
  ##filtering to only the desired section of the genome
  
  bismark1 <- mg96_bismark %>%
    filter(chr == chrm & start <= coord & coord <= end) %>%
    cbind(mg96_smooth_region)
  bismark1 <- bismark1 %>%
    mutate(bird = 'mg96/fed')
  
  ##doing the same for bismark from mg98
  
  bismark2 <- mg98_bismark %>%
    filter(chr == chrm & start <= coord & coord <= end) %>%
    cbind(mg98_smooth_region) 
  bismark2 <- bismark2 %>%
    mutate(bird = 'mg98/fasted')
  
  #joining dataframes and plotting
  
  bismark <- rbind(bismark1, bismark2)
  
  ggplot(bismark, aes(x = coord, y = smooth))+
    geom_line(aes(color = bird))+
    geom_vline(xintercept = gene_start, color = 'dark blue')+ annotate("text", label = "gene start", x = gene_start, y = 0.7)+
    geom_vline(xintercept = gene_end, color = 'dark blue')+ annotate("text", label = "gene end", x = gene_end, y = 0.7)+
    labs(title = paste('Methylation around ', gene), x = paste('position in chromosome: ', chrm, '(bp)'), y = 'percent of reads methylated')
}