#load and filter data
load <- function() {
	data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
	vec <- as.Date(data$Date, "%d/%m/%Y")
	data$Date <- vec
	vec <- as.numeric(data$Global_active_power)
	data$Global_active_power <- vec
	dateRange <- as.Date(c("2007-02-01", "2007-02-02"))
	data <- subset(data, Date %in% dateRange)
	data
}

plot <- function() {
	data <- load()
	opt <- options(scipen = 10)
	hist(data$Global_active_power, 
		main="Global Active Power", 
		breaks=24, 
		xlab="Global Active Power (kilowatts)", 
		ylab="Frequency",
		col=c("red"))
}

save <- function() {
	png("plot1.png", width=480, height=480, units="px")
	plot()	
	dev.off()
}