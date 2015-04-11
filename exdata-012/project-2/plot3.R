source("common.R")

baltimore_types = inventory %>%
                  filter(fips == "24510") %>%
                  group_by(type, year) %>%
                  summarise(total_emission=sum(Emissions))

TITLE = expression("Emissions from PM"[2.5]*" in Baltimore City by sources")
XLAB = ""
YLAB = "Total emission (in tones)"
THEME = theme(plot.margin=unit(c(1,1,1,1), "cm"),
              plot.title=element_text(vjust=2),
              axis.title.y=element_text(angle=90, vjust=2))

# View as a series of barplots
ggplot(baltimore_types,
       aes(x=as.factor(year), y=total_emission)) + 
  geom_bar(stat="identity", fill=BAR_COLOR, colour=BAR_BORDER_COLOR) + 
  facet_grid(. ~ type) +
  labs(title=TITLE, x=XLAB, y=YLAB) +
  THEME
ggsave("plot3.png")

# Alternative view - several lines on a plot
ggplot(baltimore_types,
       aes(x=year, y=total_emission, group=type, color=type)) +
  geom_line() +
  geom_point(size=4, shape=21, fill=POINT_FILL_COLOR) +
  labs(title=TITLE, x=XLAB, y=YLAB) +
  THEME
ggsave("plot3-alt.png")
