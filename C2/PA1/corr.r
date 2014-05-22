corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  
  correlations_vector<-numeric()
  for(csvFile in list.files(directory)){
    info<-read.table(paste(directory,"/",csvFile,sep=""),sep=",",header=TRUE)
    observations<-nrow(info[complete.cases(info),])
    if(observations>threshold){
      correlations_vector<-c(correlations_vector,cor(info$nitrate,info$sulfate,use="complete.obs"))
    }
  }
  as.numeric(correlations_vector)
}