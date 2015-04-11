source("common.R")

names = unique(scc_mapping$Short.Name)
motor_names = names[grep("motor", names, ignore.case=TRUE)]
motor_mapping = scc_mapping %>% filter(Short.Name %in% motor_names)

motor_summary_baltimore = inventory %>%
                          filter(SCC %in% motor_mapping$SCC, fips == "24510") %>%
                          group_by(year) %>%
                          summarise(total_emission=sum(Emissions)) %>%
                          mutate(location="Baltimore City") %>%
                          mutate(diff=c(0, diff(total_emission)))

motor_summary_la = inventory %>%
                   filter(SCC %in% motor_mapping$SCC, fips == "06037") %>%
                   group_by(year) %>%
                   summarise(total_emission=sum(Emissions)) %>%
                   mutate(location="LA County") %>%
                   mutate(diff=c(0, diff(total_emission)))

combined_summary = rbind(motor_summary_baltimore, motor_summary_la) %>% tbl_df()

TITLE = expression(atop("Comparison of emissions from PM"[2.5]*" from motor vehicles in ",
                        "Baltimore City and Los Angeles County"))
XLAB = ""
YLAB = "Total emission (in tones)"
THEME = theme(plot.margin=unit(c(1,1,1,1), "cm"),
              plot.title=element_text(vjust=2),
              axis.title.y=element_text(angle=90, vjust=2))

# View as barplots
# Shows the absolute values
ggplot(combined_summary,
       aes(x=as.factor(location), y=total_emission, fill=as.factor(location))) + 
  geom_bar(stat="identity") + 
  facet_grid(. ~ year) +
  labs(title=TITLE, x=XLAB, y=YLAB) +
  scale_fill_discrete(name="Location") +
  THEME +
  theme(axis.text.x=element_blank(),
        axis.title.x=element_blank(),
        axis.ticks.x=element_blank())
ggsave("plot6.png")

# Alternative view - several lines on a plot
# Shows the changes over time
TITLE = expression(atop("Changes in emissions from PM"[2.5]*" from motor vehicles in ",
                        "Baltimore City and Los Angeles County"))
XLAB = ""
YLAB = "Change of total emission (in tones)"

ggplot(combined_summary,
       aes(x=year, y=diff, group=location, color=location)) +
  geom_line() +
  geom_point(size=4, shape=21, fill=POINT_FILL_COLOR) +
  scale_x_continuous(breaks=seq(min(combined_summary$year), max(combined_summary$year), by=3)) +
  labs(title=TITLE, x=XLAB, y=YLAB) +
  scale_color_discrete(name="Location") +
  THEME
ggsave("plot6-alt.png")
