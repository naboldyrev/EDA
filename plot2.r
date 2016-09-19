#column types
colClss <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")


#reading the data, interpreting '?' as Na's
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

png(file = "plot2.png", width=480, height=480)
with(needed_consumption, plot(full_date, Global_active_power, type = "l", 
                              ylab="Global Active Power (Kilowatt)", xlab = ""))
dev.off()