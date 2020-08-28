#!/usr/bin/env Rscript

i <- 1

for (year in seq(1993, 2018)) {
  for (month in c(6,11)) {
    listname <- sprintf("%d%02d", year, month)
    rmaxfile <- sprintf("rmax/%d%02d.csv", year, month)
    rpeakfile <- sprintf("rpeak/%d%02d.csv", year, month)

    rmax <- read.csv(rmaxfile, header=F, sep=",")
		colnames(rmax) <- c("rmax")
    rpeak <- read.csv(rpeakfile, header=F, sep=",")
		colnames(rpeak) <- c("rpeak")

		e <- rmax$rmax/rpeak$rpeak

		outfile <- sprintf("efficiency/%s.csv", listname)
		write.table(e, file = outfile, row.names=F, col.names=F)

		cat(i, mean(e), quantile(e), listname, "\n")

		i <- i+1
  }
}

