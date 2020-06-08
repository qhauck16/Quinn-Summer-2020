type <- c('fed', 'fasted')
 df_type <- data.frame(type)
 df_type

 rownames(df_type) <- c('mg96', 'mg98')
 df_type

vector <- c('/uru/Data/Nanopore/Analysis/gmoney/hbird/methylation/nanopolish_v11/mg96_bismark.out', '/uru/Data/Nanopore/Analysis/gmoney/hbird/methylation/nanopolish_v11/mg98_bismark.out')
bs_both <- read.bismark(vector, loci = NULL, colData = df_type, verbose = TRUE)
bs_both_smooth <- BSmooth(bs_both, ns = 500, verbose = TRUE)