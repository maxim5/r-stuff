library(dplyr)
library(magrittr)
library(ggplot2)
library(grid)

inventory = readRDS("summarySCC_PM25.rds") %>%
            subset(select=-c(Pollutant)) %>%    # holds only "PM25-PRI"
            tbl_df()
scc_mapping = readRDS("Source_Classification_Code.rds") %>% tbl_df()

BAR_COLOR = "#00BFC4"
BAR_BORDER_COLOR = "#AAAAAA"
PLOT_LINE_COLOR = "darkgreen"
OPAQUE = rgb(0, 0, 0, 0)
POINT_FILL_COLOR = "white"

par(mar=c(5, 7, 4, 4), mfrow=c(1, 1), mgp=c(4, 1.5, 1), ps=12)
