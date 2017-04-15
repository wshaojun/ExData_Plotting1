######################### Read data#############################
library(lubridate)
library(sqldf)

setwd("~/../")
if(!file.exists("./data")){dir.create("./data")}
setwd("./data")
if(!file.exists("household_power_consumption.txt")){
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
unzip(zipfile=temp,exdir=getwd())
unlink(temp)
#setwd("E:/Personal/01. Data Science Specialization/04. Exploratory Data Analysis/Week 1/")

rawdata <- read.csv.sql("household_power_consumption.txt", sep = ";",sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", eol = "\n")

closeAllConnections()

#create a new date_time column
rawdata$date_time <- dmy_hms(paste(rawdata$Date, rawdata$Time))
}

########################Plot graph (histogram)#####################################
png(file = "plot2.png", bg = "white", width = 480, height = 480)
plot(rawdata$date_time,rawdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()

closeAllConnections()