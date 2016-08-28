######################################################################
# Project 1 - Plot 4
# The function performs the following operations
#   * Loads the electic power consumption data
#   * subsets the data to include only the Feb 1 & 2 2007 data
#   * creates a new variable DateTime and converts to POSTIXlt format
#   * Plots several charts in plot4.png file:
#       * line chart of the date/time vs. household global minute averaged active 
#       * line char of the date/time vs. minute-averaged voltage (in volts)
#       * line chart of the date/time vs. energy sub-metering readings
#         (in watt-hour of active energy)
#       * line chart of the date/time vs. household global minute averaged reactive 
#         power (in kilowatts)
######################################################################
plot4 <- function() {
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
  png(file="plot4.png", bg="transparent", width = 480, height = 480)
  par(mfrow=c(2,2))
  with(usage, {
    plot(usage$DateTime, usage$Global_active_power, type="l", ylab = "Global Active Power", xlab = "")
    plot(usage$DateTime, usage$Voltage, type="l", ylab = "Voltage", xlab = "datetime")
    plot(usage$DateTime, usage$Sub_metering_1, type="l", ylab = "Energy sub metering", xlab = "")
    lines(usage$DateTime, usage$Sub_metering_2, col="red")
    lines(usage$DateTime, usage$Sub_metering_3, col="blue")
    legend("topright", lwd=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.75, bty = "n")
    plot(usage$DateTime, usage$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")
  })
  dev.off()
}