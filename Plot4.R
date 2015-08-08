## create 4 plots  for global power consumption  for 2007-02-01 through 2007-02-02
## the household_power_consumption.txt must be in the working directory
## the entire power consumption file is read into a data table and then observations for the date 
## range are selected.
## this code was developed on a Mac

datafile <- "household_power_consumption.txt"

allData <- read.table(file = datafile, header = T, sep = ";")
allData$Date <- as.Date(allData$Date, format="%d/%m/%Y")

consumption <- allData[(allData$Date=="2007-02-01"| allData$Date=="2007-02-02"),]

consumption$Global_active_power <- as.numeric(as.character(consumption$Global_active_power))
consumption$Global_reactive_power <- as.numeric(as.character(consumption$Global_reactive_power))
consumption$Sub_metering_1 <- as.numeric(as.character(consumption$Sub_metering_1))
consumption$Sub_metering_2 <- as.numeric(as.character(consumption$Sub_metering_2))
consumption$Sub_metering_3 <- as.numeric(as.character(consumption$Sub_metering_3))

consumption$Voltage <- as.numeric(as.character(consumption$Voltage))
consumption <- transform(consumption, timestamp=as.POSIXct(paste(Date, Time)),"%d/%m/%Y %H:%M:%S")

## use par to combine multiple plots, mfrow creates a martrix of 2 rows and 2 cols
par(mfrow=c(2,2))
plot(consumption$timestamp,consumption$Global_active_power,type = "l",xlab="",ylab = "global Active Power")

plot(consumption$timestamp,consumption$Voltage,type = "l", xlab = "date time", ylab = "Voltage")

plot(consumption$timestamp,consumption$Sub_metering_1,type = "l",xlab = "", ylab="Energy Sub Metering")
lines(consumption$timestamp,consumption$Sub_metering_2,col="red")
lines(consumption$timestamp,consumption$Sub_metering_3,col="blue")
legend("topright", col = c("black","red","blue"), c("Sub_metering_1","Sub_metering_2",
                                                    "Sub_metering_3"),lty=c(1,1),bty = "n",cex = .5)

plot(consumption$timestamp,consumption$Global_reactive_power,type="l",xlab = "datetime",
     ylab = "global reactive power")

dev.copy(png, file="plot4.png",width=480, height=480)
dev.off()
cat("plot4 is saved in ", getwd())






r