# Set the working directory to the location of the household power text file
setwd("~/Learning/Johns Hopkins/R_Work/exdata-data-household_power_consumption")

# I first read the data manually so that each line was a character string 
# and then used head() to see how the data was organized
# I could see a header with the column names and that the delimeter was ";" (European?)
# This part of the exploration was removed from the script
# Using read.csv2 (which has ";" as default delimeter) 
# read the entire file to a data.frame called "data"
# Data file reading will default to "Factor" even with numeric values 
# It's a better practice to use colClasses = "character", all columns read as character.
# The na.strings value was given in the problem as ?
data <- read.csv2("household_power_consumption.txt", na.strings = "?", colClasses = "character")

# Date is a character but we need to turn it into a  Date 
# using as.Date and giving the appropriate format
# The format is more difficult than it may seem 
# capital "Y" indicates a 4-digit year (small y a 2-digit year)
# Small "m' indicates month as a 2 digit number,  
# Look at the data and look up the format keys before using as.Date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# A subset data.frame called dataSub is obtained by limiting the data to only 2 dates
dataSub <- subset(data,data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

# I ran into problems after several plots because mfrow does not reset
# Set mfrow parameter to 1x1 (parameter reset in case this wasn't done previously)
par(mfrow = c(1,1))

# Plot a histogram in red (col = 2) with the title (main) and x label (xlab) as pre-defined
# Standard practice in EE is to capitalize the W in "Watts", abbreviation is kW
xlab = "Global Active Power (kiloWatts)"
main = "Global Active Power"
hist(as.numeric(dataSub$Global_active_power), col = 2, main = main, xlab = xlab)

# Now copy the plot to a .png file (apparently 480x480 pixels is the default so no need to specify)
dev.copy(png, file = "plot1.png")
dev.off()