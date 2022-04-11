
## this function creates a "matrix", i.e. a list of functions to set/get the 
## matrix and to set/get the inverse matrix

makeCacheMatrix <- function(x = matrix()) {
   m <- NULL
   set <- function(y){
      y <<- x
      m <<- NULL
   }
   get <- function() x
   setsolve <- function(solve) m <<- solve
   getsolve <- function() m
   list(set = set, get = get, setsolve = setsolve, getsolve = getsolve)
}


## this function takes a "matrix" returned by makeCacheMatrix and calculates
## (or retrieves from cache) and returns the inverse one.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
   m <- x$getsolve()
   if (!is.null(m)){
      message('getting cached data')
      return(m)
   }
   data <- x$get()
   m <- solve(data, ...)
   x$setsolve(m)
   m
}
