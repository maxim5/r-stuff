best = function(state, outcome) {
  csv = read.csv("outcome-of-care-measures.csv", stringsAsFactors=F)
  
  if (!(state %in% csv$State)) {
    stop("invalid state")
  }
  if (!(outcome %in% c("heart attack", "heart failure", "pneumonia"))) {
    stop("invalid outcome")
  }
  
  var = if (outcome == "heart attack") {
    "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"
  } else if (outcome == "heart failure") {
    "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"
  } else {
    "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"
  }
  
  csv[, var] = suppressWarnings(as.numeric(csv[, var]))        # convert variable to a numeric, ignoring "Not Available"
  filtered = subset(csv, State == state & !is.na(csv[[var]]))  # filter by state and valid variable value
  best = filtered[which(filtered[var] == min(filtered[var])),] # select best rows
  hospitals = best$Hospital.Name                               # hospital names
  return(min(hospitals))
}
