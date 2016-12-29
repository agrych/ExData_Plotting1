# check to see if data file exists, if not retrieve it
if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

#select only the needed rows and columns
Feb2007 <- read.table(sep=";", 
                      header=TRUE, 
                      na.strings="?",
                      col.names = c("V1", "V2", "V3", "V4", "V5", "V6", "V7", "V8", "V9"),
                      text=grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value=TRUE))[,1:3]


#save the plot to a PNG file with a width of 480 pixels and a height of 480 pixels
png(file="plot1.png", width=480, height=480)

# Generate Plot 1
hist(Feb2007$V3, col = "red", main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab="Frequency")

#close the png device
dev.off()

#close the connection
closeAllConnections()