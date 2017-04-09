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

png(filename = "plot2.png")
plot(dataset$Time, as.numeric(dataset$Global_active_power), type = "n", xlab = "Day",  ylab = "Global Active Power (kilowatts)")
with(dataset, lines(dataset$Time, as.numeric(dataset$Global_active_power)))
dev.off()
