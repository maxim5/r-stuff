corr = function(directory, threshold=0) {
  result = c()
  for (i in 1:332) {
    filename = sprintf("%s/%03d.csv", directory, i)
    data = read.csv(filename)
    filtered = subset(data, !is.na(sulfate) & !is.na(nitrate))
    rows = nrow(filtered)
    if (rows > threshold) {
      current = cor(filtered$sulfate, filtered$nitrate)
      result = append(result, current)
    }
  }
  result
}
