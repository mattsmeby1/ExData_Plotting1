## First we load some packages we will be using for this assignment
library(dplyr)
library(data.table)

## Next we read the text file
initial <- read.table("household_power_consumption.txt", 
                      nrows = 2075259, header = TRUE, sep = ";", na.strings="?")
classes <- sapply(initial, class)
hpc <- read.table("household_power_consumption.txt", 
                  header = TRUE, sep = ";", colClasses = classes, na.strings="?")

## And we see the names of the variables we are going to be working with
names(hpc)

## Next we transform the "Date" and "Time" variables into Date class
hpc[, 1] <- as.Date(hpc[, 1], format="%d/%m/%Y")
hpc[, 2] <- as.Date(hpc[, 2], format="%H:%M:%S")

## We transform the other variables into numeric variables 
hpc$Global_active_power <- as.numeric(as.character(hpc$Global_active_power))
hpc$Global_reactive_power <- as.numeric(as.character(hpc$Global_reactive_power))
hpc$Sub_metering_1 <- as.numeric(as.character(hpc$Sub_metering_1))
hpc$Sub_metering_2 <- as.numeric(as.character(hpc$Sub_metering_2))
hpc$Sub_metering_3 <- as.numeric(as.character(hpc$Sub_metering_3))
hpc$Voltage <- as.numeric(as.character(hpc$Voltage))

## Create a new variable called "DateTime" so that we may use it as our x axix
## in some of our plots
hpc$DateTime <- paste(hpc$Date, hpc$Time, sep = ":")

## And subset the data that are within "2007-02-01" and "2007-02-02"
date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")
hpc <- hpc[hpc$Date %in% date1:date2, ]

## And finally we transform the DateTime variable into Date class as well
hpc$DateTime <- strptime(hpc$DateTime, format = "%Y-%m-%d:%H:%M:%S", tz = "")

## HERE IS OUR PLOT (plot 3):

plot(hpc$DateTime, hpc$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(hpc$DateTime, hpc$Sub_metering_2, type = "l", col = "red")
lines(hpc$DateTime, hpc$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = "l", col = c("black", "red", "blue"), 
       legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))

## And here is the code for its pgn file

png("plot3.png", 480, 480)
plot(hpc$DateTime, hpc$Sub_metering_1, type = "l", xlab = "", ylab = "Energy Sub Metering")
lines(hpc$DateTime, hpc$Sub_metering_2, type = "l", col = "red")
lines(hpc$DateTime, hpc$Sub_metering_3, type = "l", col = "blue")
legend("topright", pch = "l", col = c("black", "red", "blue"), 
       legend = c("Sub Metering 1", "Sub Metering 2", "Sub Metering 3"))
dev.off()
