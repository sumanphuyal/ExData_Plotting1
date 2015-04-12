##*****************************************************************##
## Download data from internet ##
##*****************************************************************##
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "houseHoldPowerConsumption.zip"
download.file(url, destfile, mode="w", method="curl")
fileName <- unzip (destfile, exdir = "./")

##*****************************************************************##
## Clean data and draw histogram ##
##*****************************************************************##
powerData <- read.table(fileName, sep=";", header = TRUE, na.strings = "?")
powerData$Date <- strptime(powerData$Date, format = "%d/%m/%Y")

# Get subsection of data i.e data from the date 2007-02-01 and 2007-02-02
finalSubsection <- powerData[as.Date(powerData$Date) >= as.Date("2007-02-01", "%Y-%m-%d") & as.Date(powerData$Date) <= as.Date("2007-02-02", "%Y-%m-%d"),]

#merge data and time into new column.
finalSubsection$DateTime <- as.POSIXct(paste(finalSubsection$Date, finalSubsection$Time), format="%Y-%m-%d %H:%M:%S")

#Open device using png function
png("plot2.png")

#Draw line chart
plot(finalSubsection$DateTime, finalSubsection$Global_active_power, typ="l", 
     ylab = "Global Activity Power (kilowats)", xlab = "")

dev.off() #Close device
