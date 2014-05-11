# Jae Lim
# Exploratory Data Analysis
# Course Project 1 - 5/9/14
# plot1.R


# Change to working directory & Create data directory if non-existent
setwd("~/ExData_Plotting1/myProject1")

if (!file.exists("data")) {
  dir.create("data")
}

# Load Data.table library package
# Open data file with missing values (?) removed
require(data.table)
dt <- fread("./data/household_power_consumption.txt", colClass=rep("character",9), na.strings="?")
dt <- na.omit(dt)

# Reformat Date column as %Y-%m-%d
# Subsetting data for dates 2007-02-01 to 2007-02-02
dt$Date <- as.Date(as.character(dt$Date), format="%d/%m/%Y")
subDt <- subset(dt, dt$Date %in% as.Date(c('2007-02-01','2007-02-02')))

# Merge Date & Time columns together in format %Y-%m-%d %H:%M:%S
dtString <- with(subDt, paste(Date,Time))
subDt$datetime <- as.POSIXct(strptime(dtString, "%Y-%m-%d %H:%M:%S"))

# Remove old column values Date & Time from data.table
# Put datetime to first column location
subDt[, c("Date","Time"):=NULL]
colNames <- names(subDt)
setcolorder(subDt, c(colNames[8], colNames[1:7]))

# Start a png() device to save plot
png(file="./plot1.png", bg="transparent", width=480, height=480)

# Plot Global Active Power Histogram
gap <- as.numeric(subDt$Global_active_power)
hist(gap, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency")

# Turn off png() device
dev.off()
