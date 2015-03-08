#load and filter data
myload <- function() {
	data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
	vec <- as.Date(data$Date, "%d/%m/%Y")
	data$Date <- vec
	vec <- as.numeric(data$Global_active_power)
	data$Global_active_power <- vec
	dateRange <- as.Date(c("2007-02-01", "2007-02-02"))
	data <- subset(data, Date %in% dateRange)
	data$NewDate <- as.POSIXct(paste(data$Date, data$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
	data
}

plot1 <- function(data) {
	plot(data$NewDate, data$Global_reactive_power, type="o", pch=".", xlab="", ylab="Global_rctive_power")
}

plot2 <- function(data) {
	plot(data$NewDate, data$Voltage, type="o", pch=".", xlab="datetime", ylab="Voltage")
}

plot3 <- function(data) {
	plot(data$NewDate, as.numeric(data$Sub_metering_1), type="o", pch=".", lwd=2, col="black", xlab="", ylab="Energy sub metering")	
	lines(data$NewDate, data$Sub_metering_2, col="red")
	lines(data$NewDate, data$Sub_metering_3, col="blue")
	legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, box.lty=0, lwd=2, pch=".",  col=c("black", "red", "blue"), inset=.02)
}

plot4 <- function(data) {
	plot(data$NewDate, data$Global_reactive_power, type="o", pch=".", xlab="datetime")
}

myplot <- function() {
	data <- myload()
	par(mfrow=c(2, 2))
	plot1(data)
	plot2(data)
	plot3(data)
	plot4(data)	
}

mysave <- function() {
	png("plot4.png", width=480, height=480, units="px")
	myplot()	
	dev.off()
}