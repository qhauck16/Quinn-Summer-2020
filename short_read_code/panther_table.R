##load in the muscle and liver data output from panther GO analysis

liver <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/blast/Liver_Cellular_Metabolic.tsv', col_names = c('number', 'type','skip', 'match', 'percent_liver'))
muscle <- read_tsv('/uru/Data/Nanopore/Analysis/quinn/hbird/blast/Muscle_Cellular_Metabolic.tsv', col_names = c('number', 'type','skip', 'match', 'percent_muscle'))

liver <- liver %>%
  dplyr::select(type, percent_liver)
muscle <- muscle %>%
  dplyr::select(type, percent_muscle)
for (i in 1:nrow(muscle)){
  muscle$percent_muscle[i] <- str_split_fixed(muscle$percent_muscle[i], '%',2)[1]
}
for (i in 1:nrow(liver)){
liver$percent_liver[i] <- str_split_fixed(liver$percent_liver[i], '%',2)[1]
}
muscle$percent_muscle <- as.integer(muscle$percent_muscle)
liver$percent_liver <- as.integer(liver$percent_liver)

combined_df <- full_join(liver, muscle, by='type')

combined_df[is.na(combined_df)] = 0 
combined_df <- combined_df %>%
  mutate(liver_muscle = percent_liver - percent_muscle)

write.xlsx(combined_df, '/uru/Data/Nanopore/Analysis/quinn/hbird/blast/liver_muscle_cellular_metabolic.xlsx')

