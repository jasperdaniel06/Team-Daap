data <- read.csv("inkdata.csv")
View(data)
data2 <- read.csv("wozdata.csv")
View(data2)
data2 <- data2[, -c(23:26)]
write.csv(data2, "wozdata2.csv")
