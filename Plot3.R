## create line plot for global consumption  for 2007-02-01 through 2007-02-02
## the household_power_consumption.txt must be in the working directory
## the entire power consumption file is read into a data table and then observations for the date 
## range are selected.
## this code was developed on a Mac

datafile <- "household_power_consumption.txt"
# create data frame - allData
allData <- read.table(file = datafile, header = T, sep = ";")
allData$Date <- as.Date(allData$Date, format="%d/%m/%Y")
## create data frame of data for 2/1 to 2/2
consumption <- allData[(allData$Date=="2007-02-01"| allData$Date=="2007-02-02"),]
## complete character and date conversions
consumption$Sub_metering_1 <- as.numeric(as.character(consumption$Sub_metering_1))
consumption$Sub_metering_2 <- as.numeric(as.character(consumption$Sub_metering_2))
consumption$Sub_metering_3 <- as.numeric(as.character(consumption$Sub_metering_3))

consumption$Voltage <- as.numeric(as.character(consumption$Voltage))
consumption <- transform(consumption, timestamp=as.POSIXct(paste(Date, Time)),"%d/%m/%Y %H:%M:%S")
## create line plot with legend
plot(consumption$timestamp,consumption$Sub_metering_1, type = "l", ylab = "Energy Sub Metering")
lines(consumption$timestamp,consumption$Sub_metering_2,col="red")
lines(consumption$timestamp,consumption$Sub_metering_3,col="blue")
legend("topright", col = c("black","red","blue"), c("Sub_metering_1","Sub_metering_2",
                                                    "Sub_metering_3"),lty=c(1,1),lwd = c(1,1))


dev.copy(png, file="plot3.png",width=480, height=480)
dev.off()
cat("plot3 is saved in ", getwd())




