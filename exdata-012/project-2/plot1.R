source("common.R")

us_summary = inventory %>%
  group_by(year) %>%
  summarise(total_emission=sum(Emissions) / 1000)

par(mfrow=c(1, 1), mgp=c(3, 1.5, 1))
barplot(us_summary$total_emission,
        main="Total emissions from PM2.5 in US",
        xlab="",
        ylab="Total emission (in 1000 tones)",
        ylim=c(0, 7500),
        axes=FALSE,
        space=0,
        col="green")
axis(side=1, at=seq(0.5, 3.5, 1), labels=us_summary$year)
axis(side=2, at=seq(0, 7500, length.out=6))
dev.copy(png, file="plot1.png")
dev.off()
