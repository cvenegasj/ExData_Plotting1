mydata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Creating timestamps
timestamps <- as.POSIXct(paste(mydata$Date, mydata$Time), format="%d/%m/%Y %H:%M:%S")
mydata$timestamps <- timestamps

mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")

# Just the 2 days data
newdata <- subset(mydata, Date == "2007-02-01" | Date == "2007-02-02")
newdata$Global_active_power <- as.numeric(newdata$Global_active_power)
# To kilowatts
newdata$Global_active_power <- newdata$Global_active_power / 1000


# Plot4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
# Top left
plot(newdata$timestamps, newdata$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l")
# Top right
plot(newdata$timestamps, newdata$Voltage, type = "l")
# Bottom left
plot(newdata$timestamps, newdata$Sub_metering_1, ylab = "Energy sub metering", type = "l")
points(newdata$timestamps, newdata$Sub_metering_2, col = "red", type = "l", pch = 1)
points(newdata$timestamps, newdata$Sub_metering_3, col = "blue", type = "l", pch = 1)
legend(x="topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red","blue"), lwd=1, lty=c(1, 1, 1), 
       pch=c(NA, NA, NA), merge = FALSE)
# Bottom right
plot(newdata$timestamps, newdata$Global_reactive_power, type = "l")

dev.off()
