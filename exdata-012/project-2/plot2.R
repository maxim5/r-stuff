source("common.R")

baltimore = inventory %>%
            filter(fips == "24510") %>%
            group_by(year) %>%
            summarise(total_emission=sum(Emissions))

MAIN = expression("Emissions from PM"[2.5]*" in Baltimore City")
XLAB = ""
YLAB = "Total emission (in tones)"
YLIM = c(0, 4000)

# View as a barplot
barplot(baltimore$total_emission,
        main=MAIN, xlab=XLAB, ylab=YLAB,
        ylim=YLIM,
        axes=FALSE,
        space=0,
        col=BAR_COLOR)
axis(side=1, at=seq(0.5, 3.5, 1), labels=baltimore$year, col=OPAQUE)
axis(side=2, at=seq(0, 4000, length.out=5))
dev.copy(png, file="plot2.png", width=640, height=640)
dev.off()

# Alternative view - line plot
plot(baltimore$year, baltimore$total_emission,
     type="o", pch=16,
     main=MAIN, xlab=XLAB, ylab=YLAB,
     ylim=YLIM,
     xaxt="n", yaxt="n",
     col=PLOT_LINE_COLOR)
axis(side=1, at=baltimore$year)
axis(side=2, at=seq(0, 4000, length.out=5))
dev.copy(png, file="plot2-alt.png", width=640, height=640)
dev.off()
