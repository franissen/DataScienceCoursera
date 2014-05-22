pollutantmean <- function(directory, pollutant, id = 1:332) {
    ## 'directory' is a character vector of length 1 indicating
    ## the location of the CSV files

    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".

    ## 'id' is an integer vector indicating the monitor ID numbers
    ## to be used

    ## Return the mean of the pollutant across all monitors list
    ## in the 'id' vector (ignoring NA values)

    info<-data.frame()

    for(csvFile in rep(id)){
        csvFile<-sprintf("%03d.csv", csvFile)
        #pollutantData<-rbind(pollutantData,read.table(paste(directory,"/",sprintf("%03d", cvsFile),".csv",sep=""),sep=",",header=TRUE))
        info<-rbind(info,read.table(paste(directory,"/",csvFile,sep=""),sep=",",header=TRUE))
    }

    mean(as.matrix(info[pollutant]), na.rm=TRUE)


}

#pollutantmean("specdata", "sulfate", 1:10)