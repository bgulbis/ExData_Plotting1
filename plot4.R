## plot4.R
## 
## create a 2x2 set of plots looking at Global_active_power, Voltage,
## Sub_metering, and Global_reactive_power

## use package lubridate for manipulating date and time values
library(lubridate)
## use package dplyr for data frame manipulations
library(dplyr)

## read in data from text file
## combines the Date and Time variables into a single variable of type POSIXct
## converts measurement variables into numeric types
## filters the data to our dates of interest (2/1/2007 - 2/2/2007)
data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", 
                  na.strings="?", colClasses="character") %>%
    mutate(datetime = dmy_hms(paste(Date, Time, sep=" "))) %>%
    mutate_each(funs(as.numeric), -datetime) %>%
    filter(datetime >= mdy_hms("02-01-2007 00:00:00"),
           datetime <= mdy_hms("02-02-2007 23:59:59"))

## create a graphics device to create .png file
png(filename="plot4.png")
## create 4 plots in a 2x2 format
par(mfrow=c(2,2))
with(data, {
    ## create a line plot of Global_active_power, assign the axis labels
    plot(datetime, Global_active_power, type="l", xlab="",
         ylab="Global Active Power")
    ## create a line plot of Voltage, labels are defaults
    plot(datetime, Voltage, type="l")
    ## create a line plot for Sub_metering_1, then add lines for Sub_metering_2 
    ## and Sub_metering_3, assign the line colors, axis labels, and legend
    plot(datetime, Sub_metering_1, type="l", xlab="", 
         ylab="Energy sub metering")
    lines(datetime, Sub_metering_2, type="l", col="red")
    lines(datetime, Sub_metering_3, type="l", col="blue")
    legend("topright", lty=1, col=c("black", "red", "blue"), bty="n", 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    ## create a line plot of Global_reactive_power, labels are defaults
    plot(datetime, Global_reactive_power, type="l")
    
})
## close the graphics device
dev.off()
