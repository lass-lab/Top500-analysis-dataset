#!/usr/bin/env Rscript

i <- 1

for (year in seq(2005, 2018)) {
  for (month in c(6,11)) {
    listname <- sprintf("%d%02d", year, month)
    file <- sprintf("nonzero/%s.csv", listname, month)

    data <- read.csv(file, header=F, sep=',')
    colnames(data) <- c("List", "Rank", "ID", "Rmax", "Kw", "PML")
## Tflop/Kw
## to Mflop/W
    e <- (data$Rmax*(1024*1024)) / (data$Kw*1024)
#    output <- sprintf("%d,%s,%.3f,%s", i, listname, mean(kw), quantile(kw))
#    output <- sprintf("%d,%s,%.6f", i, listname,mean(kw))
    cat(i,listname,mean(e),quantile(e),"\n")
    i <- i+1
  }
}
