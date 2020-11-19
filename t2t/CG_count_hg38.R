
##load UCSC hg38 release as BShg38_genome object

install("BSgenome.Hsapiens.UCSC.hg38")
hg38_genome <- getBSgenome('hg38')

##load repeatmasker BED file as dataframe (skipping Granges, don't actually need it)
repeats_hg38 <- read_tsv('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/t2t/hg38_repeatmasker_full')

## establish pattern of interest, find total count in hg38_genome
cg <- 'cg'
cg_count_hg38 <- 0
for (i in 1:22) {
  temp_chrm_name <- paste0('chr', i)
  temp_chrm <- hg38_genome[[temp_chrm_name]]
  cg_count_hg38 <<- cg_count_hg38 + countPattern(cg, temp_chrm)
}
cg_count_hg38 <- cg_count_hg38 + countPattern(cg, hg38_genome$chrX)

## Filter Granges object into dataframe of only desired variables

repeats_df_hg38 <- as.data.frame(repeats_hg38)
repeats_df_hg38 <- repeats_df_hg38 %>%
  dplyr::select(genoName, genoStart, genoEnd, strand, repName, repClass)
colnames(repeats_df_hg38) <- c('chrm', 'start', 'end', 'strand', 'name', 'type')

## Create a vector of all types of repeats
types_hg38 <- unique(repeats_df_hg38$type)

counts_hg38 <- vector(mode = 'numeric', length = length(types_hg38))

##iterate through the dataframe, adding a CG count for every element in the repeatmasker
##first separate by chromosome
for (j in 1:23){
  if (j!=23){
    temp_chr <- paste0('chr', j)
    unique_chr_df <- repeats_df_hg38 %>%
      filter(chrm == temp_chr)
    

    indi_chrm_values <- vector(mode = 'numeric', length = length(types_hg38))
  }
  else{
    temp_chr <- 'chrX'
    unique_chr_df <- repeats_df_hg38 %>%
      filter(chrm == temp_chr)
    
    indi_chrm_values <- vector(mode = 'numeric', length = length(types_hg38))
  }

  ##iterate through each type of sequence
  for (i in 1:length(types_hg38)){
    specific_repeat_df <- unique_chr_df %>%
      filter(type == types_hg38[i])

    ## add a CG count to corresponding vector entry in counts_hg38 for each element of selected type
    if(nrow(specific_repeat_df > 0)){
    for (k in 1:(nrow(specific_repeat_df))){
      temp_start <- as.numeric((specific_repeat_df$start)[k])
      temp_end <- as.numeric((specific_repeat_df$end)[k])
      temp_loc <- (hg38_genome[[temp_chr]])[temp_start:temp_end]
      temp_value <- countPattern(cg, temp_loc)
      counts_hg38[i] <- counts_hg38[i] + temp_value
      indi_chrm_values[i] <- indi_chrm_values[i] + temp_value
    }
    }
    

  }
  ##write each chromosome's values to a tsv
  temp_chr_count <- countPattern(cg, hg38_genome[[temp_chr]])
  temp_types_hg38 <- append(types_hg38, 'nonrepetitive')
  indi_chrm_values <- append(indi_chrm_values, temp_chr_count-sum(indi_chrm_values))
  indi_chrm_df <- data.frame(temp_types_hg38, indi_chrm_values)
  file_name <- paste0('/dilithium/Data/Nanopore/Analysis/quinn/SIRV/t2t/hg38_tsv/', temp_chr)
  write_tsv(indi_chrm_df, file_name)
}


types_hg38 <- append(types_hg38, 'nonrepetitive')
counts_hg38 <- append(counts_hg38, cg_count_hg38-sum(counts_hg38))
full_breakdown_hg38 <- data.frame(types_hg38, counts_hg38)

##remove any elements that make up less than 1%, group into other category
other <- 0
threshold <- 0.01*cg_count_hg38
storage <- c()
for (i in 1:nrow(full_breakdown_hg38)){
  if(counts_hg38[i] < threshold){
    other <- other + counts_hg38[i]
    storage <- as.vector(append(storage, i))
  }
}
full_breakdown_hg38 <- full_breakdown_hg38[-storage,]

other_vector <- c('other', as.numeric(other))
full_breakdown_hg38 <- rbind(full_breakdown_hg38, other_vector)

full_breakdown_hg38$counts_hg38 <- as.numeric(as.character(full_breakdown_hg38$counts_hg38))
full_breakdown_hg38 <- full_breakdown_hg38 %>%
  mutate(value = counts_hg38/cg_count_hg38)

bar <- ggplot(full_breakdown_hg38, aes(x="", y=value, fill=types_hg38))+
  geom_bar(width = 1, stat = "identity")
pie <- bar + coord_polar("y", start=0)
pie