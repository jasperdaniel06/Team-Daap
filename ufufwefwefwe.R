data <- read.csv("inkdata.csv")
View(data)
data2 <- read.csv("wozdata.csv")
View(data2)

data <- data[-c(1, 2, 3, 4, 5, 11), -c(1, 3, 5, 6, 7, 8, 10, 11, 12, 13, 15, 16, 17, 18, 20, 21, 22, 23, 25, 26, 27, 28)]
rownames(data) <- seq_len(nrow(data))
colnames(data)[1] <- "Perioden"
colnames(data)[2:6] <- c("2019", "2020", "2021", "2022", "2023")

colnames(data2) <- data2[3, ]
data2 <- data2[-c(1:5, 7:379), -c(1, 2, 5:7, 9:11, 13:15, 17:19, 21:23)]
rownames(data2) <- seq_len(nrow(data2))

data <- rbind(data, data2)
data[6, 1] <- "Gemiddelde huizenprijzen in Nederland"


data[2:nrow(data), 2:ncol(data)] <- apply(data[2:nrow(data), 2:ncol(data)], 2, function(x) gsub(",", ".", x))
data[2:nrow(data), 2:6] <- apply(data[2:nrow(data), 2:6], 2, as.numeric)






