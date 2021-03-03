low_df <- repeats_df %>%
  filter(type == "tRNA") %>%
  filter(chrm != 'chrM')

low_count <- 0
for (k in 1:(nrow(low_df))){
  temp_chr <- as.vector(low_df$chrm)[k]
  temp_start <- as.numeric((low_df$start)[k])
  temp_end <- as.numeric((low_df$end)[k])
  temp_loc <- (genome[[temp_chr]])[temp_start:temp_end]

  low_count <- low_count + countPattern(cg, temp_loc)
}

