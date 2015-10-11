mydata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

# Creating timestamps
timestamps <- as.POSIXct(paste(mydata$Date, mydata$Time), format="%d/%m/%Y %H:%M:%S")
mydata$timestamps <- timestamps

mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")

# Just the 2 days data
newdata <- subset(mydata, Date == "2007-02-01" | Date == "2007-02-02")
newdata$Global_active_power <- as.numeric(as.character(newdata$Global_active_power))
newdata$Global_reactive_power <- as.numeric(as.character(newdata$Global_reactive_power))
newdata$Voltage <- as.numeric(as.character(newdata$Voltage))

met1 <- as.numeric(as.character(newdata$Sub_metering_1))
met2 <- as.numeric(as.character(newdata$Sub_metering_2))
met3 <- as.numeric(as.character(newdata$Sub_metering_3))

# Plot4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
# Top left
plot(newdata$timestamps, newdata$Global_active_power, xlab = "", ylab = "Global Active Power", type = "l")
# Top right
plot(newdata$timestamps, newdata$Voltage, xlab = "datetime", ylab = "Voltage", type = "l")
# Bottom left
plot(newdata$timestamps, met1, xlab = "", ylab = "Energy sub metering", type = "l")
lines(newdata$timestamps, met2, col = "red")
lines(newdata$timestamps, met3, col = "blue")
legend(x="topright", 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black","red","blue"), lwd=1, lty=c(1, 1, 1), 
       pch=c(NA, NA, NA), merge = FALSE)
# Bottom right
plot(newdata$timestamps, newdata$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power", type = "l")

dev.off()
