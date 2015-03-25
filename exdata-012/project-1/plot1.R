source("common.R")

par(mfrow=c(1, 1), mgp=c(3, 1, 0.5))
active_count = table(floor(2 * data$Global_active_power) / 2)
barplot(active_count,
        main="Global Active Power",
        xlab="Global Active Power (kilowatts)",
        ylab="Frequency",
        names.arg=FALSE,
        space=0,
        col="red")
axis(side=1, at=c(0, 4, 8, 12), labels=c(0, 2, 4, 6))
dev.copy(png, file="plot1.png")
dev.off()
