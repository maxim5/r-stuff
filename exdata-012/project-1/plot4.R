source("common.R")

par(mfrow=c(2, 2), mgp=c(2.5, 1, 0))

plot(data$TimeStamp, data$Global_active_power,
     xlab="", ylab="Global Active Power",
     type="l")

plot(data$TimeStamp, data$Voltage,
     xlab="datetime", ylab="Voltage",
     type="l")

plot(data$TimeStamp, data$Sub_metering_1,
     type="l", xlab="", ylab="Energy sub metering",
     ylim=c(0, 40),
     yaxt='n')
axis(side=2, at=c(0, 10, 20, 30))
par(new=T)
plot(data$TimeStamp, data$Sub_metering_2,
     xlab="", ylab="",
     type="l", axes=F, col="red",
     ylim=c(0, 40))
par(new=T)
plot(data$TimeStamp, data$Sub_metering_3,
     xlab="", ylab="",
     type="l", axes=F, col="blue",
     ylim=c(0, 40))
legend("topright",
       lty = c(1, 1, 1), col=c("black", "red","blue"),
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       bty="n")
par(new=F)

plot(data$TimeStamp, data$Global_reactive_power,
     xlab="datetime", ylab="Global reactive power",
     type="l")

dev.copy(png, file="plot4.png")
dev.off()
