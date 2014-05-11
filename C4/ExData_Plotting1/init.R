url_data <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
name_zip_file <- "household_power_consumption.zip"
name_txt_file <- "household_power_consumption.txt"
name_csv_file <- "../data.csv" 



getFile <- function(fileURL, fname) {
    if(!file.exists(fname)) {
        download.file(fileURL, destfile=fname)
    }
    fname
}

getData <- function() {

    if(file.exists(name_csv_file)) {
        info <- read.csv(name_csv_file)
        info$Date_Time <- strptime(info$Date_Time, "%Y-%m-%d %H:%M:%S") 
    }
    else {
        fname <- getFile(url_data, name_zip_file)
        con <- unz(fname, "household_power_consumption.txt")
        info <- read.table(con, header=T, sep=';', na.strings="?", colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
        info <- info[(info$Date == "1/2/2007") | (info$Date == "2/2/2007"),]
        info$Date_Time <- strptime(paste(info$Date, info$Time), "%d/%m/%Y %H:%M:%S")
        write.csv(info, name_csv_file)
    }
    info
}