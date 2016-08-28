######################################################################
# Project 1 - Plot 3
# The function performs the following operations
#   * Loads the electic power consumption data
#   * subsets the data to include only the Feb 1 & 2 2007 data
#   * creates a new variable DateTime and converts to POSTIXlt format
#   * Plots a line chart of the date/time vs. energy sub-metering readings
#     (in watt-hour of active energy) in a 480 X 480 png file named plot3.png
######################################################################
plot3 <- function() {
  # data load
  data <- read.table("household_power_consumption.txt",na.strings = "?", sep=";", header = TRUE, stringsAsFactors = TRUE)
  # data filter to Feb. 1 & 2 2007
  usage <- subset(data, Date=="1/2/2007" | Date =="2/2/2007")
  # remove original data set
  rm(data)
  # merge Date & Time fields
  usage$DateTime <- paste(usage$Date, usage$Time, sep= " ")
  # convert new DateTime filed to POSIXlt type
  usage$DateTime <- strptime(usage$DateTime, format = "%d/%m/%Y %H:%M:%S")
  
  # Plot chart in png
  png(file="plot3.png", bg="transparent", width = 480, height = 480)
  with( usage, {
    plot(DateTime, Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
    lines(DateTime, Sub_metering_2, col="red")
    lines(DateTime, Sub_metering_3, col="blue")
    legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  })
  dev.off()
}