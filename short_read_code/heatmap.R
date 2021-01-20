library(pheatmap)
library(DESeq2)

##assumes environment has res and countData loaded from short_read_deseq.R

genes <- rownames(resOrdered[1:30, ])

countData_filtered <- countData[match(genes, rownames(countData)),]

#view(countData_filtered)



pheatmap(countData_filtered, show_rownames=T,
         cluster_cols=T,
         cluster_rows=T,
         scale="row",
      clustering_distance_rows="euclidean",
      clustering_distance_cols="euclidean",
      clustering_method="complete",
      border_color=FALSE,
      cex=0.7)