# check to see if data file exists, if not retrieve it
if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

#dataset variables
#V1 Date
#V2 Time
#V3 Global Active Power in kilowatt
#V4 Global Reactive Power in kilowatt
#V5 Voltage
#V6 Global Intensity in ampere
#V7 Sub Metering 1 in watt-hour of active energy
#V8 Sub Metering 2 in watt-hour of active energy
#V9 Sub Metering 3 in watt-hour of active energy

#select only the two February 2007 days needed
Feb2007 <- read.table(sep=";", 
                      header=TRUE, 
                      na.strings="?",
                      colClasses=c("character", "character", "numeric", "numeric", 
                         "numeric", "numeric", "numeric", "numeric", "numeric"),
                      col.names = c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9"),
                      text=grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value=TRUE))

#create-datetime from first two character columns
Feb2007$DateTime <- as.POSIXct(paste(Feb2007$V1, Feb2007$V2), format="%d/%m/%Y %H:%M:%S")

#save the plot to a PNG file with a width of 480 pixels and a height of 480 pixels
png(file="plot4.png", width=480, height=480)

# Generate Plot
#set the graph layout with mfrow (want 2 by 2), margins (mar) to set each side of the plot
#set the outer margin (oma)
par(mfrow=c(2,2), mar = c(4,4,2,1), oma = c(1,1,1,1))
with(Feb2007, {
  plot(V3 ~ DateTime, type="l", xlab="", ylab="Global Active Power") 
  plot(V5 ~ DateTime, type="l", xlab="datetime", ylab="Voltage")
  plot(V7 ~ DateTime, type="l", xlab="", ylab="Energy sub metering")
  lines(V8 ~ DateTime, col='Red')
  lines(V9 ~ DateTime, col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty = 1, lwd = 2, bty="n",
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  plot(V4 ~ DateTime, type="l", xlab="datetime", ylab="Global_reactive_power")
  }) 

#close the png device
dev.off()

#close connection
closeAllConnections()