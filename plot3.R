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

rawdata <- read.csv.sql("household_power_consumption.txt", sep = ";",sql = "select * from file where Date in ('1/2/2007', '2/2/2007')", eol = "\n")

closeAllConnections()

#create a new date_time column by combining date and time using the lubridate dmy_hms function
rawdata$date_time <- dmy_hms(paste(rawdata$Date, rawdata$Time))

}
########################Plot graph (histogram)#####################################,

png(file = "plot3.png", bg = "white", width = 480, height = 480)

plot(rawdata$date_time,rawdata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
points(rawdata$date_time,rawdata$Sub_metering_1,col="black",type = "l")
points(rawdata$date_time,rawdata$Sub_metering_2,col="red",type = "l")
points(rawdata$date_time,rawdata$Sub_metering_3,col="blue",type = "l")
legend("topright",col = c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)
dev.off()

closeAllConnections()