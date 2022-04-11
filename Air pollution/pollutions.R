
PATH <- 'C:/Users/dasha/Desktop/coursera/specdata/'

#pollutants - nitrate or sulfate 

pollutantmean <- function(directory, pollutant, id = 1:332) {
   summ <- c()
   for (i in id){
      f <- paste(directory, paste(strrep('0', 3 - nchar(i)), i, sep = ''), sep = '')
      file <- read.csv(paste(f, '.csv', sep = ''))
      data <- file[[pollutant]][!is.na(file[[pollutant]])]
      summ <- c(summ, data)
   }
   mean(summ)
}

complete <- function(directory, id = 1:332) {
   nobs <- c()
   for(i in id){
      f <- paste(directory, paste(strrep('0', 3 - nchar(i)), i, sep = ''), sep = '')
      file <- read.csv(paste(f, '.csv', sep = ''))
      nobs <- c(nobs, nrow(na.omit(file)))
   }
   data.frame(id = id, nobs = nobs)
}

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

