#!/usr/bin/env Rscript

data <- read.csv('recent-top5-balance.csv', header=F, sep=',')

for (i in seq(1, 100, 5)) {
  d <- data[i:(i+4),]
  hd <- d[d$V11 > 0, ]

  # percore
  dramcap <- mean(1.0*hd$V18/hd$V16)
  drambw <- mean(1.0*hd$V19/(1024*hd$V6))

  hbmcap <- mean(1.0*hd$V20/hd$V17)
  hbmbw <- mean(1.0*hd$V21/(1024*hd$V6))

  #baseline (homogeneous)
  bd <- d[d$V11 == 0, ]
  b_dramcap <- mean(1.0*bd$V18/bd$V16)
  b_drambw <- mean(1.0*bd$V19/(1024*bd$V6))

  output <- sprintf("%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n",
                    dramcap, drambw, hbmcap, hbmbw, b_dramcap, b_drambw)
  cat(output)
}

