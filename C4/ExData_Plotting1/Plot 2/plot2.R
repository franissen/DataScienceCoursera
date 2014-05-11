#get the data
source("../init.R")

info <- getData()
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(info$Date_Time, info$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
