#!/usr/bin/env Rscript

for (year in seq(1993, 2018)) {
  for (month in c(6,11)) {
    listname <- sprintf("%d%02d", year, month)
    file <- sprintf("list/%s.csv", listname, month)
    #print(paste("processing..", file))

    data <- read.csv(file, header=F, sep=",")
    colnames(data) <- c("List", "Rank", "TotalCores", "Memory", "Rmax", "MHz", "Cores")

    cores <- data[data$TotalCores > 0,]
    mem <- data[data$Memory > 0,]
    cc <- data[data$MHz > 0,]
    k <- cc$TotalCores * cc$MHz
    l <- cc$Cores * cc$MHz

    cor_cores <- cor(cores$Rmax, cores$TotalCores)
    cor_cc <- cor(cc$Rmax, k)
    cor_sc <- cor(cc$Rmax, l)

    if (nrow(mem) > 10) {
        cor_mem <- cor(cores$Rmax, cores$Memory)
    } else {
        cor_mem <- NA
    }

    output <- sprintf("%s,%.6f,%.6f,%.6f,%.6f", listname, cor_cores, cor_cc, cor_mem, cor_sc)

    print(output)
  }
}

