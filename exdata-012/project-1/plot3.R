source("common.R")

par(mfrow=c(1, 1), mgp=c(3, 1, 0))
plot(data$TimeStamp, data$Sub_metering_1,
     type="l", xlab="", ylab="Energy sub metering",
     ylim=c(0, 40),
     yaxt="n")
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
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png")
dev.off()
