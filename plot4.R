library(sqldf)          #using sqldf package to read filtered data from file
# "../../Data Directory" is my directory to store the data, in order to run the code you have to edit it
df <- read.csv.sql("../../Data Directory/UCI IHEPC Dataset/household_power_consumption.txt",
                   sql = "select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header = TRUE, sep = ";")

df$Time <- paste(df$Date, df$Time)
df$Date <- as.Date(df$Date, "%d/%m/%Y")
df$Time <- strptime(df$Time, "%d/%m/%Y %H:%M:%S", tz = "GMT")

par(mfrow = c(2,2))

# 1. Time vs Global active power plot
plot(df$Time, df$Global_active_power, type="l", xlab = "", ylab = "Global Active Power (kilowatts)" )

# 2. Time vs Voltage plot
plot(df$Time, df$Voltage, type="l", xlab = "datetime", ylab = "Voltage" )

# 3. Time vs Energy sub metering plot
plot(df$Time, df$Sub_metering_1, type="l", xlab = "", ylab = "Energy Sub Metering")
lines(df$Time, df$Sub_metering_2, col = "red")
lines(df$Time, df$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = c(1,1), lwd = c(1,1), bty = "n")

# 4. Time vs Global reactive power plot
plot(df$Time, df$Global_reactive_power, type="l", xlab = "datetime", ylab = "Global_reactive_power" )

rm(df)                  #remove the dataset to free the space
dev.copy(png, "../../Data Directory/plot4.png", width = 480, height = 480)
dev.off()
