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

myplot <- function() {
	data <- myload()	
	plot(data$NewDate, as.numeric(data$Sub_metering_1), type="o", pch=".", lwd=2, col="black", xlab="", ylab="Energy sub metering")	
	lines(data$NewDate, data$Sub_metering_2, col="red")
	lines(data$NewDate, data$Sub_metering_3, col="blue")
	legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, pch=".",  col=c("black", "red", "blue"))
}

mysave <- function() {
	png("plot3.png", width=480, height=480, units="px")
	myplot()	
	dev.off()
}