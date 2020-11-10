gc_content_transcript <- function(illumina_directory, nanopore_directory, gc_xlsx){
  ##read in files input: illumina and nanopore prepDE.py outputs, and xlsx file with SIRV names and gc content
  gc_content <- read_excel(gc_xlsx, col_names = c('SIRVs', 'gc'))
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

  nano_df <- nano_df %>%
    group_by(SIRVs, type) %>%
    summarize(count = sum(count))

  illum_df <- illum_df %>%
    cbind(illumina)%>%
    mutate(count = count/illum_reads)
  
  colnames(illum_df) <- c('SIRVs', 'count', 'type')
  
  illum_df <- illum_df %>%
    group_by(SIRVs, type) %>%
    summarize(count = sum(count))

  illum_df <- illum_df %>% 
    full_join(gc_content, by = 'SIRVs')
  nano_df <- nano_df %>% 
    full_join(gc_content, by = 'SIRVs')
  
  illum_df <- illum_df %>%
    filter(!(is.na(count))) %>%
    filter(!(is.na(count)))

  nano_df <- nano_df %>%
    filter(!(is.na(count))) %>%
    filter(!(is.na(gc)))
  
  view(nano_df)
    print(ggplot(nano_df, aes(x = gc, y = count))+
            geom_point()+
            labs(title = 'Nanopore GC content quantification', x ='gc percentage', y = 'proportion of reads'))
    print(ggplot(illum_df, aes(x = gc, y = count))+
            geom_point()+
            labs(title = 'Illumina GC content quantification', x ='gc percentage', y = 'proportion of reads'))
}