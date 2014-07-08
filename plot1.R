## this function plots plot1.png

plot1 <- function() {

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
  data <- fread(fileName, sep=";", skip="1/2/2007", na.strings="?", nrows=2880)
  
  ## plot
  
  ## annotate
  
  ## save the file


}