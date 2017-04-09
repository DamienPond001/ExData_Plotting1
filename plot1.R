# Ensure "household_power_consumption.txt" is in working directory

dataset <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

dataset$Date <- as.Date(dataset$Date, format = "%d/%m/%Y")
dataset$Time <- strptime(dataset$Time, format = "%T")

dataset <- subset(dataset, months(Date) == "February" & as.numeric(format(Date,"%Y")) == 2007
                  & (as.numeric(format(Date, "%d")) == 1 |as.numeric(format(Date, "%d")) == 2))

png(filename = "plot1.png")
with(dataset, hist(Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)", main = "Global Active Power"))
dev.off()
