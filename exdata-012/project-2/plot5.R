source("common.R")

names = unique(scc_mapping$Short.Name)
motor_names = names[grep("motor", names, ignore.case=TRUE)]
motor_mapping = scc_mapping %>% filter(Short.Name %in% motor_names)

motor_summary_baltimore = inventory %>%
                          filter(SCC %in% motor_mapping$SCC, fips == "24510") %>%
                          group_by(year) %>%
                          summarise(total_emission=sum(Emissions))

TITLE = expression("Emissions from PM"[2.5]*" in Baltimore City from motor vehicles")
XLAB = ""
YLAB = "Total emission (in tones)"
THEME = theme(plot.margin=unit(c(1,1,1,1), "cm"),
              plot.title=element_text(vjust=2),
              axis.title.y=element_text(angle=90, vjust=2))

# View as a barplot
ggplot(motor_summary_baltimore,
       aes(x=as.factor(year), y=total_emission)) + 
  geom_bar(stat="identity", fill=BAR_COLOR, colour=BAR_BORDER_COLOR) + 
  labs(title=TITLE, x=XLAB, y=YLAB) +
  THEME
ggsave("plot5.png")

# Alternative view - a line plot
ggplot(motor_summary_baltimore,
       aes(x=year, y=total_emission)) + 
  geom_line(colour=PLOT_LINE_COLOR) +
  geom_point(size=4, shape=21, fill=POINT_FILL_COLOR) +
  scale_x_continuous(breaks = seq(min(motor_summary_baltimore$year), max(motor_summary_baltimore$year), by=3)) +
  scale_y_continuous(limits=c(0, max(motor_summary_baltimore$total_emission))) +
  labs(title=TITLE, x=XLAB, y=YLAB) +
  THEME
ggsave("plot5-alt.png")
