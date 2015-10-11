mydata <- read.table("household_power_consumption.txt", sep = ";", header = TRUE)

mydata$Date <- as.Date(mydata$Date, format="%d/%m/%Y")

newdata <- subset(mydata, Date == "2007-02-01" | Date == "2007-02-02")

# conversion to numeric format
newdata$Global_active_power <- as.numeric(as.character(newdata$Global_active_power))

# Plot1
png("plot1.png", width = 480, height = 480)
hist(newdata$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()