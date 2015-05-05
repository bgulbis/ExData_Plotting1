## plot3.R
## 
## create a line plot showing the date/time and energy sub metering

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
    mutate(date.time = dmy_hms(paste(Date, Time, sep=" "))) %>%
    select(-Date, -Time) %>%
    mutate_each(funs(as.numeric), -date.time) %>%
    filter(date.time >= mdy_hms("02-01-2007 00:00:00"),
           date.time <= mdy_hms("02-02-2007 23:59:59"))

## create a graphics device to create .png file
png(filename="plot3.png")
## create a line plot for Sub_metering_1, then add lines for Sub_metering_2 
## and Sub_metering_3, assign the line colors and axis labels
with(data, plot(date.time, Sub_metering_1, type="l", xlab="", 
                ylab="Energy sub metering"))
with(data, lines(date.time, Sub_metering_2, type="l", col="red"))
with(data, lines(date.time, Sub_metering_3, type="l", col="blue"))
## add a legend to the plot
legend("topright", lty=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
## close the graphics device
dev.off()
