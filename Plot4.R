# Set the working directory to the location of the household power text file
setwd("~/Learning/Johns Hopkins/R_Work/exdata-data-household_power_consumption")

# I first read the data so that each line was a character string and then used head() to see how the data was organized
# We could see a header with the column names and that the delimeter was ";"
# This part of the exploration was removed from the script
# Using read.csv2 (which has ";" as default delimeter) read the entire file to a df called "data"
# Data files with numeric values are corrupted if colClasses = "character", columns are read as Factor unwanted.
data <- read.csv2("household_power_consumption.txt", na.strings = "?", colClasses = "character")

# Date is a character but we need to turn it into a  Date using as.Date and giving the appropriate format
# The format is more difficult than it may seem capital "Y" indicates a 4-digit year
# Small "m' indicates month as a 2 digit number,  Look at the data and look up the format keys before using as.Date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# A subset data.frame called dataSub is obtained by limiting the data to only 2 dates
dataSub <- subset(data,data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

# in data and dataSub the Date and Time are in 2 columns.  
# We need to convert the 2 together to a single Date/Time column.  We create a second subset of data with this extra column
# called "timestamp"
dataSub2 <- within(dataSub, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y/%m/%d %H:%M:%S") })

# Set mfrow parameter to 2x2, cex is a scaling factor... the default made letters too big!
par(mfrow = c(2,2), cex = 0.7)

# the first plot is a line plot of the power vs. time.  Having the timestamp column in the format shown above is important!
# first we create the x and y lables.  The xlable is just to supress the default
ylab <- "Global Active Power (kiloWatts)"
xlab <- ""

# values were read in as character and they need to be converted to numeric
x2 <- as.POSIXct(dataSub2$timestamp)
y2 <- as.numeric(dataSub2$Global_active_power)

# then we plot a line plot type = "l" otherwise we get points by default
plot(x2, y2, type = "l", ylab = ylab, xlab = xlab)

# filling is by rows, so the next plot is time vs voltage (in this plot the x axis label is "datetime")
# the ylab for this plot is "Voltage"
xlab <- "datetime"
ylab = "Voltage"

# x-axis is the same as the previous plot, y-axis is voltage 
y6 <- as.numeric(dataSub2$Voltage)

# then we plot a line plot type = "l" otherwise we get points by default
plot(x2, y6, type = "l", ylab = ylab, xlab = xlab)

# The next plot has 3 sets of y-data for the same x2 time series (this is plot3 repeated)
y3 <- as.numeric(dataSub2$Sub_metering_1)
y4 <- as.numeric(dataSub2$Sub_metering_2)
y5 <- as.numeric(dataSub2$Sub_metering_3)

# on this graph xlab is suppressed and ylab is "Energy sub metering"
xlab <- ""
ylab <- "Energy sub metering"

# we use the "lines" function to add lines to an existing plot
# by trial and error the color codes are as follows 1 = black, 2 = red, 3 = green and 4 = blue
# this is not the color scheme reported when you look at help file for colors ?colors.

plot(x2, y3, type = "l", ylab = ylab, xlab = xlab, col = 1)
lines(x2, y4, type = "l", col = 2)
lines(x2, y5, type = "l", col = 4)

# Finally we add the legend to this plot. "topright" is the legend location, the next parameter are the labels
# lwd is the line width (value 1 in this case) "col" is the colors of the three lines and text.col is the color
# of the labels bty = "n" suppresses the box
labels <- c("sub_metering_1", "sub_metering_2", "sub_metering_3")
legend("topright", labels , lwd = 1, col = c(1,2,4), text.col = c(1,2,4), bty = "n")

# The last plot is time vs Global Reactive Power (in this plot the x axis label is "datetime")
# the ylab for this plot is "Voltage"
xlab <- "datetime"
ylab = "Global_reactive_power"

# x-axis is the same as the previous plot, y-axis is voltage 
y7 <- as.numeric(dataSub2$Global_reactive_power)

# then we plot a line plot type = "l" otherwise we get points by default
plot(x2, y7, type = "l", ylab = ylab, xlab = xlab)


# Now copy the entire plot to a .png file (apparently 480x480 pixels is the default so no need to specify)
dev.copy(png, file = "plot4.png")
dev.off()

# Set mfrow parameter to 1x1  and cex = 1(parameter reset)
par(mfrow = c(1,1), cex = 1)
