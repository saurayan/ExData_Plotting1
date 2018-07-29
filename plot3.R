
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
# Please make sure you are connected to the internet

if(!require(lubridate))
{
  install.packages("lubridate")
}

library(lubridate)

# Create the commbine date time field
v_combined<-paste(tbl_alldata$Date, tbl_alldata$Time, sep=" ")
v_formatted<- dmy_hms(v_combined)
tbl_alldata$datetime <- v_formatted

# Pull out the data for the specified two dates only
tbl_alldata$Date <- dmy(tbl_alldata$Date)
tbl_sub<-subset(tbl_alldata, Date == "2007-02-01" | Date =="2007-02-02")


# Plot#3 Energy Sub Metering
png("plot3.png", width=480, height=480)

with(tbl_sub, plot(datetime, Sub_metering_1, type="l", xlab="Day", ylab="Energy sub metering"))
lines(tbl_sub$datetime, tbl_sub$Sub_metering_2,type="l", col= "red")
lines(tbl_sub$datetime, tbl_sub$Sub_metering_3,type="l", col= "blue")
legend(c("topright"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty= 1, lwd=2, col = c("black", "red", "blue"))

dev.off()
