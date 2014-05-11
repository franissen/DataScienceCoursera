#get the data
source("../init.R")

info <- getData()
columns = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
png(filename = "plot4.png", width = 480, height = 480, units = "px")   
par (mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(info, {	
	plot(Date_Time, Global_active_power, xlab="", ylab="Global Active Power", type="l")
	plot(Date_Time, Voltage, xlab="datetime", ylab="Voltage", type="l")        	
	plot(Date_Time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
	lines(Date_Time, Sub_metering_2, type="l", col="red")
	lines(Date_Time, Sub_metering_3, type="l", col="blue")
	legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=columns, bty="n")        
	plot(Date_Time, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")
})
dev.off()

