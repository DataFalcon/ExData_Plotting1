# Set the working directory to the location of the household power text file
setwd("~/Learning/Johns Hopkins/R_Work/exdata-data-household_power_consumption")

# I first read the data so that each line was a character string and then used head() to see how the data was organized
# I could see a header with the column names and that the delimeter was ";"
# This part of the exploration was removed from the script
# Using read.csv2 (which has ";" as default delimeter) read the entire file to a data.frame called "data"
# Data files with numeric values are corrupted unless colClasses = "character", columns are read as Factor unwanted.
data <- read.csv2("household_power_consumption.txt", na.strings = "?", colClasses = "character")

# Date is a character but we need to turn it into a  Date using as.Date and giving the appropriate format
# The format is more difficult than it may seem capital "Y" indicates a 4-digit year
# Small "m' indicates month as a 2 digit number,  Look at the data and look up the format keys before using as.Date
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

# A subset data.frame called dataSub is obtained by limiting the data to only 2 dates
dataSub <- subset(data,data$Date >= "2007-02-01" & data$Date <= "2007-02-02")

# Set mfrow parameter to 1x1 (parameter reset)
par(mfrow = c(1,1))
# in data and dataSub the Date and Time are in 2 columns.  
# We need to convert the 2 together to a single Date/Time column.  We create a second subset of data with this extra column
# called "timestamp"
dataSub2 <- within(dataSub, { timestamp=format(as.POSIXct(paste(Date, Time)), "%Y/%m/%d %H:%M:%S") })

# the next plot is a line plot of the power vs. time.  Having the timestamp column in the format shown above is important!
# first we create the x and y lables.  The xlable is just to supress the default
ylab <- "Global Active Power (kiloWatts)"
xlab <- ""

# values were read in as factor and they need to be converted to numeric
x2 <- as.POSIXct(dataSub2$timestamp)
y2 <- as.numeric(dataSub2$Global_active_power)

# then we plot a line plot type = "l" otherwise we get points by default
# setting the aspect ratio "asp" to 1 will ensure that the plot is the same shape as the exported plot
plot(x2, y2, type = "l", ylab = ylab, xlab = xlab)

# Now copy the plot to a .png file (apparently 480x480 pixels is the default so no need to specify)
dev.copy(png, file = "plot2.png")
dev.off()
