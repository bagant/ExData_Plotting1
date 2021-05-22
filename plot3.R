setwd("F:/R-docs")
library(dplyr)
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "1.zip", mode="wb")
zipF<- "1.zip"
dir.create(“unzipfolder“)
outDir<-"unzipfolder"
unzip(zipF,exdir=outDir)
x<-read.table("./unzipfolder/household_power_consumption.txt", header = T, sep = ";")
x$Date<-paste(x$Date, x$Time, sep=" ")
x$Date<-strptime(x$Date, "%d/%m/%Y %H:%M:%S")
x$Time<-NULL
y<-filter(x, Date>="2007-02-01 00:00:00" & Date <="2007-02-02 23:59:00")
y<-mutate_if(y, is.character,as.numeric)
png(filename = "plot3.png")
plot(y$Date, y$Sub_metering_1,type = "l", xlab="", ylab = "Energy sub metering")
lines(y$Date, y$Sub_metering_2,col="red")
lines(y$Date, y$Sub_metering_3,col="blue")
legend("topright", lty = 1,col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
