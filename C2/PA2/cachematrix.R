## Create a special "matrix", which is really a list containing a function to
##   - get/set the value of a matrix
##   - get/set the value of the inverse of the matrix
makeCacheMatrix <- function(x = matrix()) {
    
	inverse <- NULL
	
	# getting the existing matrix
    get_matrix <- function() x
    
    # setting a new matrix
    set_matrix <- function(y) {
        x <<- y
        inverse <<- NULL
    }
	
	# getting the inverse matrix
    get_inverse <- function() inverse
            
    # setting the inverse matrix
    set_inverse <- function(inv_input) inverse <<- inv_input
        
    # return a list of all the functions
    list(set_matrix = set_matrix, get_matrix = get_matrix,
         set_inverse = set_inverse,
         get_inverse = get_inverse)
}

## Get the matrix generated with makeCacheMatrix, there are two options:
##   - Inverse it has already calculated: get the value from the cache.
##   - If not in cache: calculate the inverse and puts it in the cache (with set_inverse function)
cacheSolve <- function(x, ...) {
    #get the existing value from the cache
    inverse <- x$get_inverse()	
    if(is.null(inverse)) { #the cache hasn't an inverse matrix value
		#recover the matrix
		data <- x$get_matrix()
		#calculate the inverse of the matrix
		inverse <- solve(data, ...)
		#catching the inverse for next operations
		x$set_inverse(inverse)	 
    }
	return(inverse)
    
}
#Example of use:
x <- matrix(c(3,4,1,2), ncol = 2, byrow = TRUE)
message("\nMy matrix:\n")
print(x)
cache <- makeCacheMatrix(x)
message("\nInverse calculation (first time not in cache):\n")
print(cacheSolve(cache))
message("\nInverse calculation (result from cache):\n")
print(cacheSolve(cache))
message("\nVerifying the result: the matrix multiplied by the inverse it's must be the identity's matrix\n")
print(round(x %*% y))

