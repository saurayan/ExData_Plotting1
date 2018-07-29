
# Clear workspace of other variables

rm(list=ls())

# Set the working directory to where the R script is located
# Please make sure that the data file and script is located in the same folder

script.dir <- dirname(sys.frame(1)$ofile)
setwd(script.dir)
getwd()

# Read the main data

tbl_alldata<-read.table("household_power_consumption.txt", stringsAsFactors = FALSE, header = TRUE, sep = ";")

# Functions below require the lubridate package. It will be installed automatically
# User needs to be connected to the Internet to download this package

if(!require(lubridate))
{
  install.packages("lubridate")
}

library(lubridate)


# convert the date field from String to Date
tbl_alldata$Date <- dmy(tbl_alldata$Date)

#Pull out the data for the specified two dates only
tbl_sub<-subset(tbl_alldata, Date == "2007-02-01" | Date =="2007-02-02")

#Plot#1 - Historgram of Global Active Power
png("plot1.png", width=480, height=480)
hist(as.numeric(tbl_sub$Global_active_power), col="red", border="black", main ="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")
dev.off()

