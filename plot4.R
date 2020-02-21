  
library("data.table")

powerData <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)
powerData[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]
#  POSIXct 
powerData[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]
#we need to fiter the dates accordingly...........................
powerData <- powerData[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(powerData[, dateTime], powerData[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(powerData[, dateTime],powerData[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(powerData[, dateTime], powerData[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(powerData[, dateTime], powerData[, Sub_metering_2], col="red")
lines(powerData[, dateTime], powerData[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(powerData[, dateTime], powerData[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()