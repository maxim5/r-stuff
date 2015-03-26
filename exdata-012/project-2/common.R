library(dplyr)
library(magrittr)
library(ggplot2)

par(mar=c(5, 4, 4, 4), ps=12)

inventory = readRDS("summarySCC_PM25.rds") %>%
            subset(select=-c(Pollutant)) %>%    # holds only "PM25-PRI"
            tbl_df()
scc_mapping = readRDS("Source_Classification_Code.rds") %>% tbl_df()
