best <- function(state, outcome){
   ## Read outcome data
   data <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
   states <- unique(data$State)
   ## i do it for indexes of needed columns
   outcomes <- c('heart attack' = 11, 'heart failure' = 17, 'pneumonia' = 23)
   ## Check that state and outcome are valid
   if(!(state %in% states)){
      stop('invalid state')
   }
   if(!(outcome %in% names(outcomes))){
      stop('invalid outcome')
   }
   i <- outcomes[[outcome]]
   data[,i] <- as.numeric(data[,i])
   hospitals <- na.omit(subset(data[, c(2, i)], subset = data$State == state))
   ## Return hospital name in that state with lowest 30-day death
   ## rate
   sort(subset(hospitals[,1], subset = hospitals[,2] == min(hospitals[,2])))
}

rankhospital <- function(state, outcome, num = "best"){
   ## Read outcome data
   data <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
   states <- unique(data$State)
   ## i do it for indexes of needed columns
   outcomes <- c('heart attack' = 11, 'heart failure' = 17, 'pneumonia' = 23)
   ## Check that state and outcome are valid
   if(!(state %in% states)){
      stop('invalid state')
   }
   if(!(outcome %in% names(outcomes))){
      stop('invalid outcome')
   }
   ## sorting data
   i <- outcomes[[outcome]]
   data[,i] <- as.numeric(data[,i])
   hospitals <- na.omit(subset(data[, c(2, i)], subset = data$State == state))
   hospitals <- hospitals[order(hospitals[,2]),]
   ## Return hospital name in that state with the given rank
   ## 30-day death rate
   if(num == "best") num <- 1
   if(num == "worst") num <- nrow(hospitals)
   #hospitals[num, 1]
   head(hospitals[, 1], 10)
}


rankall <- function(outcome, num = 'best'){
  if(num == "best") num <- 1
  n <- num
  ## Read outcome data
  data <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
  states <- sort(unique(data$State))
  ## i do it for indexes of needed columns
  outcomes <- c('heart attack' = 11, 'heart failure' = 17, 'pneumonia' = 23)
  ## Check that outcome is valid
  if(!(outcome %in% names(outcomes))){
    stop('invalid outcome')
  }
  df <- data.frame('hospital' = NA, 'state' = NA)
  i <- outcomes[[outcome]]
  data[,i] <- as.numeric(data[,i])
  df <- data.frame('hospital' = NA, 'state' = NA)
  ## For each state, find the hospital of the given rank
  for (s in states){
    hospitals <- na.omit(subset(data[, c(2, 7, i)], subset = data$State == s))
    hospitals <- hospitals[order(hospitals[,3]),]
    if(num == "worst") n <- nrow(hospitals)
    if(n > nrow(hospitals)){
      df[nrow(df) + 1,] <- data.frame('<NA>', s)
      n <- num
      next
    }
    df[nrow(df) + 1,] <- data.frame(hospitals[n, c(1, 2)])
    n <- num
  }
  ## Return a data frame with the hospital names and the
  ## (abbreviated) state name
  df[-1,]
}