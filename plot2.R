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
	plot(data$NewDate, data$Global_active_power, type="o", pch=".", xlab="", ylab="Global Active Power (kilowatts)")
}


mysave <- function() {
	png("plot2.png", width=480, height=480, units="px")
	myplot()	
	dev.off()
}