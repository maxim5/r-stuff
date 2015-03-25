complete = function(directory, id=1:332) {
  result = data.frame(id=c(), nobs=c())
  for (i in id) {
    filename = sprintf("%s/%03d.csv", directory, i)
    data = read.csv(filename)
    filtered = subset(data, !is.na(sulfate) & !is.na(nitrate))
    rows = nrow(filtered)
    result = rbind(result, data.frame(id=i, nobs=rows))
  }
  result
}
