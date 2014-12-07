# Coursera: Exploratory Data Analysis, Course Project 1
#
# plot3.R

# Make data directory and fetch data file if not exists
if (!file.exists("data")) {
    dir.create("data")
}
if (!file.exists("data/exdata_data_household_power_consumption.zip")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, destfile="data/exdata_data_household_power_consumption.zip", method="curl")
}

# Read data from zip file
data <- read.csv(unz("data/exdata_data_household_power_consumption.zip",
                     "household_power_consumption.txt"),
                 sep=";", stringsAsFactors=FALSE, na.strings="?")

# Time interval we are focusing on
startDate <- as.Date("2007-02-01")
endDate   <- as.Date("2007-02-02")

# Filter out needless data, keeping only observations within the required time interval
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- data[data$Date >= startDate & data$Date <= endDate, ]

# Create x-axis timeline for plotting by combining date and time
t <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Plot energy sub meterings 1-3 over the time period in different colors with legend
png(filename="plot3.png", width=480, height=480, units="px")
plot(t, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(t, data$Sub_metering_2, type="l", col="red")
lines(t, data$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lty=1)
dev.off()