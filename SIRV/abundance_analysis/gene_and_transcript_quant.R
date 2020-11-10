deseq_compare_gene <- function(illumina_directory, nanopore_directory){
  illum_files <- list.files(path = illumina_directory, pattern = "*.csv")
  nano_files <- list.files(path = nanopore_directory, pattern = '*.csv')

  illum_df <- data.frame(SIRVs = character(), count = integer())
  nano_df <- data.frame(SIRVs = character(), count = integer())
  
  combine_illum <- function(file){
    temp <- read_csv(paste0(illumina_directory, basename(file)), col_names = c('SIRVs', 'count'))
    temp <- temp[-1,]
    illum_df <<- illum_df %>%
      rbind(temp)
  }
  combine_nano <- function(file){
    temp <- read_csv(paste0(nanopore_directory, basename(file)), col_names = c('SIRVs', 'count'))
    temp <- temp[-1,]
    nano_df <<- nano_df %>%
      rbind(temp)
  }
  lapply(illum_files, combine_illum)
  lapply(nano_files, combine_nano)
  nanopore <- c()
for (i in 1:84){
  nanopore <- c(nanopore, 'nanopore')
}
illumina <- c()
for (i in 1:84){
  illumina <- c(illumina, 'illumina')
} 
nano_df$count <- as.numeric(as.character(nano_df$count))
illum_df$count <- as.numeric(as.character(illum_df$count))
  illum_reads <- sum(illum_df$count)
  nano_reads <- sum(nano_df$count)

  nano_df <- nano_df %>%
    cbind(nanopore)%>%
    mutate(count = count/nano_reads)
  colnames(nano_df) <- c('SIRVs', 'count', 'type')
  illum_df <- illum_df %>%
    cbind(illumina)%>%
    mutate(count = count/illum_reads)
  colnames(illum_df) <- c('SIRVs', 'count', 'type')
  full_df <- nano_df %>%
    rbind(illum_df)
  full_df <- full_df %>%
    group_by(SIRVs, type) %>%
    summarize(number = sum(count))
  
  
  print(ggplot(full_df, aes(SIRVs, number))+
          geom_col(aes(fill = type), width = 0.6, position = position_dodge(width=0.5))+
          labs(title = 'Gene level quantification', x ='SIRV sequence', y = 'proportion of reads'))
}  
  

deseq_compare_transcript <- function(illumina_directory, nanopore_directory){
  illum_files <- list.files(path = illumina_directory, pattern = "*.csv")
  nano_files <- list.files(path = nanopore_directory, pattern = '*.csv')
  
  illum_df <- data.frame(SIRVs = character(), count = integer())
  nano_df <- data.frame(SIRVs = character(), count = integer())
  
  combine_illum <- function(file){
    temp <- read_csv(paste0(illumina_directory, basename(file)), col_names = c('SIRVs', 'count'))
    temp <- temp[-1,]
    illum_df <<- illum_df %>%
      rbind(temp)
  }
  combine_nano <- function(file){
    temp <- read_csv(paste0(nanopore_directory, basename(file)), col_names = c('SIRVs', 'count'))
    temp <- temp[-1,]
    nano_df <<- nano_df %>%
      rbind(temp)
  }
  lapply(illum_files, combine_illum)
  lapply(nano_files, combine_nano)
  nanopore <- c()
  for (i in 1:nrow(nano_df)){
    nanopore <- c(nanopore, 'nanopore')
  }
  illumina <- c()
  for (i in 1:nrow(illum_df)){
    illumina <- c(illumina, 'illumina')
  } 
  nano_df$count <- as.numeric(as.character(nano_df$count))
  illum_df$count <- as.numeric(as.character(illum_df$count))
  illum_reads <- sum(illum_df$count)
  nano_reads <- sum(nano_df$count)

  nano_df <- nano_df %>%
    cbind(nanopore)%>%
    mutate(count = count/nano_reads)
  colnames(nano_df) <- c('SIRVs', 'count', 'type')
  illum_df <- illum_df %>%
    cbind(illumina)%>%
    mutate(count = count/illum_reads)
  colnames(illum_df) <- c('SIRVs', 'count', 'type')
  full_df <- nano_df %>%
    rbind(illum_df)
  full_df <- full_df %>%
    group_by(SIRVs, type) %>%
    summarize(number = sum(count))
  for (i in 1:7){
    temp <- paste0('SIRV', i)
    temp_df <- full_df %>%
      filter(substr(SIRVs, 1, 5) == paste0('SIRV', i))
    print(ggplot(temp_df, aes(SIRVs, number))+
          geom_col(aes(fill = type), width = 0.6, position = position_dodge(width=0.5))+
          labs(title = 'Transcript level quantification', x ='SIRV sequence', y = 'proportion of reads')+
          theme(axis.text.x = element_text(angle = 75, hjust = 1)))
  }
}  
