source("common.R")

baltimore = inventory %>%
  filter(fips == "24510") %>%
  group_by(year) %>%
  summarise(total_emission=sum(Emissions))

par(mfrow=c(1, 1), mgp=c(3, 1.5, 1))
barplot(baltimore$total_emission,
        main="Total emissions from PM2.5 in Baltimore City",
        xlab="",
        ylab="Total emission (in tones)",
        ylim=c(0, 4000),
        axes=FALSE,
        space=0,
        col="green")
axis(side=1, at=seq(0.5, 3.5, 1), labels=baltimore$year)
axis(side=2, at=seq(0, 4000, length.out=5))
dev.copy(png, file="plot2.png")
dev.off()
