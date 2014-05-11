#get the data
source("../init.R")

info <- getData()
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(info$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()
