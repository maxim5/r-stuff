clean_data = function(directory="specdata", pollutant, i) {
  filename = sprintf("%s/%03d.csv", directory, i)
  data = read.csv(filename)
  pv = data[,pollutant]
  pv[complete.cases(pv)]
}

pollutantmean = function(directory, pollutant, id=1:332) {
  all = c()
  for (i in id) {
    current = clean_data(directory, pollutant, i)
    all = append(all, current)
  }
  mean(all)
}
