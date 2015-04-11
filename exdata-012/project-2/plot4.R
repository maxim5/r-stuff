source("common.R")

sectors = unique(scc_mapping$EI.Sector)
coal_sectors = sectors[grep("Coal", sectors)]
coal_mapping = scc_mapping %>% filter(EI.Sector %in% coal_sectors)

coal_summary = inventory %>%
               filter(SCC %in% coal_mapping$SCC) %>%
               group_by(year) %>%
               summarise(total_emission=sum(Emissions) / 1000)

TITLE = expression("Emissions from PM"[2.5]*" from coal combustion-related sources")
XLAB = ""
YLAB = "Total emission (in 1000 tones)"
THEME = theme(plot.margin=unit(c(1,1,1,1), "cm"),
              plot.title=element_text(vjust=2),
              axis.title.y=element_text(angle=90, vjust=2))

# View as a barplot
ggplot(coal_summary,
       aes(x=as.factor(year), y=total_emission)) + 
  geom_bar(stat="identity", fill=BAR_COLOR, colour=BAR_BORDER_COLOR) + 
  labs(title=TITLE, x=XLAB, y=YLAB) +
  THEME
ggsave("plot4.png")

# Alternative view - a line plot
ggplot(coal_summary,
       aes(x=year, y=total_emission)) + 
  geom_line(colour=PLOT_LINE_COLOR) +
  geom_point(size=4, shape=21, fill=POINT_FILL_COLOR) +
  scale_x_continuous(breaks = seq(min(coal_summary$year), max(coal_summary$year), by=3)) +
  scale_y_continuous(limits=c(0, max(coal_summary$total_emission))) +
  labs(title=TITLE, x=XLAB, y=YLAB) +
  THEME
ggsave("plot4-alt.png")
