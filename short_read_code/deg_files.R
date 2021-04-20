rownames(resOrdered) <- (str_split_fixed(rownames(resOrdered),'\\|',2)[, 2])
temp <- as.data.frame(resOrdered) %>%
  filter(padj<=0.1)
write.xlsx(temp, '/dilithium/Data/Nanopore/Analysis/quinn/SIRV/short_read_analysis/Liver_DEGS.xlsx')
