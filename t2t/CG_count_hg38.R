
##load UCSC hg38 release as BShg38_genome object

install("BSgenome.Hsapiens.UCSC.hg38")
hg38_genome <- getBSgenome('hg38')

##load repeatmasker BED file as a GRanges object
repeats <- read_tsv('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/t2t/hg38_repeatmasker_full')

## establish pattern of interest, find total count in T2T hg38_genome
cg <- 'cg'
cg_count_hg38 <- 0
for (i in 1:22) {
  temp_chrm_name <- paste0('chr', i)
  temp_chrm <- hg38_genome[[temp_chrm_name]]
  cg_count_hg38 <<- cg_count_hg38 + countPattern(cg, temp_chrm)
}
cg_count_hg38 <- cg_count_hg38 + countPattern(cg, hg38_genome$chrX) + countPattern(cg, hg38_genome$chrM)

## Filter Granges object into dataframe of only desired variables

repeats_df <- as.data.frame(repeats)
repeats_df <- repeats_df %>%
  dplyr::select(genoName, genoStart, genoEnd, strand, repName, repClass)
colnames(repeats_df) <- c('chrm', 'start', 'end', 'strand', 'name', 'type')
##repeats_df <- repeats_df %>%
##filter(chrm == 'chrMT')

## Create a vector of all types of repeats
types <- unique(repeats_df$type)
counts_hg38 <- vector(mode = 'numeric', length = length(types))
##iterate through the dataframe, adding a CG count for every element in the repeatmasker
##first separate by chromosome
for (j in 1:23){
  if (j!=23){
    temp_chr <- paste0('chr', j)
    unique_chr_df <- repeats_df %>%
      filter(chrm == temp_chr)
    
    i = 1
  }
  else{
    temp_chr <- 'chrX'
    unique_chr_df <- repeats_df %>%
      filter(chrm == temp_chr)
    
    i = 1
  }
  ##iterate through each type of sequence
  for (seq in types){
    specific_repeat_df <- unique_chr_df %>%
      filter(type == seq)
    
    ## add a CG count to corresponding vector entry in counts_hg38 for each element of selected type
    for (k in 1:nrow(specific_repeat_df)){
      temp_start <- as.numeric((specific_repeat_df$start)[k])
      temp_end <- as.numeric((specific_repeat_df$end)[k])
      temp_loc <- (hg38_genome[[temp_chr]])[temp_start:temp_end]
      counts_hg38[i] <- counts_hg38[i] + countPattern(cg, temp_loc)
    }
    
    ##update i for next entry in counts_hg38
    i <<- i+1
  }
}

types <- append(types, 'nonrepetitive')
counts_hg38 <- append(counts_hg38, cg_count_hg38-sum(counts_hg38))
full_breakdown <- data.frame(types, counts_hg38)

##remove any elements that make up less than 1%, group into other category
other <- 0
threshold <- 0.01*cg_count_hg38
storage <- c()
for (i in 1:nrow(full_breakdown)){
  if(counts_hg38[i] < threshold){
    other <- other + counts_hg38[i]
    storage <- as.vector(append(storage, i))
  }
}
full_breakdown <- full_breakdown[-storage,]

other_vector <- c('other', as.numeric(other))
full_breakdown <- rbind(full_breakdown, other_vector)

full_breakdown$counts_hg38 <- as.numeric(as.character(full_breakdown$counts_hg38))
full_breakdown <- full_breakdown %>%
  mutate(value = counts_hg38/cg_count_hg38)

bar <- ggplot(full_breakdown, aes(x="", y=value, fill=types))+
  geom_bar(width = 1, stat = "identity")
pie <- bar + coord_polar("y", start=0)
pie