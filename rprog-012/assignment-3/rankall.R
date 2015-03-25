rankall = function(outcome, num="best") {
  csv = read.csv("outcome-of-care-measures.csv", colClasses="character", na.strings="Not Available")
  
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

  states = sort(unique(csv$State))
  csv = csv[ ,names(csv) %in% c(var, "State", "Hospital.Name")]
  csv[, var] = as.numeric(csv[, var])
  
  hospital = c()
  for (state in states) {
    filtered = subset(csv, State == state & !is.na(csv[[var]]))       # filter by state and valid variable value
    ordered = filtered[with(filtered,                                 # order by variable value and hospital name
                            order(filtered[[var]], Hospital.Name)), ]
    length = nrow(ordered)
    
    if (num == "worst") {
      index = length
    } else if (num == "best") {
      index = 1
    } else if (num > length) {
      index = 0
    } else {
      index = num
    }
    
    value = if (index > 0) ordered[index, "Hospital.Name"] else NA
    hospital = append(hospital, value)
  }
  data.frame(hospital=hospital, state=states, row.names=states)
  
  # Nice idea, but it does not work:
  # csv$Rank = ave(csv[[var]], csv$State, FUN=rank)
  # csv[csv$Rank == num, c("State", "Hospital.Name", var)]
}
