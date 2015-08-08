## create line plot for global active power in kilowatts for 2007-02-01 through 2007-02-02
## the household_power_consumption.txt must be in the working directory
## the entire power consumption file is read into a data table and then observations for the date 
## range are selected.
## this code was developed on a Mac


datafile <- "household_power_consumption.txt"
# create data frame - allData
allData <- read.table(file = datafile, header = T, sep = ";")
## convert date from character to Date
allData$Date <- as.Date(allData$Date, format="%d/%m/%Y")
## create data frame of data for 2/1 to 2/2
consumption <- allData[(allData$Date=="2007-02-01"| allData$Date=="2007-02-02"),]
## convert from character to numeric
consumption$Global_active_power <- as.numeric(as.character(consumption$Global_active_power))
## POSIXct data conversion used becasue data has H:M:SS values  use paste to convert character to vector
consumption <- transform(consumption, timestamp=as.POSIXct(paste(Date, Time)),"%d/%m/%Y %H:%M:%S")
## create line plot type is l 
plot(consumption$timestamp,consumption$Global_active_power, type="l", xlab = "",
     ylab = "Global Active Power (killowats)")
dev.copy(png, file="plot2.png",width=480, height=480)
dev.off()
cat("plot2 is saved in ", getwd())

 