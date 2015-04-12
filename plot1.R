##*****************************************************************##
## Download data from internet ##
##*****************************************************************##
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "houseHoldPowerConsumption.zip"
download.file(url, destfile, mode="w", method="curl")
fileName <- unzip (destfile, exdir = "./")

##*****************************************************************##
## Clea data and draw histogram ##
##*****************************************************************##
powerData <- read.table(fileName, sep=";", header = TRUE, na.strings = "?")
powerData$Date <- strptime(powerData$Date, format = "%d/%m/%Y")

# Get subsection of data i.e data from the date 2007-02-01 and 2007-02-02
finalSubsection <- powerData[as.Date(powerData$Date) >= as.Date("2007-02-01", "%Y-%m-%d") & as.Date(powerData$Date) <= as.Date("2007-02-02", "%Y-%m-%d"),]

#Open device using png function
png("plot1.png")

#Draw histogram
hist(finalSubsection$Global_active_power, xlab = "Global Activity Power (kilowats)",
     main = "Global Active Power", col = "Red",
     xlim = c(0,6), ylim = c(0, 1200))

dev.off() #Close device
