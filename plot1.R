## plot1.R
##
## create a historgram plot showing the frequency of global active power

## use package lubridate for manipulating date and time values
## use package dplyr for data frame manipulations
library(lubridate)
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
#
## create a graphics device to create .png file
png(filename="plot1.png")
## create a histogram, assign the bar colors, main title, and x-axis label
with(data, hist(Global_active_power, col="red", main="Global Active Power",
                xlab="Global Active Power (kilowatts)"))
## close the graphics device
dev.off()
