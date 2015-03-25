source("common.R")

par(mfrow=c(1, 1), mgp=c(3, 1, 0))
plot(data$TimeStamp, data$Global_active_power,
     xlab="", ylab="Global Active Power (kilowatts)",
     type="l")
dev.copy(png, file="plot2.png")
dev.off()
