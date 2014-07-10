## this function plots plot2.png

plot2 <- function() {
  
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
  
  ## plot
  plot( data$DateTime, data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
  
  ## save the file
  dev.copy(png,filename="plot2.png")
  dev.off()
  
  
}