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

#plot
hist(df$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")
dev.copy(png, filename = "plot1.png")
dev.off()
