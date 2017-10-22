library(sqldf)          #using sqldf package to read filtered data from file

df <- read.csv.sql("../../Data Directory/UCI IHEPC Dataset/household_power_consumption.txt",
                   sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")

hist(df$Global_active_power, col = "red", plot = TRUE, xlim = c(0,6), ylim = c(0,1200), breaks = 12,
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)" )

rm(df)                  #remove the dataset to free the space
dev.copy(png, "../../Data Directory/plot1.png", width = 480, height = 480)
dev.off()
