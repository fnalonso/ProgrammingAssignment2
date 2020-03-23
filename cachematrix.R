## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function
##
## This function have the same code structure as the example above, I just made some variable
## name change for readabilty.
##

makeCacheMatrix <- function(x = matrix()) {
    # Everytime an instance is created the solve_value is set to NULL
    solve_value <- NULL
    # This function set a new matrix value and set the solve value to null
    # to ensure a new calcutation on next `$get_solve_value` invocation.
    set <- function(m){
        x <- m
        solve_value <<- NULL
    }
    # return the current matrix value
    get <- function() x
    # Receive the solve value and set to the `solve_value` in the parent env using
    # the 'super assingment' operator.
    set_solve_value <- function(solve_value) solve_value <<- solve_value
    # Return the current solve value.
    get_solve_value <- function() solve_value
    # Return all functions in a list
    list(set = set, get = get, get_solve_value = get_solve_value,
         set_solve_value = set_solve_value)
}


## Write a short comment describing this function
##
## Same code structure as the example
##
cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'
    # Read the current calculated solve value from x
    s<-x$get_solve_value()
    # If the value is not null then just return it.
    if(!is.null(s)){
        print("Recovering value from cache")
        return(s)
    }
    # The s value is NULL so is use the solve() function is necessary to
    # invert the matrix.
    # get the current matrix on x
    m<-x$get()
    # Invert the matrix using solve()
    s<-solve(m)
    # Store the result on x to be used as cache
    x$set_solve_value(s)
    # return the inverted matrix
    s
}

####################
##   How to use   ##
####################
sym_matrix <- matrix( c(4, 2, 2,
                        2, 3, 1,
                        2, 1, 3), nrow=3, byrow=TRUE)

cached_matrix <- makeCacheMatrix(sym_matrix)
cacheSolve(cached_matrix)
