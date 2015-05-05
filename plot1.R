## plot1.R
## 
## create a historgram plot showing the frequency of global active power

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
    transmute(date.time = dmy_hms(paste(Date, Time, sep=" ")),
           global.active.power = as.numeric(Global_active_power),
           global.reactive.power = as.numeric(Global_reactive_power),
           voltage = as.numeric(Voltage),
           global.intensity = as.numeric(Global_intensity),
           sub.metering.1 = as.numeric(Sub_metering_1),
           sub.metering.2 = as.numeric(Sub_metering_2),
           sub.metering.3 = as.numeric(Sub_metering_3)) %>%
    filter(date.time >= mdy_hms("02-01-2007 00:00:00"),
           date.time <= mdy_hms("02-02-2007 23:59:59"))

png(filename="plot1.png")
hist(data$global.active.power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()
