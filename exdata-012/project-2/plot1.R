source("common.R")

us_summary = inventory %>%
             group_by(year) %>%
             summarise(total_emission=sum(Emissions) / 1000)

MAIN = expression("Emissions from PM"[2.5]*" in US")
XLAB = ""
YLAB = "Total emission (in 1000 tones)"
YLIM = c(0, 7500)

# View as a barplot
barplot(us_summary$total_emission,
        main=MAIN, xlab=XLAB, ylab=YLAB,
        ylim=YLIM,
        axes=FALSE,
        space=0,
        col=BAR_COLOR)
axis(side=1, at=seq(0.5, 3.5, 1), labels=us_summary$year, col=OPAQUE)
axis(side=2, at=seq(0, 7500, length.out=6))
dev.copy(png, file="plot1.png", width=640, height=640)
dev.off()

# Alternative view - line plot
plot(us_summary$year, us_summary$total_emission,
     type="o", pch=16,
     main=MAIN, xlab=XLAB, ylab=YLAB,
     ylim=YLIM,
     xaxt="n", yaxt="n",
     col=PLOT_LINE_COLOR)
axis(side=1, at=us_summary$year)
axis(side=2, at=seq(0, 7500, length.out=6))
dev.copy(png, file="plot1-alt.png", width=640, height=640)
dev.off()
