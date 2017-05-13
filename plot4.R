##load needed library
library(lubridate)

##fetch file if not exists
filurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("household_power_consumption.txt")) {
    temp <- tempfile()
    download.file(filurl, temp, method = "curl")
    unzip(temp, exdir = "./")
}

##read file into R
f <- c("factor", "factor", rep("numeric", 7))
df <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", colClasses = f, na.strings = "?")

#clean and subset dataset
df$Date <- dmy(df$Date) 
df <- subset(df, df$Date %in% ymd(c("2007-02-01", "2007-02-02")))
df$day <- ymd_hms(paste(df$Date, df$Time))

#plot
par(mfcol = c(2, 2))
plot(df$day, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

plot(df$day, df$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(df$day, df$Sub_metering_2, type = "l", col = "red")
points(df$day, df$Sub_metering_3, type = "l", col = "blue")
legend("topright", lwd = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       cex = 0.75, y.intersp = 0.5, bty = "n", xjust = 1, text.width = strwidth("sub_metering_1")/2)

with(df, plot(day, Voltage, type = "l", xlab = "datetime"))
with(df, plot(day, Global_reactive_power, type = "l", xlab = "datetime"))

dev.copy(png, filename = "plot4.png")
dev.off()
