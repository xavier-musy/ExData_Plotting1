## this function plots plot4.png

plot4 <- function() {
  
  ## if we don't have local data, download it
  fileName = "data/household_power_consumption.txt"
  if (!file.exists(fileName)){
    message("downloading data...")
    fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    temp <- tempfile()
    download.file(fileUrl,temp, method="curl")
    message("unzipping data...")
    unzip(temp, exdir="data")
    unlink(temp)
  }
  
  ## read subset of data: 
  ## skip down to the first day we are interested in (2/1/2007)
  ## and read 2 days worth:  2 x 24 x 60 = 2880 minutes / rows
  library(data.table)
  data <- fread(fileName, sep=";", skip="1/2/2007", na.strings="?", nrows=2880, header=FALSE) #make sure no header when using skip
  
  # set column names
  setnames(data, 1:9, c("Date", "Time", "Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  #add date-time column
  data[,DateTime:= as.POSIXct(paste(Date, Time), format="%d/%m/%Y %H:%M:%S")]  # POSIXlt not supported by Data.Table so can't use strptime
 
  # open gd to plot to
  png(filename="plot4.png", width=480, height=480, units="px")
  
  ## set env for 4 charts
  par(mfrow = c(2, 2))
  
  # upper left
  with(data, plot(DateTime, Global_active_power, type="l", main="", xlab="", ylab="Global Active Power"))
  
  # upper right
  with(data, plot(DateTime, Voltage, type="l",main="", xlab="datetime", ylab="Voltage"))
  
  # lower left
  with(data, plot(DateTime, Sub_metering_1, type="l", main="", xlab="", ylab="Energy sub metering", col="Black"))
  with(data, lines(DateTime, Sub_metering_2, col="red"))
  with(data, lines(DateTime, Sub_metering_3, col="blue"))
  legend("topright", bty="n", lty=1, col = c("black","red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  
  # lower right
  with(data, plot(DateTime, Global_reactive_power, type="l",main="",xlab="datetime"))
  
  ## save the file
  dev.off()
  
  
}