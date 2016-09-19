#column types
colClss <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")


#reading the data directly from the host, interpreting '?' as Na's

zip_file <- paste0(getwd(), '/household_power_consumption.zip')
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = zip_file, method = "curl")
unzip(zip_file)


consumption <- read.csv("data/household_power_consumption.txt", 
                        colClasses = colClss, sep = ';', na.strings=c("?"),
                        nrows=2075259)

						
#concatenating date and time for plots 2-4				
consumption$full_date = paste(consumption$Date, consumption$Time, sep=" ")
consumption$full_date = strptime(consumption$full_date, "%d/%m/%Y %H:%M:%S")


#cast the data types
consumption$Date = as.Date(consumption$Date, "%d/%m/%Y")
consumption$Time = as.Date(consumption$Time, "%H:%M:%S")


#constraints for the dates
startDate = as.Date("2007-02-01", "%Y-%m-%d")
endDate = as.Date("2007-02-02", "%Y-%m-%d")
 
#select subset of data between the startDate and endDate 
needed_consumption <- subset(consumption, (Date >= startDate & Date <= endDate))

#plot

png(file = "plot4.png", width=480, height=480)


par(mfrow=c(2,2))

with(needed_consumption, plot(full_date, Global_active_power, type = "l", 
                              ylab="Global Active Power (Kilowatt)", xlab = ""))

with(needed_consumption, plot(full_date, Voltage, type = "l", 
                              ylab="Voltage", xlab = "datetime"))


plot(needed_consumption$full_date, needed_consumption$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(needed_consumption$full_date, needed_consumption$Sub_metering_2, type = "l", col = "red")
lines(needed_consumption$full_date, needed_consumption$Sub_metering_3, type = "l", col = "blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1)

with(needed_consumption, plot(full_date, Global_reactive_power, type = "l", 
                              xlab = "datetime"))

dev.off()
