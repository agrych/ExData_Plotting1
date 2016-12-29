# check to see if data file exists, if not retrieve it
if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

#select only the rows and columns needed
#V1 Date
#V2 Time
#V3 Global Active Power in kilowatt

##  DO NOT NEED THE FOLLOWING COLUMNS
#V4 Global Reactive Power in kilowatt
#V5 Voltage
#V6 Global Intensity in ampere
#V7 Sub Metering 1 in watt-hour of active energy
#V8 Sub Metering 2 in watt-hour of active energy
#V9 Sub Metering 3 in watt-hour of active energy
Feb2007 <- read.table(sep=";", 
                      header=TRUE, 
                      na.strings="?",
                      colClasses=c("character", "character", "numeric"),
                      col.names = c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9"),
                      text=grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value=TRUE))[,1:3]

#create-datetime from character columns
Feb2007$DateTime <- as.POSIXct(paste(Feb2007$V1, Feb2007$V2), format="%d/%m/%Y %H:%M:%S")

#save the plot to a PNG file with a width of 480 pixels and a height of 480 pixels
png(file="plot2.png", width=480, height=480)

# Generate Plot
plot(Feb2007$V3 ~ Feb2007$DateTime, type="l", xlab="", ylab="Global Active Power (kilowatts)") 

#close the png device
dev.off()

#close connection
closeAllConnections()
