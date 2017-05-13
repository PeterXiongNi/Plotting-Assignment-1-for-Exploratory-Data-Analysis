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
plot(df$day, df$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.copy(png, filename = "plot2.png")
dev.off()
