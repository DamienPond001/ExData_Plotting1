# Ensure "household_power_consumption.txt" is in working directory
library(lubridate)

dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
dataset$Time <- strptime(dataset$Time, format = "%T")

dataset <- subset(dataset, months(Date) == "February" & as.numeric(format(Date,"%Y")) == 2007
                  & (as.numeric(format(Date, "%d")) == 1 |as.numeric(format(Date, "%d")) == 2))

year(dataset$Time) <- year(dataset$Date)
month(dataset$Time) <- month(dataset$Date)
day(dataset$Time) <- day(dataset$Date)

png(filename = "plot3.png")
plot(dataset$Time, as.numeric(dataset$Sub_metering_1), type = "n", xlab = "Day",  ylab = "Energy sub metering")
with(dataset, lines(Time,Sub_metering_1))
with(dataset, lines(Time,Sub_metering_2, col = "red"))
with(dataset, lines(Time,Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty= c(1,1), col = c("black", "red", "blue"), pt.cex = 0.9)
dev.off()