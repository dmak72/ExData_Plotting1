######################################################################
# Project 1 - Plot 1
# The function performs the following operations
#   * Loads the electic power consumption data
#   * subsets the data to include only the Feb 1 & 2 2007 data
#   * creates a new variable DateTime and converts to POSTIXlt format
#   * Plots a histogram of the household global minute averaged active 
#     power (in kilowatts) in a 480 X 480 png file named plot1.png
######################################################################
plot1 <- function() {
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
  png(file="plot1.png", bg="transparent", width = 480, height = 480)
  hist(usage$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
  dev.off()
}