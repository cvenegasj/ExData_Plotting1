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

# Plot2
png("plot2.png", width = 480, height = 480)
plot(newdata$timestamps, newdata$Global_active_power, ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()