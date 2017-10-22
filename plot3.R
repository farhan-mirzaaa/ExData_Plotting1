library(sqldf)          #using sqldf package to read filtered data from file
# "../../Data Directory" is my directory to store the data, in order to run the code you have to edit it
df <- read.csv.sql("../../Data Directory/UCI IHEPC Dataset/household_power_consumption.txt",
                   sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")

df$Time <- paste(df$Date, df$Time)
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df$Time <- strptime(df$Time, "%d/%m/%Y %H:%M:%S", tz = "GMT")

plot(df$Time, df$Sub_metering_1, type="l", xlab = "", ylab = "Energy Sub Metering")
                                                                        
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), lwd = c(1,1))


rm(df)                  #remove the dataset to free the space
dev.copy(png, "../../Data Directory/plot3.png", width = 480, height = 480)
dev.off()
