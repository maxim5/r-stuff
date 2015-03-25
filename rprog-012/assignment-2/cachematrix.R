# Returns a helper object holding the methods to access the current
# matrix value and its inverse.
# Upon matrix reset, the inverse is reset.
# Argument m - a square matrix
makeCacheMatrix = function(m=matrix()) {
  cache = NULL
  list(set.matrix = function(value) {
         m <<- value
         cache <<- NULL
       },
       get.matrix = function() m,
       set.inverse = function(value) cache <<- value,
       get.inverse = function() cache)
}

# Computes and returns the inverse matrix given the
# specified helper object. If `obj' already holds the
# inverse matrix in cache, it is returned immediately.
# Otherwise it is put in cache.
# Argument obj - a helper object returned by `makeCacheMatrix'.
# ... arguments are passed to `solve', when it is called.
cacheSolve = function(obj, ...) {
  cache = obj$get.inverse()
  if (!is.null(cache)) {
    message("getting cached data")
    return(cache)
  }
  data = obj$get.matrix()
  result = solve(data, ...)
  obj$set.inverse(result)
  result
}
