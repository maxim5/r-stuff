rankhospital = function(state, outcome, num="best") {
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

  csv[, var] = suppressWarnings(as.numeric(csv[, var]))             # convert variable to a numeric, ignoring "Not Available"
  filtered = subset(csv, State == state & !is.na(csv[[var]]))       # filter by state and valid variable value
  ordered = filtered[with(filtered,                                 # order by variable value and hospital name
                          order(filtered[[var]], Hospital.Name)), ]
  length = nrow(ordered)
  
  if (num == "worst") {
    index = length
  } else if (num == "best") {
    index = 1
  } else if (num > length) {
    return(NA)
  } else {
    index = num
  }
  
  ordered[index, c("Hospital.Name")]
}
