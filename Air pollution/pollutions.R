

#pollutants - nitrate or sulfate 


## calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. 
pollutantmean <- function(directory, pollutant, id = 1:332) {
   summ <- c()
   for (i in id){
      f <- paste(strrep('0', 3 - nchar(i)), i, sep = '')
      file <- read.csv(paste(f, '.csv', sep = ''))
      data <- file[[pollutant]][!is.na(file[[pollutant]])]
      summ <- c(summ, data)
   }
   mean(summ)
}

##  reads a directory full of files and reports the number of completely observed cases in each data file
complete <- function(directory, id = 1:332) {
   nobs <- c()
   for(i in id){
      f <- paste(strrep('0', 3 - nchar(i)), i, sep = '')
      file <- read.csv(paste(f, '.csv', sep = ''))
      nobs <- c(nobs, nrow(na.omit(file)))
   }
   data.frame(id = id, nobs = nobs)
}

##  takes a directory of data files and a threshold for complete cases and calculates the correlation between 
## sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. 
corr <- function(directory, threshold = 0) {
   cors <- c()
   for (file in list.files(directory)){
      table <- read.csv(file)
      table <- na.omit(table)
      if (nrow(table) > threshold){
         cors <- c(cors, cor(table[['nitrate']], table[['sulfate']]))
      }
   }
   cors
}

