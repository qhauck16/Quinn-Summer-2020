SIRV1 = 8/69
SIRV2 = 5/69
SIRV3 = 11/69 
SIRV4 = 7/69
SIRV5 = 12/69
SIRV6 = 18/69
SIRV7 = 7/69
files <- list.files(path = "/dilithium/Data/Nanopore/Analysis/quinn/SIRV/analysis/", pattern = "*_illumina_chrms.txt")
n_files <- list.files(path = "/dilithium/Data/Nanopore/Analysis/quinn/SIRV/analysis/", pattern = "*_nanopore_chrms.txt")
illum <- function(i){
  name <- basename(i)
  strings <- str_split(name, '_', simplify = TRUE) 
  number <- as.vector(strings)[1]
  df <- read_tsv(paste0("/dilithium/Data/Nanopore/Analysis/quinn/SIRV/analysis/", i))
  colnames(df) <- 'chrm'
  n <- nrow(df)
  df <- df %>%
    group_by(chrm) %>%
    summarize(actual =n()/n)
  expected <- c(SIRV1, SIRV2, SIRV3, SIRV4, SIRV5, SIRV6, SIRV7)
  df <- df %>%
    cbind(expected)
  df <- df %>%
    melt(id.vars = 'chrm')
  print(ggplot(df, aes(chrm, value))+
    geom_col(aes(fill = variable), width = 0.6, position = position_dodge(width=0.5), stat="identity")+
    labs(title = paste(number, 'illumina SIRV read proportions'), x ='SIRV sequence', y = 'proportion of aligned reads'))
  rm(df)
}
lapply(files, illum)

nano <- function(i){
  name <- basename(i)
  strings <- as.vector(str_split(name, '\\.', simplify = TRUE))[1]
  number <- as.vector(str_split(strings, '_', simplify = TRUE))[2]
  df <- read_tsv(paste0("/dilithium/Data/Nanopore/Analysis/quinn/SIRV/analysis/", i))
  n <- nrow(df)
  colnames(df) <- 'chrm'
  df <- df %>%
    group_by(chrm) %>%
    summarize(actual =n()/n)
  expected <- c(SIRV1, SIRV2, SIRV3, SIRV4, SIRV5, SIRV6, SIRV7)
  df <- df %>%
    cbind(expected)
  df <- df %>%
    melt(id.vars = 'chrm')
  print(ggplot(df, aes(chrm, value))+
    geom_col(aes(fill = variable), width = 0.6, position = position_dodge(width=0.5), stat="identity")+
    labs(title = paste(number, 'nanopore SIRV read proportions'), x ='SIRV sequence', y = 'proportion of aligned reads'))
  
}
lapply(n_files, nano)