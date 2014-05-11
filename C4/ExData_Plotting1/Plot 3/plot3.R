#get the data
source("../init.R")

info <- getData()
png(filename = "plot3.png", width = 480, height = 480, units = "px")
columns = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(info$Date_Time, info$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(info$Date_Time, info$Sub_metering_2, type="l", col="red")
lines(info$Date_Time, info$Sub_metering_3, type="l", col="blue")
legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=columns)
dev.off()
