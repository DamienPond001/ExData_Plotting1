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

png(filename = "plot4.png")
par(mfrow = c(2,2))

plot(dataset$Time, as.numeric(dataset$Global_active_power), type = "n", xlab = "Day",  ylab = "Global Active Power")
with(dataset, lines(Time, Global_active_power))

plot(dataset$Time, as.numeric(dataset$Voltage), type = "n", xlab = "datetime",  ylab = "Voltage")
with(dataset, lines(Time,Voltage))

plot(dataset$Time, as.numeric(dataset$Sub_metering_1), type = "n", xlab = "Day",  ylab = "Energy sub metering")
with(dataset, lines(Time,Sub_metering_1))
with(dataset, lines(Time,Sub_metering_2, col = "red"))
with(dataset, lines(Time,Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty= c(1,1), col = c("black", "red", "blue"),  bty = "n", pt.cex = 1, cex = 0.8)

plot(dataset$Time, as.numeric(dataset$Global_reactive_power), type = "n", xlab = "datetime",  ylab = "Energy sub metering")
with(dataset, lines(Time,Global_reactive_power))
dev.off()